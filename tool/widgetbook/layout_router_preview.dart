import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/router/root_destinations.dart';

class LayoutRouterPreview extends StatefulWidget {
  const LayoutRouterPreview({
    required this.builder,
    this.initialRoute = 'ProvidersRoute',
    this.detail = false,
    super.key,
  });
  final Widget Function(BuildContext context, String route) builder;
  final String initialRoute;
  final bool detail;

  @override
  State<LayoutRouterPreview> createState() => _LayoutRouterPreviewState();
}

class _LayoutRouterPreviewState extends State<LayoutRouterPreview> {
  late final router = RootStackRouter.build(
    routes: [
      for (final name in [
        ...rootDestinations.map(
          (final destination) => destination.route.routeName,
        ),
        'ServerDetailsRoute',
      ])
        NamedRouteDef(
          name: name,
          path: '/$name',
          builder: (final context, final data) =>
              widget.builder(context, data.name),
        ),
    ],
  );
  late final config = router.config(
    deepLinkBuilder: (_) => DeepLink([
      PageRouteInfo(widget.initialRoute),
      if (widget.detail) const PageRouteInfo('ServerDetailsRoute'),
    ]),
  );

  @override
  Widget build(final BuildContext context) => MaterialApp.router(
    debugShowCheckedModeBanner: false,
    theme: Theme.of(context),
    locale: context.locale,
    supportedLocales: context.supportedLocales,
    localizationsDelegates: context.localizationDelegates,
    routerConfig: config,
    builder: (final context, final child) => LayoutBuilder(
      builder: (final context, final constraints) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: MediaQuery.textScalerOf(this.context),
          size: constraints.biggest,
        ),
        child: child!,
      ),
    ),
  );

  @override
  void dispose() {
    router.dispose();
    super.dispose();
  }
}
