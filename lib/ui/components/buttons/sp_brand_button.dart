import 'package:flutter/material.dart';

class SPBrandButton extends StatelessWidget {
  const SPBrandButton({
    required this.child,
    required this.onPressed,
    super.key,
  });

  SPBrandButton.text({
    required final String title,
    required this.onPressed,
    super.key,
  }) : child = Text(title);

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) => FilledButton(
        // TODO(misterfourtytwo): move button styles to theme configuration
        style: const ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size.fromHeight(48)),
        ),
        onPressed: onPressed,
        child: child,
      );
}
