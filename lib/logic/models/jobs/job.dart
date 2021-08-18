import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/utils/password_generator.dart';

import '../user.dart';

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
  }) : super(title: 'Create ${user.login}');

  final User user;

  @override
  List<Object> get props => [id, title];
}
