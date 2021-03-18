part of 'users.dart';

class _NoUsers extends StatelessWidget {
  const _NoUsers({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(BrandIcons.users, size: 50, color: BrandColors.grey7),
          SizedBox(height: 20),
          BrandText.h2(
            'users.nobody_here'.tr(),
            style: TextStyle(
              color: BrandColors.grey7,
            ),
          ),
          SizedBox(height: 10),
          BrandText.medium(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: BrandColors.grey7,
            ),
          ),
        ],
      ),
    );
  }
}
