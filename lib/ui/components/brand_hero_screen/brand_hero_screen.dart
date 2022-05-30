import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/pre_styled_buttons/flash_fab.dart';

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
    this.onBackButtonPressed,
  }) : super(key: key);

  final List<Widget> children;
  final String headerTitle;
  final bool hasBackButton;
  final bool hasFlashButton;
  final IconData? heroIcon;
  final String? heroTitle;
  final String? heroSubtitle;
  final VoidCallback? onBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(52.0),
          child: BrandHeader(
            title: headerTitle,
            hasBackButton: hasBackButton,
            onBackButtonPressed: onBackButtonPressed,
          ),
        ),
        floatingActionButton: hasFlashButton ? const BrandFab() : null,
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            if (heroIcon != null)
              Container(
                alignment: Alignment.bottomLeft,
                child: Icon(
                  heroIcon,
                  size: 48.0,
                ),
              ),
            const SizedBox(height: 8.0),
            if (heroTitle != null)
              Text(
                heroTitle!,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                textAlign: TextAlign.start,
              ),
            const SizedBox(height: 8.0),
            if (heroSubtitle != null)
              Text(heroSubtitle!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  textAlign: TextAlign.start),
            const SizedBox(height: 16.0),
            ...children,
          ],
        ),
      ),
    );
  }
}
