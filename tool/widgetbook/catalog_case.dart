import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:widgetbook/widgetbook.dart';
import 'fixtures.dart';
import 'preparation.dart';

String textKnob(final BuildContext context, final String initial) =>
    WidgetbookState.maybeOf(context) == null
    ? initial
    : context.knobs.string(label: 'Text', initialValue: initial);
double numberKnob(final BuildContext context, final double initial) =>
    WidgetbookState.maybeOf(context) == null
    ? initial
    : context.knobs.double.slider(
        label: 'Value',
        initialValue: initial,
        min: 0,
        max: 1,
      );

class CatalogActions extends ValueNotifier<List<String>> {
  CatalogActions() : super([]);
  void record(final String action) => value = [...value, action];
}

final catalogActions = CatalogActions();

class CatalogRouter extends Mock implements StackRouter {
  @override
  Future<T?> push<T extends Object?>(
    final PageRouteInfo route, {
    final OnNavigationFailure? onFailure,
  }) async {
    catalogActions.record('Navigate: ${route.routeName}');
    return null;
  }

  @override
  Future<bool> maybePop<T extends Object?>([final T? result]) async {
    catalogActions.record('Back');
    return false;
  }
}

enum PreviewHost {
  content,
  viewport,
  screen,
  scroll,
  dialog,
  sheet,
  drawer,
  header,
}

const catalogContentKey = ValueKey('catalog-content');

typedef CaseBuilder =
    Widget Function(
      BuildContext context,
      CatalogFixtures fixtures,
      ScrollController controller,
      void Function(VoidCallback) update,
    );

class CatalogCase extends StatefulWidget {
  const CatalogCase({
    required this.id,
    required this.variant,
    required this.builder,
    this.prepare,
    this.host = PreviewHost.content,
    this.width = 560,
    this.height = 400,
    super.key,
  });
  final PreviewAction? prepare;
  final String id;
  final String variant;
  final CaseBuilder builder;
  final PreviewHost host;
  final double width;
  final double height;
  @override
  State<CatalogCase> createState() => _CatalogCaseState();
}

class _CatalogCaseState extends State<CatalogCase> {
  late CatalogFixtures fixtures;
  final controller = ScrollController();
  final navigation = NavigationService();
  final router = CatalogRouter();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late String scope;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        catalogActions.value = [];
      }
    });
    scope = 'widgetbook-${identityHashCode(this)}';
    getIt.pushNewScope(
      scopeName: scope,
      init: (final locator) =>
          locator.registerSingleton<NavigationService>(navigation),
    );
    fixtures = CatalogFixtures(widget.variant, catalogActions.record);
  }

  @override
  void didUpdateWidget(final CatalogCase oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      fixtures.dispose();
      fixtures = CatalogFixtures(widget.variant, catalogActions.record);
    }
  }

  @override
  void dispose() {
    fixtures.dispose();
    controller.dispose();
    unawaited(getIt.dropScope(scope));
    super.dispose();
  }

  Widget component(final BuildContext context) {
    final child = widget.builder(context, fixtures, controller, setState);
    return widget.prepare == null
        ? child
        : PreparedPreview(
            key: ValueKey(widget.id),
            action: widget.prepare!,
            child: child,
          );
  }

  void open(final BuildContext context) {
    switch (widget.host) {
      case PreviewHost.dialog:
        unawaited(showDialog<void>(context: context, builder: component));
      case PreviewHost.sheet:
        unawaited(
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (final context) =>
                SizedBox(height: widget.height - 56, child: component(context)),
          ),
        );
      case PreviewHost.drawer:
        scaffoldKey.currentState!.openEndDrawer();
      case PreviewHost.content:
      case PreviewHost.viewport:
      case PreviewHost.screen:
      case PreviewHost.scroll:
      case PreviewHost.header:
        break;
    }
  }

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    return SizedBox(
      width: WidgetbookState.maybeOf(context) == null
          ? widget.width
          : context.knobs.double.slider(
              label: 'Preview width',
              initialValue: widget.width,
              min: 320,
              max: 1200,
            ),
      height: widget.height,
      child: fixtures.wrap(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          navigatorKey: navigation.navigatorKey,
          scaffoldMessengerKey: navigation.scaffoldMessengerKey,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          builder: (final context, final child) => LayoutBuilder(
            builder: (final context, final constraints) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: media.textScaler,
                size: constraints.biggest,
              ),
              child: StackRouterScope(
                controller: router,
                stateHash: 0,
                child: child!,
              ),
            ),
          ),
          home: Builder(
            builder: (final context) {
              final overlay = [
                PreviewHost.dialog,
                PreviewHost.sheet,
                PreviewHost.drawer,
              ].contains(widget.host);
              return Scaffold(
                key: scaffoldKey,
                appBar: widget.host == PreviewHost.header
                    ? component(context) as PreferredSizeWidget
                    : null,
                endDrawer: widget.host == PreviewHost.drawer
                    ? component(context)
                    : null,
                body: overlay
                    ? _OpenPreview(
                        key: ValueKey(widget.id),
                        open: () => open(context),
                      )
                    : widget.host == PreviewHost.screen
                    ? component(context)
                    : widget.host == PreviewHost.content
                    ? SingleChildScrollView(
                        child: RepaintBoundary(
                          key: catalogContentKey,
                          child: ColoredBox(
                            color: theme.scaffoldBackgroundColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 24,
                              ),
                              child: Align(
                                alignment: Alignment.topCenter,
                                heightFactor: 1,
                                child: component(context),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16),
                        child: widget.host == PreviewHost.scroll
                            ? SingleChildScrollView(child: component(context))
                            : widget.host == PreviewHost.header
                            ? const SizedBox.expand()
                            : Align(
                                alignment: Alignment.topCenter,
                                child: component(context),
                              ),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _OpenPreview extends StatefulWidget {
  const _OpenPreview({required this.open, super.key});
  final VoidCallback open;
  @override
  State<_OpenPreview> createState() => _OpenPreviewState();
}

class _OpenPreviewState extends State<_OpenPreview> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.open();
      }
    });
  }

  @override
  Widget build(final BuildContext context) => Center(
    child: OutlinedButton(
      onPressed: widget.open,
      child: const Text('Open preview'),
    ),
  );
}
