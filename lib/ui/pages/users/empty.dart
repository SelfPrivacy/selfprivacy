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
            Icon(
              BrandIcons.users,
              size: 50,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(height: 20),
            Text(
              'users.nobody_here'.tr(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
}

class _CouldNotLoadUsers extends StatelessWidget {
  const _CouldNotLoadUsers({required this.text});

  final String text;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              BrandIcons.users,
              size: 50,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(height: 20),
            Text(
              'users.could_not_fetch_users'.tr(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
}
