import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    required this.steps,
    required this.activeIndex,
    super.key,
  });

  final int activeIndex;
  final int steps;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(final BuildContext context) {
    final double progress = 1 / widget.steps * (widget.activeIndex + 0.3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(5),
          ),
          child: LayoutBuilder(
            builder:
                (final _, final constraints) => AnimatedContainer(
                  width: constraints.maxWidth * progress,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                  ),
                  duration: const Duration(milliseconds: 300),
                ),
          ),
        ),
      ],
    );
  }
}
