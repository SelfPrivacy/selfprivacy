import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/utils/password_generator.dart';

import 'package:selfprivacy/logic/models/hive/user.dart';

@immutable
abstract class ClientJob extends Equatable {
  ClientJob({
    required this.title,
    final String? id,
  }) : id = id ?? StringGenerators.simpleId();

  final String title;
  final String id;

  void execute(final JobsCubit cubit);

  @override
  List<Object> get props => [id, title];
}

class RebuildServerJob extends ClientJob {
  RebuildServerJob({
    required final super.title,
    final super.id,
  });

  @override
  void execute(final JobsCubit cubit) async {
    await cubit.upgradeServer();
  }
}

class CreateUserJob extends ClientJob {
  CreateUserJob({
    required this.user,
  }) : super(title: '${"jobs.create_user".tr()} ${user.login}');

  final User user;

  @override
  void execute(final JobsCubit cubit) async {
    await cubit.usersCubit.createUser(user);
  }

  @override
  List<Object> get props => [id, title, user];
}

class ResetUserPasswordJob extends ClientJob {
  ResetUserPasswordJob({
    required this.user,
  }) : super(title: '${"jobs.reset_user_password".tr()} ${user.login}');

  final User user;

  @override
  void execute(final JobsCubit cubit) async {
    await cubit.usersCubit.changeUserPassword(user, user.password!);
  }

  @override
  List<Object> get props => [id, title, user];
}

class DeleteUserJob extends ClientJob {
  DeleteUserJob({
    required this.user,
  }) : super(title: '${"jobs.delete_user".tr()} ${user.login}');

  final User user;

  @override
  void execute(final JobsCubit cubit) async {
    await cubit.usersCubit.deleteUser(user);
  }

  @override
  List<Object> get props => [id, title, user];
}

abstract class ToggleJob extends ClientJob {
  ToggleJob({
    required final this.service,
    required final super.title,
  });

  final Service service;

  @override
  List<Object> get props => [...super.props, service];
}

class ServiceToggleJob extends ToggleJob {
  ServiceToggleJob({
    required super.service,
    required this.needToTurnOn,
  }) : super(
          title:
              '${needToTurnOn ? "jobs.service_turn_on".tr() : "jobs.service_turn_off".tr()} ${service.displayName}',
        );

  @override
  void execute(final JobsCubit cubit) async {
    await cubit.api.switchService(service.id, needToTurnOn);
  }

  final bool needToTurnOn;
}

class CreateSSHKeyJob extends ClientJob {
  CreateSSHKeyJob({
    required this.user,
    required this.publicKey,
  }) : super(title: 'jobs.create_ssh_key'.tr(args: [user.login]));

  final User user;
  final String publicKey;

  @override
  void execute(final JobsCubit cubit) async {
    await cubit.usersCubit.addSshKey(user, publicKey);
  }

  @override
  List<Object> get props => [id, title, user, publicKey];
}

class DeleteSSHKeyJob extends ClientJob {
  DeleteSSHKeyJob({
    required this.user,
    required this.publicKey,
  }) : super(title: 'jobs.delete_ssh_key'.tr(args: [user.login]));

  final User user;
  final String publicKey;

  @override
  void execute(final JobsCubit cubit) async {
    await cubit.usersCubit.deleteSshKey(user, publicKey);
  }

  @override
  List<Object> get props => [id, title, user, publicKey];
}
