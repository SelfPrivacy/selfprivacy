import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// A helper widget that calls a callback when its size changes.
///
/// This is useful when you want to know the size of a widget, and use it in
/// another leaf of the tree.
///
/// The [onChange] callback is called after the widget is rendered, and the
/// size of the widget is different from the previous render.
class WidgetSize extends StatefulWidget {
  /// Creates a helper widget that calls a callback when its size changes.
  const WidgetSize({required this.onChange, required this.child, super.key});

  /// The child widget, the size of which is to be measured.
  final Widget child;

  /// The callback to be called when the size of the widget changes.
  final Function(Size) onChange;

  @override
  State<WidgetSize> createState() => _WidgetSizeState();
}

class _WidgetSizeState extends State<WidgetSize> {
  @override
  Widget build(final BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(key: widgetKey, child: widget.child);
  }

  var widgetKey = GlobalKey();
  Size? oldSize;

  void postFrameCallback(final _) {
    final context = widgetKey.currentContext;
    if (context == null) {
      return;
    }

    final newSize = context.size;

    if (newSize == null) {
      return;
    }

    if (oldSize == newSize) {
      return;
    }

    oldSize = newSize;
    widget.onChange(newSize);
  }
}
