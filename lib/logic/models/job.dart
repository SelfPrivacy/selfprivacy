import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/utils/password_generator.dart';

import 'package:selfprivacy/logic/models/hive/user.dart';

@immutable
class ClientJob extends Equatable {
  ClientJob({
    required this.title,
    final String? id,
  }) : id = id ?? StringGenerators.simpleId();

  final String title;
  final String id;

  @override
  List<Object> get props => [id, title];
}

class RebuildServerJob extends ClientJob {
  RebuildServerJob({
    required final super.title,
    final super.id,
  });
}

class CreateUserJob extends ClientJob {
  CreateUserJob({
    required this.user,
  }) : super(title: '${"jobs.create_user".tr()} ${user.login}');

  final User user;

  @override
  List<Object> get props => [id, title, user];
}

class ResetUserPasswordJob extends ClientJob {
  ResetUserPasswordJob({
    required this.user,
  }) : super(title: '${"jobs.reset_user_password".tr()} ${user.login}');

  final User user;

  @override
  List<Object> get props => [id, title, user];
}

class DeleteUserJob extends ClientJob {
  DeleteUserJob({
    required this.user,
  }) : super(title: '${"jobs.delete_user".tr()} ${user.login}');

  final User user;

  @override
  List<Object> get props => [id, title, user];
}

class ToggleJob extends ClientJob {
  ToggleJob({
    required this.type,
    required final super.title,
  });

  final ServiceTypes type;

  @override
  List<Object> get props => [...super.props, type];
}

class ServiceToggleJob extends ToggleJob {
  ServiceToggleJob({
    required final super.type,
    required this.needToTurnOn,
  }) : super(
          title:
              '${needToTurnOn ? "jobs.service_turn_on".tr() : "jobs.service_turn_off".tr()} ${type.title}',
        );

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
  List<Object> get props => [id, title, user, publicKey];
}
