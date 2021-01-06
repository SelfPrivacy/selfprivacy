part of 'users.dart';

class _User extends StatelessWidget {
  const _User({Key key, this.user}) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return _UserDetails(user: user);
          },
        );
      },
      child: Container(
        padding: brandPagePadding2,
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
            BrandText.h4(user.login),
          ],
        ),
      ),
    );
  }
}
