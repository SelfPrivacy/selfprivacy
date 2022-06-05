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
) => SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(animation),
    child: Container(
      decoration: animation.isCompleted
          ? null
          : const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
      child: child,
    ),
  );

class SlideRightRoute extends PageRouteBuilder {
  SlideRightRoute(this.widget)
      : super(
          pageBuilder: pageBuilder(widget),
          transitionsBuilder: transitionsBuilder as Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget,),
        );

  final Widget widget;
}
