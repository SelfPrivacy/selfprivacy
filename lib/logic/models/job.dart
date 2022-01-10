import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/utils/password_generator.dart';
import 'package:easy_localization/easy_localization.dart';

import 'user.dart';

@immutable
class Job extends Equatable {
  Job({
    String? id,
    required this.title,
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

class ServiceToggleJob extends Job {
  ServiceToggleJob({
    required this.type,
    required this.needToTurnOn,
  }) : super(
            title:
                '${needToTurnOn ? "jobs.serviceTurnOn".tr() : "jobs.serviceTurnOff".tr()} ${type.title}');

  final ServiceTypes type;
  final bool needToTurnOn;

  @override
  List<Object> get props => [id, title, type, needToTurnOn];
}

class CreateSSHKeyJob extends Job {
  CreateSSHKeyJob() : super(title: '${"more.create_ssh_key".tr()}');

  @override
  List<Object> get props => [id, title];
}
