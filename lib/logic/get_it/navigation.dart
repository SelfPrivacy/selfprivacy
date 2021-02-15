import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get navigator => navigatorKey.currentState;

  void showPopUpDialog(AlertDialog dialog) {
    final context = navigatorKey.currentState.overlay.context;

    showDialog(
      context: context,
      builder: (_) => dialog,
    );
  }
}
