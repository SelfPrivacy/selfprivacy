import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/utils/password_generator.dart';

@immutable
abstract class ClientJob extends Equatable {
  ClientJob({
    required this.title,
    final String? id,
    this.requiresRebuild = true,
    this.status = JobStatusEnum.created,
    this.requiresDnsUpdate = false,
    this.message,
  }) : id = id ?? StringGenerators.simpleId();

  final String title;
  final String id;
  final bool requiresRebuild;
  final bool requiresDnsUpdate;

  final JobStatusEnum status;
  final String? message;

  bool canAddTo(final List<ClientJob> jobs) => true;
  Future<(bool, String)> execute();

  @override
  List<Object> get props => [id, title, status];

  ClientJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  });
}

class UpgradeServerJob extends ClientJob {
  UpgradeServerJob({super.status, super.message, super.id})
    : super(title: 'jobs.start_server_upgrade'.tr());

  @override
  bool canAddTo(final List<ClientJob> jobs) =>
      !jobs.any((final job) => job is UpgradeServerJob);

  @override
  Future<(bool, String)> execute() async => (false, 'unimplemented');

  @override
  UpgradeServerJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) => UpgradeServerJob(status: status, message: message, id: id);
}

class UpdateDnsRecordsJob extends ClientJob {
  UpdateDnsRecordsJob({super.status, super.message})
    : super(title: 'jobs.update_dns_records'.tr(), id: jobId);

  static String jobId = 'dns_update';

  @override
  bool canAddTo(final List<ClientJob> jobs) =>
      !jobs.any((final job) => job is UpdateDnsRecordsJob);

  @override
  Future<(bool, String)> execute() async => (false, 'unimplemented');

  @override
  UpdateDnsRecordsJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) => UpdateDnsRecordsJob(status: status, message: message);
}

class CollectNixGarbageJob extends ClientJob {
  CollectNixGarbageJob({super.status, super.message, super.id})
    : super(title: 'jobs.collect_nix_garbage'.tr());

  @override
  bool canAddTo(final List<ClientJob> jobs) =>
      !jobs.any((final job) => job is CollectNixGarbageJob);

  @override
  Future<(bool, String)> execute() async {
    final result =
        await getIt<ApiConnectionRepository>().api.collectNixGarbage();
    return (result.success, result.message ?? '');
  }

  @override
  CollectNixGarbageJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) => CollectNixGarbageJob(status: status, message: message, id: id);
}

class RebootServerJob extends ClientJob {
  RebootServerJob({super.status, super.message, super.id})
    : super(title: 'jobs.reboot_server'.tr(), requiresRebuild: false);

  @override
  bool canAddTo(final List<ClientJob> jobs) =>
      !jobs.any((final job) => job is RebootServerJob);

  @override
  Future<(bool, String)> execute() async => (false, 'unimplemented');

  @override
  RebootServerJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) => RebootServerJob(status: status, message: message, id: id);
}

class DeleteUserJob extends ClientJob {
  DeleteUserJob({required this.user, super.status, super.message, super.id})
    : super(title: '${"jobs.delete_user".tr()} ${user.login}');

  final User user;

  @override
  bool canAddTo(final List<ClientJob> jobs) =>
      !jobs.any(
        (final job) => job is DeleteUserJob && job.user.login == user.login,
      );

  @override
  Future<(bool, String)> execute() =>
      getIt<ApiConnectionRepository>().deleteUser(user);

  @override
  List<Object> get props => [...super.props, user];

  @override
  DeleteUserJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) => DeleteUserJob(user: user, status: status, message: message, id: id);
}

class ServiceToggleJob extends ClientJob {
  ServiceToggleJob({
    required this.service,
    required this.needToTurnOn,
    super.status,
    super.message,
    super.id,
  }) : super(
         title:
             '${needToTurnOn ? "jobs.service_turn_on".tr() : "jobs.service_turn_off".tr()} ${service.displayName}',
         requiresDnsUpdate: true,
       );

  final bool needToTurnOn;
  final Service service;

  @override
  bool canAddTo(final List<ClientJob> jobs) =>
      !jobs.any(
        (final job) => job is ServiceToggleJob && job.service.id == service.id,
      );

  @override
  Future<(bool, String)> execute() async {
    final result = await getIt<ApiConnectionRepository>().api.switchService(
      serviceId: service.id,
      needTurnOn: needToTurnOn,
    );
    return (result.success, result.message ?? 'jobs.generic_error'.tr());
  }

  @override
  List<Object> get props => [...super.props, service];

  @override
  ServiceToggleJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) => ServiceToggleJob(
    service: service,
    needToTurnOn: needToTurnOn,
    status: status,
    message: message,
    id: id,
  );
}

class CreateSSHKeyJob extends ClientJob {
  CreateSSHKeyJob({
    required this.user,
    required this.publicKey,
    super.status,
    super.message,
    super.id,
  }) : super(title: 'jobs.create_ssh_key'.tr(args: [user.login]));

  final User user;
  final String publicKey;

  @override
  Future<(bool, String)> execute() =>
      getIt<ApiConnectionRepository>().addSshKey(user, publicKey);

  @override
  List<Object> get props => [...super.props, user, publicKey];

  @override
  CreateSSHKeyJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) => CreateSSHKeyJob(
    user: user,
    publicKey: publicKey,
    status: status,
    message: message,
    id: id,
  );
}

class DeleteSSHKeyJob extends ClientJob {
  DeleteSSHKeyJob({
    required this.user,
    required this.publicKey,
    super.status,
    super.message,
    super.id,
  }) : super(title: 'jobs.delete_ssh_key'.tr(args: [user.login]));

  final User user;
  final String publicKey;

  @override
  bool canAddTo(final List<ClientJob> jobs) =>
      !jobs.any(
        (final job) =>
            job is DeleteSSHKeyJob &&
            job.publicKey == publicKey &&
            job.user.login == user.login,
      );

  @override
  Future<(bool, String)> execute() =>
      getIt<ApiConnectionRepository>().deleteSshKey(user, publicKey);

  @override
  List<Object> get props => [...super.props, user, publicKey];

  @override
  DeleteSSHKeyJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) => DeleteSSHKeyJob(
    user: user,
    publicKey: publicKey,
    status: status,
    message: message,
    id: id,
  );
}

abstract class ReplaceableJob extends ClientJob {
  ReplaceableJob({
    required super.title,
    super.id,
    super.status,
    super.message,
    super.requiresRebuild,
    super.requiresDnsUpdate,
  });

  bool shouldRemoveInsteadOfAdd(final List<ClientJob> jobs) => false;
  bool get shouldReplaceOnlyIfSameId => false;
}

class ChangeAutoUpgradeSettingsJob extends ReplaceableJob {
  ChangeAutoUpgradeSettingsJob({
    required this.enable,
    required this.allowReboot,
    super.status,
    super.message,
    super.id,
  }) : super(title: 'jobs.change_auto_upgrade_settings'.tr());

  final bool enable;
  final bool allowReboot;

  @override
  Future<(bool, String)> execute() => getIt<ApiConnectionRepository>()
      .setAutoUpgradeSettings(enable: enable, allowReboot: allowReboot);

  @override
  bool shouldRemoveInsteadOfAdd(final List<ClientJob> jobs) {
    final currentSettings =
        getIt<ApiConnectionRepository>()
            .apiData
            .settings
            .data
            ?.autoUpgradeSettings;
    if (currentSettings == null) {
      return false;
    }
    return currentSettings.enable == enable &&
        currentSettings.allowReboot == allowReboot;
  }

  @override
  List<Object> get props => [...super.props, enable, allowReboot];

  @override
  ChangeAutoUpgradeSettingsJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) => ChangeAutoUpgradeSettingsJob(
    enable: enable,
    allowReboot: allowReboot,
    status: status,
    message: message,
    id: id,
  );
}

class ChangeServerTimezoneJob extends ReplaceableJob {
  ChangeServerTimezoneJob({
    required this.timezone,
    super.status,
    super.message,
    super.id,
  }) : super(title: 'jobs.change_server_timezone'.tr());

  final String timezone;

  @override
  Future<(bool, String)> execute() =>
      getIt<ApiConnectionRepository>().setServerTimezone(timezone);

  @override
  bool shouldRemoveInsteadOfAdd(final List<ClientJob> jobs) {
    final currentSettings =
        getIt<ApiConnectionRepository>().apiData.settings.data?.timezone;
    if (currentSettings == null) {
      return false;
    }
    return currentSettings == timezone;
  }

  @override
  List<Object> get props => [...super.props, timezone];

  @override
  ChangeServerTimezoneJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) => ChangeServerTimezoneJob(
    timezone: timezone,
    status: status,
    message: message,
    id: id,
  );
}

class ChangeSshSettingsJob extends ReplaceableJob {
  ChangeSshSettingsJob({
    required this.enable,
    super.status,
    super.message,
    super.id,
  }) : super(title: 'jobs.change_ssh_settings'.tr());

  final bool enable;

  @override
  Future<(bool, String)> execute() =>
      getIt<ApiConnectionRepository>().setSshSettings(enable: enable);

  @override
  bool shouldRemoveInsteadOfAdd(final List<ClientJob> jobs) {
    final currentSettings =
        getIt<ApiConnectionRepository>().apiData.settings.data?.sshSettings;
    if (currentSettings == null) {
      return false;
    }
    return currentSettings.enable == enable;
  }

  @override
  List<Object> get props => [...super.props, enable];

  @override
  ChangeSshSettingsJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) => ChangeSshSettingsJob(
    enable: enable,
    status: status,
    message: message,
    id: id,
  );
}

class ChangeServiceConfiguration extends ReplaceableJob {
  ChangeServiceConfiguration({
    required this.serviceId,
    required this.serviceDisplayName,
    required this.settings,
    super.status,
    super.message,
  }) : super(
         title: 'jobs.change_service_settings'.tr(args: [serviceDisplayName]),
         id: 'change_settings_$serviceId',
         requiresDnsUpdate: true,
         requiresRebuild: true,
       );

  final String serviceId;
  final String serviceDisplayName;
  final Map<String, dynamic> settings;

  @override
  bool get shouldReplaceOnlyIfSameId => true;

  @override
  Future<(bool, String)> execute() => getIt<ApiConnectionRepository>()
      .setServiceConfiguration(serviceId, settings);

  @override
  List<Object> get props => [...super.props, serviceId, settings];

  @override
  ChangeServiceConfiguration copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) => ChangeServiceConfiguration(
    serviceId: serviceId,
    serviceDisplayName: serviceDisplayName,
    settings: settings,
    status: status,
    message: message,
  );
}
