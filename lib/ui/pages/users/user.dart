part of 'users.dart';

class _User extends StatelessWidget {
  const _User({Key? key, required this.user, required this.rootUser})
      : super(key: key);

  final User user;
  final bool rootUser;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showBrandBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return _UserDetails(user: user);
          },
        );
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
            SizedBox(width: 20),
            Flexible(
              child: rootUser
                  ? BrandText.h4Underlined(user.login)
                  : BrandText.h4(user.login),
            ),
          ],
        ),
      ),
    );
  }
}
