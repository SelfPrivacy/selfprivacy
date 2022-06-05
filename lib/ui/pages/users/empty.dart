part of 'users.dart';

class _NoUsers extends StatelessWidget {
  const _NoUsers({required this.text});

  final String text;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(BrandIcons.users, size: 50, color: BrandColors.grey7),
            const SizedBox(height: 20),
            BrandText.h2(
              'users.nobody_here'.tr(),
              style: const TextStyle(
                color: BrandColors.grey7,
              ),
            ),
            const SizedBox(height: 10),
            BrandText.medium(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: BrandColors.grey7,
              ),
            ),
          ],
        ),
      );
}
