import 'package:flutter/material.dart';
import 'package:selfprivacy/utils/breakpoints.dart';

class ResponsiveLayoutWithInfobox extends StatelessWidget {
  const ResponsiveLayoutWithInfobox({
    required this.primaryColumn,
    this.topChild,
    this.secondaryColumn,
    super.key,
  });

  final Widget? topChild;
  final Widget primaryColumn;
  final Widget? secondaryColumn;

  @override
  Widget build(final BuildContext context) {
    final hasSecondaryColumn = secondaryColumn != null;
    final hasTopChild = topChild != null;

    if (Breakpoints.large.isActive(context)) {
      return LayoutBuilder(
        builder:
            (final context, final constraints) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasTopChild)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.9,
                        child: topChild,
                      ),
                    ],
                  ),
                if (hasTopChild) const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width:
                          hasSecondaryColumn
                              ? constraints.maxWidth * 0.7
                              : constraints.maxWidth * 0.9,
                      child: primaryColumn,
                    ),
                    if (hasSecondaryColumn) const SizedBox(width: 16),
                    if (hasSecondaryColumn)
                      SizedBox(
                        width: constraints.maxWidth * 0.2,
                        child: secondaryColumn,
                      ),
                  ],
                ),
              ],
            ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasTopChild) topChild!,
        const SizedBox(height: 16),
        primaryColumn,
        const SizedBox(height: 32),
        if (hasSecondaryColumn) secondaryColumn!,
      ],
    );
  }
}
