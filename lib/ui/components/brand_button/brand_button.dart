// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';

enum BrandButtonTypes { rised, text, iconText }

class BrandButton {
  static ConstrainedBox rised({
    required final VoidCallback? onPressed,
    final Key? key,
    final String? text,
    final Widget? child,
  }) {
    assert(text == null || child == null, 'required title or child');
    assert(text != null || child != null, 'required title or child');
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 48,
        minWidth: double.infinity,
      ),
      child: FilledButton(
        key: key,
        title: text,
        onPressed: onPressed,
        child: child,
      ),
    );
  }

  static ConstrainedBox text({
    required final VoidCallback onPressed,
    required final String title,
    final Key? key,
  }) =>
      ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 40,
          minWidth: double.infinity,
        ),
        child: TextButton(onPressed: onPressed, child: Text(title)),
      );

  static _IconTextButton emptyWithIconText({
    required final VoidCallback onPressed,
    required final String title,
    required final Icon icon,
    final Key? key,
  }) =>
      _IconTextButton(
        key: key,
        title: title,
        onPressed: onPressed,
        icon: icon,
      );
}

class _IconTextButton extends StatelessWidget {
  const _IconTextButton({final super.key, this.onPressed, this.title, this.icon});

  final VoidCallback? onPressed;
  final String? title;
  final Icon? icon;

  @override
  Widget build(final BuildContext context) => Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 48,
          width: double.infinity,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BrandText.body1(title),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: icon,
              )
            ],
          ),
        ),
      ),
    );
}
