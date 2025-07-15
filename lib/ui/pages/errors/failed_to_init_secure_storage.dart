import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/link_list_tile.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

class FailedToInitSecureStorageScreen extends StatelessWidget {
  const FailedToInitSecureStorageScreen({required this.e, super.key});

  final PlatformException e;

  @override
  Widget build(final BuildContext context) => MaterialApp(
    home: BrandHeroScreen(
      heroIcon: Icons.error_outline,
      heroTitle: 'Failed to initialize secure storage',
      hasBackButton: false,
      children: [
        const Text(
          'SelfPrivacy requires a secure storage provided by your operating system to encrypt sensitive data, but it failed to initialize.',
        ),
        if (Platform.isLinux)
          const Text(
            'Please make sure that the libsecret library is installed.',
          ),
        const Gap(16),
        Text('Error: ${e.message}'),
        const Gap(16),
        const Divider(),
        const Gap(16),
        const LinkListTile(
          title: 'Our website',
          subtitle: 'selfprivacy.org',
          uri: 'https://selfprivacy.org/',
          icon: Icons.language_outlined,
        ),
        const LinkListTile(
          title: 'Documentation',
          subtitle: 'selfprivacy.org/docs',
          uri: 'https://selfprivacy.org/docs/',
          icon: Icons.library_books_outlined,
        ),
        const LinkListTile(
          title: 'Privacy Policy',
          subtitle: 'selfprivacy.org/privacy-policy',
          uri: 'https://selfprivacy.org/privacy-policy/',
          icon: Icons.policy_outlined,
        ),
        const LinkListTile(
          title: 'Matrix support chat',
          subtitle: '#chat:selfprivacy.org',
          uri: 'https://matrix.to/#/#chat:selfprivacy.org',
          icon: Icons.question_answer_outlined,
          longPressText: '#chat:selfprivacy.org',
        ),
        const LinkListTile(
          title: 'Telegram support chat',
          subtitle: '@selfprivacy_chat',
          uri: 'https://t.me/selfprivacy_chat',
          icon: Icons.question_answer_outlined,
          longPressText: '@selfprivacy_chat',
        ),
      ],
    ),
  );
}
