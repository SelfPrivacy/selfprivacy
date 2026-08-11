import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

void main() {
  test('server-visible fields participate in equality', () {
    const base = User.fake(
      email: 'alice@example.test',
      displayName: 'Alice',
      directmemberof: ['sp.full_users'],
      memberof: ['sp.full_users'],
    );

    expect(
      base,
      isNot(
        const User.fake(
          email: 'alice@example.test',
          displayName: 'Alice',
          directmemberof: [],
          memberof: [],
        ),
      ),
    );
    expect(
      base,
      isNot(
        const User.fake(
          email: 'alice@example.test',
          displayName: 'Alice Cooper',
          directmemberof: ['sp.full_users'],
          memberof: ['sp.full_users'],
        ),
      ),
    );
  });
}
