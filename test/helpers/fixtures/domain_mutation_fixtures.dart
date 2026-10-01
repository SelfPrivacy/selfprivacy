import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/users.graphql.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

import 'json_fixture.dart';

User aMutationUser(final String operation) => User.fromGraphQL(
  Fragment$userFields.fromJson(
    ((loadJsonFixture('graphql/mutation_results.json')[operation]
                    as Map<String, dynamic>)['users']
                as Map<String, dynamic>)
            .values
            .whereType<Map<String, dynamic>>()
            .single['user']
        as Map<String, dynamic>,
  ),
);

ServerJob aServiceMoveJob({
  final String? uid,
  final String? status,
  final DateTime? updatedAt,
}) {
  final operation =
      loadJsonFixture('graphql/mutation_results.json')['MoveService']
          as Map<String, dynamic>;
  final services = operation['services'] as Map<String, dynamic>;
  final mutation = services['moveService'] as Map<String, dynamic>;
  final json = mutation['job'] as Map<String, dynamic>;
  if (uid != null) {
    json['uid'] = uid;
  }
  if (status != null) {
    json['status'] = status;
  }
  if (updatedAt != null) {
    json['updatedAt'] = updatedAt.toIso8601String();
  }
  return ServerJob.fromGraphQL(Fragment$basicApiJobsFields.fromJson(json));
}

User aUserWithEmailPasswords() => User.fromGraphQL(
  Fragment$userFields.fromJson(
    loadJsonFixture('graphql/user_with_email_passwords.json'),
  ),
);
