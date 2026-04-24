import 'package:flutter/material.dart';

class AnimatedHiddenContentCard extends StatefulWidget {
  const AnimatedHiddenContentCard({
    required this.hiddenText,
    required this.buttonText,
    this.buttonIcon = Icons.visibility_outlined,
    super.key,
  });

  final String hiddenText;
  final String buttonText;
  final IconData buttonIcon;

  @override
  State<AnimatedHiddenContentCard> createState() =>
      _AnimatedHiddenContentCardState();
}

class _AnimatedHiddenContentCardState extends State<AnimatedHiddenContentCard> {
  bool isKeyVisible = false;

  @override
  Widget build(final BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
    ),
    padding: const EdgeInsets.all(16),
    child: Stack(
      children: [
        SelectableText(
          widget.hiddenText,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontFamily: 'RobotoMono',
          ),
        ),
        Positioned.fill(
          child: InkWell(
            onTap: () {
              setState(() {
                isKeyVisible = !isKeyVisible;
              });
            },
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isKeyVisible ? 0 : 1,
              child: ColoredBox(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(widget.buttonIcon, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      widget.buttonText,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
