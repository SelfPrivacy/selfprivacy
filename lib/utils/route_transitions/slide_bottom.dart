import 'package:flutter/material.dart';

Function pageBuilder = (final Widget widget) => (
      final BuildContext context,
      final Animation<double> animation,
      final Animation<double> secondaryAnimation,
    ) =>
        widget;

Function transitionsBuilder = (
  final BuildContext context,
  final Animation<double> animation,
  final Animation<double> secondaryAnimation,
  final Widget child,
) =>
    SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(animation),
      child: Container(
        decoration: animation.isCompleted
            ? null
            : const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
        child: child,
      ),
    );

class SlideBottomRoute extends PageRouteBuilder {
  SlideBottomRoute(this.widget)
      : super(
          transitionDuration: const Duration(milliseconds: 150),
          pageBuilder: pageBuilder(widget),
          transitionsBuilder: transitionsBuilder as Widget Function(
            BuildContext,
            Animation<double>,
            Animation<double>,
            Widget,
          ),
        );

  final Widget widget;
}
