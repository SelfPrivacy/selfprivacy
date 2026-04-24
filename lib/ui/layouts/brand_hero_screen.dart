import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/ui/helpers/widget_size.dart';
import 'package:selfprivacy/ui/organisms/drawers/support_drawer.dart';
import 'package:selfprivacy/utils/breakpoints.dart';
import 'package:selfprivacy/utils/show_jobs_modal.dart';

class BrandHeroScreen extends StatelessWidget {
  const BrandHeroScreen({
    required this.children,
    super.key,
    this.hasBackButton = true,
    this.hasFlashButton = false,
    this.heroIcon,
    this.heroIconWidget,
    this.heroTitle = '',
    this.heroSubtitle,
    this.onBackButtonPressed,
    this.bodyPadding = const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    this.ignoreBreakpoints = false,
    this.hasSupportDrawer = false,
  });

  final List<Widget> children;
  final bool hasBackButton;
  final bool hasFlashButton;
  final IconData? heroIcon;
  final Widget? heroIconWidget;
  final String heroTitle;
  final String? heroSubtitle;
  final VoidCallback? onBackButtonPressed;
  final EdgeInsetsGeometry bodyPadding;

  /// On non-mobile screens the buttons of the app bar are hidden.
  /// This is because this widget implies that it is nested inside a bigger layout.
  /// If it is not nested, set this to true.
  final bool ignoreBreakpoints;

  /// Usually support drawer is provided by the parent layout.
  /// If it is not provided, set this to true.
  final bool hasSupportDrawer;

  @override
  Widget build(final BuildContext context) {
    final Widget heroIconWidget =
        this.heroIconWidget ??
        Icon(
          heroIcon ?? Icons.help,
          size: 48,
          color: Theme.of(context).colorScheme.onSurface,
        );
    final bool hasHeroIcon = heroIcon != null || this.heroIconWidget != null;

    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      endDrawer: hasSupportDrawer ? const SupportDrawer() : null,
      body: CustomScrollView(
        slivers: [
          HeroSliverAppBar(
            heroTitle: heroTitle,
            hasHeroIcon: hasHeroIcon,
            hasBackButton: hasBackButton,
            onBackButtonPressed: onBackButtonPressed,
            heroIconWidget: heroIconWidget,
            hasFlashButton: hasFlashButton,
            ignoreBreakpoints: ignoreBreakpoints,
          ),
          if (heroSubtitle != null)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Text(
                    heroSubtitle!,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]),
              ),
            ),
          SliverPadding(
            padding: bodyPadding,
            sliver: SliverList(delegate: SliverChildListDelegate(children)),
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
    required this.hasFlashButton,
    required this.ignoreBreakpoints,
    super.key,
  });

  final String heroTitle;
  final bool hasHeroIcon;
  final bool hasBackButton;
  final bool hasFlashButton;
  final VoidCallback? onBackButtonPressed;
  final Widget heroIconWidget;
  final bool ignoreBreakpoints;

  @override
  State<HeroSliverAppBar> createState() => _HeroSliverAppBarState();
}

class _HeroSliverAppBarState extends State<HeroSliverAppBar> {
  Size _size = Size.zero;
  @override
  Widget build(final BuildContext context) {
    final isMobile =
        widget.ignoreBreakpoints || Breakpoints.small.isActive(context);
    final isJobsListEmpty =
        !widget.hasFlashButton ||
        context.watch<JobsCubit>().state is JobsStateEmpty;
    return SliverAppBar(
      expandedHeight:
          widget.hasHeroIcon ? 148.0 + _size.height : 72.0 + _size.height,
      primary: true,
      pinned: isMobile,
      stretch: true,
      surfaceTintColor: isMobile ? null : Colors.transparent,
      leading:
          (widget.hasBackButton && isMobile)
              ? const AutoLeadingButton()
              : const SizedBox.shrink(),
      actions: [
        if (widget.hasFlashButton && isMobile)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: IconButton(
              onPressed: () async {
                await showModalJobsSheet(context: context);
              },
              icon: Icon(
                isJobsListEmpty ? Ionicons.flash_outline : Ionicons.flash,
              ),
              color:
                  isJobsListEmpty
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.primary,
              tooltip: 'jobs.title'.tr(),
            ),
          ),
        const SizedBox.shrink(),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: LayoutBuilder(
          builder:
              (final context, final constraints) => SizedBox(
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
        titlePadding: const EdgeInsets.only(bottom: 12, top: 16),
        background: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 72),
              if (widget.hasHeroIcon) widget.heroIconWidget,
            ],
          ),
        ),
      ),
    );
  }
}
