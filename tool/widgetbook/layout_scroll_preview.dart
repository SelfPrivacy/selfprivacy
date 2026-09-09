import 'package:flutter/material.dart';

class LayoutScrollPreview extends StatefulWidget {
  const LayoutScrollPreview({
    required this.collapsed,
    required this.child,
    super.key,
  });
  final bool collapsed;
  final Widget child;

  @override
  State<LayoutScrollPreview> createState() => _LayoutScrollPreviewState();
}

class _LayoutScrollPreviewState extends State<LayoutScrollPreview> {
  @override
  void initState() {
    super.initState();
    if (widget.collapsed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        void visit(final Element element) {
          if (element is StatefulElement && element.state is ScrollableState) {
            final position = (element.state as ScrollableState).position;
            if (position.hasContentDimensions) {
              position.jumpTo(position.maxScrollExtent.clamp(0, 320));
            }
            return;
          }
          element.visitChildren(visit);
        }

        (context as Element).visitChildren(visit);
      });
    }
  }

  @override
  Widget build(final BuildContext context) => widget.child;
}
