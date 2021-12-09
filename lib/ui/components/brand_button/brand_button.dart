import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
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
    return _RisedButton(
      key: key,
      title: text,
      onPressed: onPressed,
      child: child,
    );
  }

  static text({
    Key? key,
    required VoidCallback onPressed,
    required String title,
  }) =>
      _TextButton(
        key: key,
        title: title,
        onPressed: onPressed,
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

class _RisedButton extends StatelessWidget {
  const _RisedButton({
    Key? key,
    this.onPressed,
    this.title,
    this.child,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String? title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: ColoredBox(
        color: onPressed == null
            ? BrandColors.gray2
            : Theme.of(context).primaryColor,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Container(
              height: 48,
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.all(12),
              child: child ?? BrandText.buttonTitleText(title),
            ),
          ),
        ),
      ),
    );
  }
}

class _TextButton extends StatelessWidget {
  const _TextButton({
    Key? key,
    this.onPressed,
    this.title,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        child: Text(
          title!,
          style: TextStyle(
            color: BrandColors.blue,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
        ),
      ),
    );
  }
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
