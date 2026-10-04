import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';
import 'package:selfprivacy/utils/password_generator.dart';

@immutable
abstract class JobDraft extends Equatable {
  JobDraft({
    required this.title,
    final String? id,
    this.requiresRebuild = true,
    this.requiresDnsUpdate = false,
  }) : id = id ?? StringGenerators.simpleId();

  final String title;
  final String id;
  final bool requiresRebuild;
  final bool requiresDnsUpdate;

  bool canAddTo(final List<JobDraft> jobs) => true;

  @override
  List<Object> get props => [id, title];
}

class UpgradeServerJob extends JobDraft {
  UpgradeServerJob({super.id}) : super(title: 'jobs.start_server_upgrade'.tr());

  @override
  bool canAddTo(final List<JobDraft> jobs) =>
      !jobs.any((final job) => job is UpgradeServerJob);
}

class UpdateDnsRecordsJob extends JobDraft {
  UpdateDnsRecordsJob()
    : super(title: 'jobs.update_dns_records'.tr(), id: jobId);

  static String jobId = 'dns_update';

  @override
  bool canAddTo(final List<JobDraft> jobs) =>
      !jobs.any((final job) => job is UpdateDnsRecordsJob);
}

class CollectNixGarbageJob extends JobDraft {
  CollectNixGarbageJob({super.id})
    : super(title: 'jobs.collect_nix_garbage'.tr());

  @override
  bool canAddTo(final List<JobDraft> jobs) =>
      !jobs.any((final job) => job is CollectNixGarbageJob);
}

class RebootServerJob extends JobDraft {
  RebootServerJob({super.id})
    : super(title: 'jobs.reboot_server'.tr(), requiresRebuild: false);

  @override
  bool canAddTo(final List<JobDraft> jobs) =>
      !jobs.any((final job) => job is RebootServerJob);
}

class DeleteUserJob extends JobDraft {
  DeleteUserJob({required this.user, super.id})
    : super(title: '${"jobs.delete_user".tr()} ${user.login}');

  final User user;

  @override
  bool canAddTo(final List<JobDraft> jobs) => !jobs.any(
    (final job) => job is DeleteUserJob && job.user.login == user.login,
  );

  @override
  List<Object> get props => [...super.props, user];
}

class ServiceToggleJob extends JobDraft {
  ServiceToggleJob({required this.service, required this.needToTurnOn, super.id})
    : super(
        title:
            '${needToTurnOn ? "jobs.service_turn_on".tr() : "jobs.service_turn_off".tr()} ${service.displayName}',
        requiresDnsUpdate: true,
      );

  final bool needToTurnOn;
  final Service service;

  @override
  bool canAddTo(final List<JobDraft> jobs) => !jobs.any(
    (final job) => job is ServiceToggleJob && job.service.id == service.id,
  );

  @override
  List<Object> get props => [...super.props, service];
}

class CreateSSHKeyJob extends JobDraft {
  CreateSSHKeyJob({required this.user, required this.publicKey, super.id})
    : super(title: 'jobs.create_ssh_key'.tr(args: [user.login]));

  final User user;
  final String publicKey;

  @override
  List<Object> get props => [...super.props, user, publicKey];
}

class DeleteSSHKeyJob extends JobDraft {
  DeleteSSHKeyJob({required this.user, required this.publicKey, super.id})
    : super(title: 'jobs.delete_ssh_key'.tr(args: [user.login]));

  final User user;
  final String publicKey;

  @override
  bool canAddTo(final List<JobDraft> jobs) => !jobs.any(
    (final job) =>
        job is DeleteSSHKeyJob &&
        job.publicKey == publicKey &&
        job.user.login == user.login,
  );

  @override
  List<Object> get props => [...super.props, user, publicKey];
}

abstract class ReplaceableJobDraft extends JobDraft {
  ReplaceableJobDraft({
    required super.title,
    super.id,
    super.requiresRebuild,
    super.requiresDnsUpdate,
  });

  bool matchesSettings(final SystemSettings? settings) => false;
  bool get shouldReplaceOnlyIfSameId => false;
}

class ChangeAutoUpgradeSettingsJob extends ReplaceableJobDraft {
  ChangeAutoUpgradeSettingsJob({
    required this.enable,
    required this.allowReboot,
    super.id,
  }) : super(title: 'jobs.change_auto_upgrade_settings'.tr());

  final bool enable;
  final bool allowReboot;

  @override
  bool matchesSettings(final SystemSettings? settings) {
    final currentSettings = settings?.autoUpgradeSettings;
    if (currentSettings == null) {
      return false;
    }
    return currentSettings.enable == enable &&
        currentSettings.allowReboot == allowReboot;
  }

  @override
  List<Object> get props => [...super.props, enable, allowReboot];
}

class ChangeServerTimezoneJob extends ReplaceableJobDraft {
  ChangeServerTimezoneJob({required this.timezone, super.id})
    : super(title: 'jobs.change_server_timezone'.tr());

  final String timezone;

  @override
  bool matchesSettings(final SystemSettings? settings) {
    final currentSettings = settings?.timezone;
    if (currentSettings == null) {
      return false;
    }
    return currentSettings == timezone;
  }

  @override
  List<Object> get props => [...super.props, timezone];
}

class ChangeSshSettingsJob extends ReplaceableJobDraft {
  ChangeSshSettingsJob({required this.enable, super.id})
    : super(title: 'jobs.change_ssh_settings'.tr());

  final bool enable;

  @override
  bool matchesSettings(final SystemSettings? settings) {
    final currentSettings = settings?.sshSettings;
    if (currentSettings == null) {
      return false;
    }
    return currentSettings.enable == enable;
  }

  @override
  List<Object> get props => [...super.props, enable];
}

class ChangeServiceConfiguration extends ReplaceableJobDraft {
  ChangeServiceConfiguration({
    required this.serviceId,
    required this.serviceDisplayName,
    required final Map<String, dynamic> settings,
  }) : settings = Map<String, dynamic>.unmodifiable(
         settings.map(
           (final key, final value) => MapEntry(key, _copyConfiguration(value)),
         ),
       ),
       super(
         title: 'jobs.change_service_settings'.tr(args: [serviceDisplayName]),
         id: 'change_settings_$serviceId',
         requiresDnsUpdate: true,
         requiresRebuild: true,
       );

  final String serviceId;
  final String serviceDisplayName;
  final Map<String, dynamic> settings;

  static Object? _copyConfiguration(final Object? value) => switch (value) {
    Map<String, dynamic>() => Map<String, dynamic>.unmodifiable(
      value.map(
        (final key, final value) => MapEntry(key, _copyConfiguration(value)),
      ),
    ),
    List() => List<Object?>.unmodifiable(value.map(_copyConfiguration)),
    _ => value,
  };

  @override
  bool get shouldReplaceOnlyIfSameId => true;

  @override
  List<Object> get props => [...super.props, serviceId, settings];
}
