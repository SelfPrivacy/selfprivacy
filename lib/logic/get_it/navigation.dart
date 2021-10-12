import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/text_themes.dart';

class NavigationService {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get navigator => navigatorKey.currentState;

  void showPopUpDialog(AlertDialog dialog) {
    final context = navigatorKey.currentState!.overlay!.context;

    showDialog(
      context: context,
      builder: (_) => dialog,
    );
  }

  void showSnackBar(String text) {
    final state = scaffoldMessengerKey.currentState!;
    final snack = SnackBar(
      backgroundColor: BrandColors.black.withOpacity(0.8),
      content: Text(text, style: buttonTitleText),
      duration: const Duration(seconds: 2),
    );
    state.showSnackBar(snack);
  }
}
