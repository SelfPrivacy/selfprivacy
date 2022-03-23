import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';

class BrandHeroScreen extends StatelessWidget {
  const BrandHeroScreen({
    Key? key,
    this.headerTitle = '',
    this.hasBackButton = true,
    this.hasFlashButton = true,
    required this.children,
    this.heroIcon,
    this.heroTitle,
    this.heroSubtitle,
  }) : super(key: key);

  final List<Widget> children;
  final String headerTitle;
  final bool hasBackButton;
  final bool hasFlashButton;
  final IconData? heroIcon;
  final String? heroTitle;
  final String? heroSubtitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(52.0),
          child: BrandHeader(
            title: headerTitle,
            hasBackButton: hasBackButton,
            hasFlashButton: hasFlashButton,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            if (heroIcon != null)
              Icon(
                heroIcon,
                size: 48.0,
              ),
            SizedBox(height: 16.0),
            if (heroTitle != null)
              Text(heroTitle!,
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center),
            SizedBox(height: 8.0),
            if (heroSubtitle != null)
              Text(heroSubtitle!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center),
            SizedBox(height: 16.0),
            ...children,
          ],
        ),
      ),
    );
  }
}
