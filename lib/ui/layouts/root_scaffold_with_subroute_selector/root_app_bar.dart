part of 'root_scaffold_with_subroute_selector.dart';

class _RootAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _RootAppBar({required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  Widget build(final BuildContext context) => AppBar(
    title: AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder:
          (final Widget child, final Animation<double> animation) =>
              SlideTransition(
                position: animation.drive(
                  Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero),
                ),
                child: FadeTransition(opacity: animation, child: child),
              ),
      child: SizedBox(
        key: ValueKey<String>(title),
        width: double.infinity,
        child: Text(
          title,
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.fade,
        ),
      ),
    ),
    leading:
        context.router.pageCount > 1
            ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.router.maybePop(),
            )
            : null,
    actions: const [SizedBox.shrink()],
  );
}
