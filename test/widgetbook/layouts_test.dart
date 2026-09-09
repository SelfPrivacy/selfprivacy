import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/layouts/root_scaffold_with_subroute_selector/root_scaffold_with_subroute_selector.dart';
import 'package:selfprivacy/ui/molecules/buttons/flash_fab.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../tool/widgetbook/catalog_case.dart';
import '../../tool/widgetbook/main.dart';
import '../../tool/widgetbook/use_cases/layouts/brand_hero_screen.dart';
import '../../tool/widgetbook/use_cases/layouts/responsive_layout_with_infobox.dart';
import '../../tool/widgetbook/use_cases/layouts/root_scaffold_with_subroute_selector.dart';
import 'behavior_test.dart' show pumpCase;

class _Context extends Mock implements BuildContext {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('navigation uses preview width inside a larger window', (
    final tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    await tester.runAsync(() async {
      await tester.pumpWidget(
        CatalogLocalization(
          child: Theme(
            data: catalogTheme(Brightness.light),
            child: Center(
              child: rootScaffoldWithSubrouteSelectorMobile(_Context()),
            ),
          ),
        ),
      );
    });
    await tester.pumpAndSettle();
    expect(find.byType(RootScaffoldWithSubrouteSelector), findsOneWidget);
    expect(find.byType(NavigationDrawer), findsNothing);
    expect(find.byType(NavigationRail), findsNothing);
    final context = tester.element(
      find.byType(RootScaffoldWithSubrouteSelector),
    );
    expect(MediaQuery.sizeOf(context).width, 390);
    expect(tester.getSize(find.byKey(const ValueKey('bottomBar'))).height, 80);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
    'navigation selection survives resizing across both breakpoints',
    (final tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await pumpCase(
        tester,
        rootScaffoldWithSubrouteSelectorDrawer(_Context()) as CatalogCase,
      );
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationDrawer),
          matching: find.text('Services'),
        ),
      );
      await tester.pumpAndSettle();
      for (final width in [599.0, 600.0, 839.0, 840.0, 1200.0]) {
        tester.view.physicalSize = Size(width, 800);
        await tester.pumpAndSettle();
        expect(
          find.byType(NavigationRail),
          width >= 600 && width < 840 ? findsOneWidget : findsNothing,
        );
        expect(
          find.byType(NavigationDrawer),
          width >= 840 ? findsOneWidget : findsNothing,
        );
        expect(
          tester.getSize(find.byKey(const ValueKey('bottomBar'))).height,
          width < 600 ? 80 : 0,
        );
        expect(
          tester
              .widget<Text>(
                find.byKey(const ValueKey('navigation-content-title')),
              )
              .data,
          'Services',
        );
        if (width >= 840) {
          expect(
            tester
                .widget<NavigationDrawer>(find.byType(NavigationDrawer))
                .selectedIndex,
            1,
          );
        }
        if (width >= 600 && width < 840) {
          expect(
            tester
                .widget<NavigationRail>(find.byType(NavigationRail))
                .selectedIndex,
            1,
          );
        }
        expect(tester.takeException(), isNull);
      }
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets(
    'detail navigation preserves the selected destination and supports back',
    (final tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await pumpCase(
        tester,
        rootScaffoldWithSubrouteSelectorRail(_Context()) as CatalogCase,
      );
      await tester.tap(find.text('Server'));
      await tester.pumpAndSettle();
      final router = tester
          .element(find.byType(RootScaffoldWithSubrouteSelector))
          .router;
      expect(router.pageCount, 2);
      expect(
        tester
            .widget<NavigationRail>(find.byType(NavigationRail))
            .selectedIndex,
        0,
      );
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(router.pageCount, 1);
      expect(
        tester
            .widget<Text>(
              find.byKey(const ValueKey('navigation-content-title')),
            )
            .data,
        'Your Data Center',
      );
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets(
    'jobs controls are hidden without a configured server at every navigation size',
    (final tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      for (final builder in [
        rootScaffoldWithSubrouteSelectorMobileWithoutConfiguredServer,
        rootScaffoldWithSubrouteSelectorRailWithoutConfiguredServer,
        rootScaffoldWithSubrouteSelectorDrawerWithoutConfiguredServer,
      ]) {
        await pumpCase(tester, builder(_Context()) as CatalogCase);
        expect(find.byType(BrandFab), findsNothing);
      }
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets(
    'infobox moves from below the primary content to its side at 840',
    (final tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      for (final builder in [
        responsiveLayoutWithInfoboxBelowColumns,
        responsiveLayoutWithInfoboxColumnsBoundary,
      ]) {
        final example = builder(_Context()) as CatalogCase;
        await pumpCase(tester, example);
        final primary = tester.getRect(
          find.byKey(const ValueKey('layout-primary')),
        );
        final secondary = tester.getRect(
          find.byKey(const ValueKey('layout-secondary')),
        );
        if (example.width < 840) {
          expect(secondary.top, greaterThan(primary.bottom));
        } else {
          expect(secondary.left, greaterThan(primary.right));
          expect(secondary.top, primary.top);
        }
      }
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets('collapsed hero keeps a pinned mobile app bar', (
    final tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pumpCase(tester, brandHeroScreenCollapsed(_Context()) as CatalogCase);
    final scrollable = find.descendant(
      of: find.byType(BrandHeroScreen),
      matching: find.byType(Scrollable),
    );
    expect(
      tester.state<ScrollableState>(scrollable).position.pixels,
      greaterThan(200),
    );
    expect(
      tester.widget<SliverAppBar>(find.byType(SliverAppBar)).pinned,
      isTrue,
    );
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
