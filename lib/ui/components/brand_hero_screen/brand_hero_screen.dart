import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/pre_styled_buttons/flash_fab.dart';

class BrandHeroScreen extends StatelessWidget {
  const BrandHeroScreen({
    required this.children,
    final super.key,
    this.hasBackButton = true,
    this.hasFlashButton = true,
    this.heroIcon,
    this.heroIconWidget,
    this.heroTitle = '',
    this.heroSubtitle,
    this.onBackButtonPressed,
  });

  final List<Widget> children;
  final bool hasBackButton;
  final bool hasFlashButton;
  final IconData? heroIcon;
  final Widget? heroIconWidget;
  final String heroTitle;
  final String? heroSubtitle;
  final VoidCallback? onBackButtonPressed;

  @override
  Widget build(final BuildContext context) {
    final Widget heroIconWidget = this.heroIconWidget ??
        Icon(
          heroIcon ?? Icons.help,
          size: 48.0,
          color: Theme.of(context).colorScheme.onBackground,
        );
    final bool hasHeroIcon = heroIcon != null || this.heroIconWidget != null;
    const EdgeInsetsGeometry heroTitlePadding = EdgeInsets.only(
      bottom: 12.0,
      top: 16.0,
    );

    return Scaffold(
      floatingActionButton: hasFlashButton ? const BrandFab() : null,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: hasHeroIcon ? 160.0 : 96.0,
            pinned: true,
            stretch: true,
            leading: hasBackButton
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: onBackButtonPressed ??
                        () => Navigator.of(context).pop(),
                  )
                : null,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                heroTitle,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              expandedTitleScale: 1.2,
              centerTitle: true,
              collapseMode: CollapseMode.pin,
              titlePadding: heroTitlePadding,
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (hasHeroIcon) heroIconWidget,
                ],
              ),
            ),
          ),
          if (heroSubtitle != null)
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4.0,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Text(
                    heroSubtitle!,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                    textAlign: hasHeroIcon ? TextAlign.center : TextAlign.start,
                  ),
                ]),
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(children),
            ),
          ),
        ],
      ),
    );
  }
}
