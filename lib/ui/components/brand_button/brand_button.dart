import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';

enum BrandButtonTypes { rised, text }

class BrandButton extends StatelessWidget {
  const BrandButton({
    Key key,
    this.onPressed,
    this.type,
    this.title,
  }) : super(key: key);

  final VoidCallback onPressed;
  final BrandButtonTypes type;
  final String title;

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
