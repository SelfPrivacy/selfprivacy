import 'package:flutter/material.dart';

Function pageBuilder = (Widget widget) => (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) =>
        widget;

Function transitionsBuilder = (
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(animation),
    child: Container(
      decoration: animation.isCompleted
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
      child: child,
    ),
  );
};

class SlideBottomRoute extends PageRouteBuilder {
  SlideBottomRoute(this.widget)
      : super(
          pageBuilder: pageBuilder(widget),
          transitionsBuilder: transitionsBuilder as Widget Function(BuildContext, Animation<double>, Animation<double>, Widget),
        );

  final Widget widget;
}
