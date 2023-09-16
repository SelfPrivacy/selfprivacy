part of 'users.dart';

class _User extends StatelessWidget {
  const _User({
    required this.user,
    required this.isUserPrimary,
  });

  final User user;
  final bool isUserPrimary;
  @override
  Widget build(final BuildContext context) => InkWell(
        onTap: () {
          context.pushRoute(UserDetailsRoute(login: user.login));
        },
        child: Container(
          padding: paddingH15V0,
          height: 48,
          child: Row(
            children: [
              Container(
                width: 17,
                height: 17,
                decoration: BoxDecoration(
                  color: user.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: Text(
                  user.login,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        decoration: isUserPrimary
                            ? TextDecoration.underline
                            : user.isFoundOnServer
                                ? TextDecoration.none
                                : TextDecoration.lineThrough,
                      ),
                ),
              ),
            ],
          ),
        ),
      );
}
