import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_button/FilledButton.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';

enum BrandButtonTypes { rised, text, iconText }

class BrandButton {
  static rised({
    Key? key,
    required VoidCallback? onPressed,
    String? text,
    Widget? child,
  }) {
    assert(text == null || child == null, 'required title or child');
    assert(text != null || child != null, 'required title or child');
    return ConstrainedBox(
      constraints: BoxConstraints(
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

  static text({
    Key? key,
    required VoidCallback onPressed,
    required String title,
  }) =>
      ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 48,
          minWidth: double.infinity,
        ),
        child: TextButton(onPressed: onPressed, child: Text(title)),
      );

  static emptyWithIconText({
    Key? key,
    required VoidCallback onPressed,
    required String title,
    required Icon icon,
  }) =>
      _IconTextButton(
        key: key,
        title: title,
        onPressed: onPressed,
        icon: icon,
      );
}

class _IconTextButton extends StatelessWidget {
  const _IconTextButton({Key? key, this.onPressed, this.title, this.icon})
      : super(key: key);

  final VoidCallback? onPressed;
  final String? title;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Material(
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
}
