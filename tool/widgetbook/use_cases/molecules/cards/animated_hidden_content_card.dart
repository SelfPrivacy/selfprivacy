import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/cards/animated_hidden_content_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

import '../../../preparation.dart';

@UseCase(
  name: 'Hidden',
  type: AnimatedHiddenContentCard,
  path: '[Molecules]/cards',
)
Widget animatedHiddenContentCardHidden(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('AnimatedHiddenContentCard/Hidden'),
      id: 'AnimatedHiddenContentCard/Hidden',
      variant: 'Hidden',
      host: PreviewHost.content,
      width: 560,
      height: 180,
      builder:
          (final context, final fixtures, final controller, final update) =>
              const AnimatedHiddenContentCard(
                hiddenText: 'catalog-only-key-0123456789',
                buttonText: 'Show key',
              ),
    );

@UseCase(
  name: 'Revealed',
  type: AnimatedHiddenContentCard,
  path: '[Molecules]/cards',
)
Widget animatedHiddenContentCardRevealed(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('AnimatedHiddenContentCard/Revealed'),
      id: 'AnimatedHiddenContentCard/Revealed',
      variant: 'Revealed',
      prepare: PreviewAction.reveal,
      host: PreviewHost.content,
      width: 560,
      height: 180,
      builder:
          (final context, final fixtures, final controller, final update) =>
              const AnimatedHiddenContentCard(
                hiddenText: 'catalog-only-key-0123456789',
                buttonText: 'Show key',
              ),
    );
