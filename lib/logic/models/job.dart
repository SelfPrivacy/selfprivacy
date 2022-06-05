// ignore_for_file: always_specify_types

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/utils/password_generator.dart';

import 'package:selfprivacy/logic/models/hive/user.dart';

@immutable
class Job extends Equatable {
  Job({
    required this.title,
    final String? id,
  }) : id = id ?? StringGenerators.simpleId();

  final String title;
  final String id;

  @override
  List<Object> get props => [id, title];
}

class CreateUserJob extends Job {
  CreateUserJob({
    required this.user,
  }) : super(title: '${"jobs.createUser".tr()} ${user.login}');

  final User user;

  @override
  List<Object> get props => [id, title, user];
}

class DeleteUserJob extends Job {
  DeleteUserJob({
    required this.user,
  }) : super(title: '${"jobs.deleteUser".tr()} ${user.login}');

  final User user;

  @override
  List<Object> get props => [id, title, user];
}

class ToggleJob extends Job {
  ToggleJob({
    required this.type,
    required final super.title,
  });

  final dynamic type;

  @override
  List<Object> get props => [...super.props, type];
}

class ServiceToggleJob extends ToggleJob {
  ServiceToggleJob({
    required final ServiceTypes super.type,
    required this.needToTurnOn,
  }) : super(
          title:
              '${needToTurnOn ? "jobs.serviceTurnOn".tr() : "jobs.serviceTurnOff".tr()} ${type.title}',
        );

  final bool needToTurnOn;
}

class CreateSSHKeyJob extends Job {
  CreateSSHKeyJob({
    required this.user,
    required this.publicKey,
  }) : super(title: 'jobs.create_ssh_key'.tr(args: [user.login]));

  final User user;
  final String publicKey;

  @override
  List<Object> get props => [id, title, user, publicKey];
}

class DeleteSSHKeyJob extends Job {
  DeleteSSHKeyJob({
    required this.user,
    required this.publicKey,
  }) : super(title: 'jobs.delete_ssh_key'.tr(args: [user.login]));

  final User user;
  final String publicKey;

  @override
  List<Object> get props => [id, title, user, publicKey];
}
