import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/utils/extensions/text_extension.dart';

enum BrandButtonTypes { rised, text, iconText }

class BrandButton extends StatelessWidget {
  const BrandButton({
    Key key,
    this.onPressed,
    this.type,
    this.title,
    this.icon,
  }) : super(key: key);

  final VoidCallback onPressed;
  final BrandButtonTypes type;
  final String title;
  final Icon icon;

  static rised({
    Key key,
    @required VoidCallback onPressed,
    @required String title,
  }) =>
      BrandButton(
        key: key,
        onPressed: onPressed,
        title: title,
        type: BrandButtonTypes.rised,
      );

  static text({
    Key key,
    @required VoidCallback onPressed,
    @required String title,
  }) =>
      BrandButton(
        key: key,
        onPressed: onPressed,
        title: title,
        type: BrandButtonTypes.text,
      );

  static iconText({
    Key key,
    @required VoidCallback onPressed,
    @required String title,
    @required Icon icon,
  }) =>
      BrandButton(
        key: key,
        onPressed: onPressed,
        title: title,
        type: BrandButtonTypes.iconText,
        icon: icon,
      );
  @override
  Widget build(BuildContext context) {
    switch (type) {
      case BrandButtonTypes.rised:
        return _RisedButton(
          title: title,
          onPressed: onPressed,
        );
      case BrandButtonTypes.text:
        return _TextButton(
          title: title,
          onPressed: onPressed,
        );
        break;
      case BrandButtonTypes.iconText:
        return _IconTextButton(
          title: title,
          onPressed: onPressed,
          icon: icon,
        );
        break;
    }

    return null;
  }
}

class _RisedButton extends StatelessWidget {
  const _RisedButton({
    Key key,
    this.onPressed,
    this.title,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: ColoredBox(
        color: Theme.of(context).primaryColor,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Container(
              height: 48,
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.all(12),
              child: Text(
                title,
                style: TextStyle(
                  color: BrandColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TextButton extends StatelessWidget {
  const _TextButton({
    Key key,
    this.onPressed,
    this.title,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        child: Text(
          title,
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
  const _IconTextButton({Key key, this.onPressed, this.title, this.icon})
      : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final Icon icon;

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
              Text(
                title,
              ).body1,
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
