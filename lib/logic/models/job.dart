import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
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
    this.message,
  }) : id = id ?? StringGenerators.simpleId();

  final String title;
  final String id;
  final bool requiresRebuild;

  final JobStatusEnum status;
  final String? message;

  bool canAddTo(final List<ClientJob> jobs) => true;
  Future<(bool, String)> execute(final JobsCubit cubit);

  @override
  List<Object> get props => [id, title, status];

  ClientJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  });
}

@Deprecated('Jobs bloc should handle it itself')
class RebuildServerJob extends ClientJob {
  RebuildServerJob({
    required super.title,
    super.id,
  });

  @override
  bool canAddTo(final List<ClientJob> jobs) =>
      !jobs.any((final job) => job is RebuildServerJob);

  @override
  Future<(bool, String)> execute(final JobsCubit cubit) async =>
      (false, 'unimplemented');

  @override
  RebuildServerJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) {
    throw UnimplementedError();
  }
}

class UpgradeServerJob extends ClientJob {
  UpgradeServerJob({
    super.status,
    super.message,
    super.id,
  }) : super(title: 'jobs.start_server_upgrade'.tr());

  @override
  bool canAddTo(final List<ClientJob> jobs) =>
      !jobs.any((final job) => job is UpgradeServerJob);

  @override
  Future<(bool, String)> execute(final JobsCubit cubit) async =>
      (false, 'unimplemented');

  @override
  UpgradeServerJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) =>
      UpgradeServerJob(
        status: status,
        message: message,
        id: id,
      );
}

class RebootServerJob extends ClientJob {
  RebootServerJob({
    super.status,
    super.message,
    super.id,
  }) : super(title: 'jobs.reboot_server'.tr(), requiresRebuild: false);

  @override
  bool canAddTo(final List<ClientJob> jobs) =>
      !jobs.any((final job) => job is RebootServerJob);

  @override
  Future<(bool, String)> execute(final JobsCubit cubit) async =>
      (false, 'unimplemented');

  @override
  RebootServerJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) =>
      RebootServerJob(
        status: status,
        message: message,
        id: id,
      );
}

class CreateUserJob extends ClientJob {
  CreateUserJob({
    required this.user,
    super.status,
    super.message,
    super.id,
  }) : super(title: '${"jobs.create_user".tr()} ${user.login}');

  final User user;

  @override
  Future<(bool, String)> execute(final JobsCubit cubit) async =>
      getIt<ApiConnectionRepository>().createUser(user);

  @override
  List<Object> get props => [...super.props, user];

  @override
  CreateUserJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) =>
      CreateUserJob(
        user: user,
        status: status,
        message: message,
        id: id,
      );
}

class ResetUserPasswordJob extends ClientJob {
  ResetUserPasswordJob({
    required this.user,
    super.status,
    super.message,
    super.id,
  }) : super(title: '${"jobs.reset_user_password".tr()} ${user.login}');

  final User user;

  @override
  Future<(bool, String)> execute(final JobsCubit cubit) async =>
      getIt<ApiConnectionRepository>().changeUserPassword(user, user.password!);

  @override
  List<Object> get props => [...super.props, user];

  @override
  ResetUserPasswordJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) =>
      ResetUserPasswordJob(
        user: user,
        status: status,
        message: message,
        id: id,
      );
}

class DeleteUserJob extends ClientJob {
  DeleteUserJob({
    required this.user,
    super.status,
    super.message,
    super.id,
  }) : super(title: '${"jobs.delete_user".tr()} ${user.login}');

  final User user;

  @override
  bool canAddTo(final List<ClientJob> jobs) => !jobs.any(
        (final job) => job is DeleteUserJob && job.user.login == user.login,
      );

  @override
  Future<(bool, String)> execute(final JobsCubit cubit) async =>
      getIt<ApiConnectionRepository>().deleteUser(user);

  @override
  List<Object> get props => [...super.props, user];

  @override
  DeleteUserJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) =>
      DeleteUserJob(
        user: user,
        status: status,
        message: message,
        id: id,
      );
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
        );

  final bool needToTurnOn;
  final Service service;

  @override
  bool canAddTo(final List<ClientJob> jobs) => !jobs.any(
        (final job) => job is ServiceToggleJob && job.service.id == service.id,
      );

  @override
  Future<(bool, String)> execute(final JobsCubit cubit) async {
    await cubit.api.switchService(service.id, needToTurnOn);
    return (true, 'Check not implemented');
  }

  @override
  List<Object> get props => [...super.props, service];

  @override
  ServiceToggleJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) =>
      ServiceToggleJob(
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
  Future<(bool, String)> execute(final JobsCubit cubit) async =>
      getIt<ApiConnectionRepository>().addSshKey(user, publicKey);

  @override
  List<Object> get props => [...super.props, user, publicKey];

  @override
  CreateSSHKeyJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) =>
      CreateSSHKeyJob(
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
  bool canAddTo(final List<ClientJob> jobs) => !jobs.any(
        (final job) =>
            job is DeleteSSHKeyJob &&
            job.publicKey == publicKey &&
            job.user.login == user.login,
      );

  @override
  Future<(bool, String)> execute(final JobsCubit cubit) async =>
      getIt<ApiConnectionRepository>().deleteSshKey(user, publicKey);

  @override
  List<Object> get props => [...super.props, user, publicKey];

  @override
  DeleteSSHKeyJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) =>
      DeleteSSHKeyJob(
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
  });

  bool shouldRemoveInsteadOfAdd(final List<ClientJob> jobs) => false;
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
  Future<(bool, String)> execute(final JobsCubit cubit) async {
    await cubit.api.setAutoUpgradeSettings(
      AutoUpgradeSettings(enable: enable, allowReboot: allowReboot),
    );
    return (true, 'Check not implemented');
  }

  @override
  bool shouldRemoveInsteadOfAdd(final List<ClientJob> jobs) {
    // TODO: Finish this
    throw UnimplementedError();
  }

  @override
  List<Object> get props => [...super.props, enable, allowReboot];

  @override
  ChangeAutoUpgradeSettingsJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) =>
      ChangeAutoUpgradeSettingsJob(
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
  Future<(bool, String)> execute(final JobsCubit cubit) async {
    await getIt<ApiConnectionRepository>().api.setTimezone(timezone);
    return (true, 'Check not implemented');
  }

  @override
  bool shouldRemoveInsteadOfAdd(final List<ClientJob> jobs) {
    // TODO: Finish this
    throw UnimplementedError();
  }

  @override
  List<Object> get props => [...super.props, timezone];

  @override
  ChangeServerTimezoneJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) =>
      ChangeServerTimezoneJob(
        timezone: timezone,
        status: status,
        message: message,
        id: id,
      );
}
