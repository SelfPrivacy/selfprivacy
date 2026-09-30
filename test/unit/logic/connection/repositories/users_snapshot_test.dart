import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/bloc/users/users_bloc.dart';

import '../../../../helpers/fixtures/domain_mutation_fixtures.dart';

void main() {
  test(
    'user state owns its supplied snapshot without global repository reads',
    () {
      final user = aMutationUser('CreateUser');
      final source = [user];
      final state = UsersLoaded(users: source);
      source.clear();
      expect(state.users, [user]);
      expect(state.users.single, same(user));
      expect(state.users.clear, throwsUnsupportedError);
    },
  );
}
