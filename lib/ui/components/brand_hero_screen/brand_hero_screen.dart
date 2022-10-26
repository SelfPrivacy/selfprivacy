import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/pre_styled_buttons/flash_fab.dart';
import 'package:selfprivacy/ui/helpers/widget_size.dart';

class BrandHeroScreen extends StatelessWidget {
  const BrandHeroScreen({
    required this.children,
    super.key,
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

    return Scaffold(
      floatingActionButton: hasFlashButton ? const BrandFab() : null,
      body: CustomScrollView(
        slivers: [
          HeroSliverAppBar(
            heroTitle: heroTitle,
            hasHeroIcon: hasHeroIcon,
            hasBackButton: hasBackButton,
            onBackButtonPressed: onBackButtonPressed,
            heroIconWidget: heroIconWidget,
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

class HeroSliverAppBar extends StatefulWidget {
  const HeroSliverAppBar({
    required this.heroTitle,
    required this.hasHeroIcon,
    required this.hasBackButton,
    required this.onBackButtonPressed,
    required this.heroIconWidget,
    super.key,
  });

  final String heroTitle;
  final bool hasHeroIcon;
  final bool hasBackButton;
  final VoidCallback? onBackButtonPressed;
  final Widget heroIconWidget;

  @override
  State<HeroSliverAppBar> createState() => _HeroSliverAppBarState();
}

class _HeroSliverAppBarState extends State<HeroSliverAppBar> {
  Size _size = Size.zero;
  @override
  Widget build(final BuildContext context) => SliverAppBar(
        expandedHeight:
            widget.hasHeroIcon ? 148.0 + _size.height : 72.0 + _size.height,
        primary: true,
        pinned: true,
        stretch: true,
        leading: widget.hasBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: widget.onBackButtonPressed ??
                    () => Navigator.of(context).pop(),
              )
            : null,
        flexibleSpace: FlexibleSpaceBar(
          title: LayoutBuilder(
            builder: (final context, final constraints) => SizedBox(
              width: constraints.maxWidth - 72.0,
              child: WidgetSize(
                onChange: (final Size size) => setState(() => _size = size),
                child: Text(
                  widget.heroTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          expandedTitleScale: 1.2,
          centerTitle: true,
          collapseMode: CollapseMode.pin,
          titlePadding: const EdgeInsets.only(
            bottom: 12.0,
            top: 16.0,
          ),
          background: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 72.0),
              if (widget.hasHeroIcon) widget.heroIconWidget,
            ],
          ),
        ),
      );
}
