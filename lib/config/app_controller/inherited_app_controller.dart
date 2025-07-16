import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart'
    as color_utils;
import 'package:selfprivacy/config/app_controller/app_controller.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/preferences_repository/inherited_preferences_repository.dart';
import 'package:selfprivacy/config/preferences_repository/preferences_repository.dart';
import 'package:selfprivacy/theming/app_theme_factory.dart';

class _AppControllerInjector extends InheritedNotifier<AppController> {
  const _AppControllerInjector({required super.child, required super.notifier});
}

class InheritedAppController extends StatefulWidget {
  const InheritedAppController({required this.child, super.key});

  final Widget child;

  @override
  State<InheritedAppController> createState() => _InheritedAppControllerState();

  static AppController of(final BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<_AppControllerInjector>()!
          .notifier!;
}

class _InheritedAppControllerState extends State<InheritedAppController> {
  // actual state provider
  late AppController controller;
  // hold local reference to active repo
  late PreferencesRepository _repo;

  bool initTriggerred = false;

  @override
  void didChangeDependencies() {
    /// update reference on dependency change
    _repo = InheritedPreferencesRepository.of(context)!;

    if (!initTriggerred) {
      /// hook controller repo to local reference
      controller = AppController(_repo);
      unawaited(initialize());
      initTriggerred = true;
    }

    super.didChangeDependencies();
  }

  Future<void> initialize() async {
    late final ThemeData lightThemeData;
    late final ThemeData darkThemeData;
    late final color_utils.CorePalette colorPalette;

    await Future.wait(<Future<void>>[
      () async {
        lightThemeData = await AppThemeFactory.create(
          isDark: false,
          fallbackColor: BrandColors.primary,
        );
      }(),
      () async {
        darkThemeData = await AppThemeFactory.create(
          isDark: true,
          fallbackColor: BrandColors.primary,
        );
      }(),
      () async {
        colorPalette =
            (await AppThemeFactory.getCorePalette()) ??
            color_utils.CorePalette.of(BrandColors.primary.toARGB32());
      }(),
    ]);

    await controller.init(
      colorPalette: colorPalette,
      lightThemeData: lightThemeData,
      darkThemeData: darkThemeData,
    );

    WidgetsBinding.instance.addPostFrameCallback((final _) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) =>
      _AppControllerInjector(notifier: controller, child: widget.child);
}
