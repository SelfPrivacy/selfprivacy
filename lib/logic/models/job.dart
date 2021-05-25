import 'package:equatable/equatable.dart';
import 'package:selfprivacy/utils/password_generator2.dart';

class Job extends Equatable {
  Job({
    String? id,
    required this.title,
  }) : id = id ?? getRandomString(5);

  final String title;
  final String id;

  @override
  List<Object> get props => [id, title];
}
