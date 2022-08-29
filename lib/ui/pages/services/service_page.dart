import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({final super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
        hasBackButton: true,
        children: [
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.center,
            child: const Icon(
              Icons.question_mark_outlined,
              size: 48,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'My Incredible Service',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          BrandCards.outlined(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 24),
                  child: const Icon(
                    Icons.check_box_outlined,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 130),
                  child: const Text(''),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 24),
                  child: const Icon(
                    Icons.language_outlined,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 130),
                  child: const Text('Your Cool Domain'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      );
}
