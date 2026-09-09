import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/chips/support_level_chip.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

import '../../../preparation.dart';

@UseCase(name: 'normal', type: SupportLevelChip, path: '[Molecules]/chips')
Widget supportLevelChipNormal(final BuildContext context) => CatalogCase(
  key: const ValueKey('SupportLevelChip/normal'),
  id: 'SupportLevelChip/normal',
  variant: 'normal',
  host: PreviewHost.content,
  width: 560,
  height: 160,
  builder: (final context, final fixtures, final controller, final update) =>
      const SupportLevelChip(supportLevel: SupportLevel.normal, dense: false),
);

@UseCase(
  name: 'experimental',
  type: SupportLevelChip,
  path: '[Molecules]/chips',
)
Widget supportLevelChipExperimental(final BuildContext context) => CatalogCase(
  key: const ValueKey('SupportLevelChip/experimental'),
  id: 'SupportLevelChip/experimental',
  variant: 'experimental',
  host: PreviewHost.content,
  width: 560,
  height: 160,
  builder: (final context, final fixtures, final controller, final update) =>
      const SupportLevelChip(
        supportLevel: SupportLevel.experimental,
        dense: false,
      ),
);

@UseCase(name: 'deprecated', type: SupportLevelChip, path: '[Molecules]/chips')
Widget supportLevelChipDeprecated(final BuildContext context) => CatalogCase(
  key: const ValueKey('SupportLevelChip/deprecated'),
  id: 'SupportLevelChip/deprecated',
  variant: 'deprecated',
  host: PreviewHost.content,
  width: 560,
  height: 160,
  builder: (final context, final fixtures, final controller, final update) =>
      const SupportLevelChip(
        supportLevel: SupportLevel.deprecated,
        dense: false,
      ),
);

@UseCase(name: 'community', type: SupportLevelChip, path: '[Molecules]/chips')
Widget supportLevelChipCommunity(final BuildContext context) => CatalogCase(
  key: const ValueKey('SupportLevelChip/community'),
  id: 'SupportLevelChip/community',
  variant: 'community',
  host: PreviewHost.content,
  width: 560,
  height: 160,
  builder: (final context, final fixtures, final controller, final update) =>
      const SupportLevelChip(
        supportLevel: SupportLevel.community,
        dense: false,
      ),
);

@UseCase(name: 'unknown', type: SupportLevelChip, path: '[Molecules]/chips')
Widget supportLevelChipUnknown(final BuildContext context) => CatalogCase(
  key: const ValueKey('SupportLevelChip/unknown'),
  id: 'SupportLevelChip/unknown',
  variant: 'unknown',
  host: PreviewHost.content,
  width: 560,
  height: 160,
  builder: (final context, final fixtures, final controller, final update) =>
      const SupportLevelChip(supportLevel: SupportLevel.unknown, dense: false),
);

@UseCase(name: 'Dense', type: SupportLevelChip, path: '[Molecules]/chips')
Widget supportLevelChipDense(final BuildContext context) => CatalogCase(
  key: const ValueKey('SupportLevelChip/Dense'),
  id: 'SupportLevelChip/Dense',
  variant: 'Dense',
  host: PreviewHost.content,
  width: 560,
  height: 160,
  builder: (final context, final fixtures, final controller, final update) =>
      const SupportLevelChip(supportLevel: SupportLevel.normal, dense: true),
);

@UseCase(
  name: 'Normal explanation',
  type: SupportLevelChip,
  path: '[Molecules]/chips',
)
Widget supportLevelChipNormalExplanation(
  final BuildContext context,
) => CatalogCase(
  key: const ValueKey('SupportLevelChip/Normal explanation'),
  id: 'SupportLevelChip/Normal explanation',
  variant: 'Normal explanation',
  prepare: PreviewAction.chipDialog,
  host: PreviewHost.content,
  width: 560,
  height: 600,
  builder: (final context, final fixtures, final controller, final update) =>
      const SupportLevelChip(supportLevel: SupportLevel.normal, dense: false),
);

@UseCase(
  name: 'Experimental explanation',
  type: SupportLevelChip,
  path: '[Molecules]/chips',
)
Widget supportLevelChipExperimentalExplanation(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('SupportLevelChip/Experimental explanation'),
      id: 'SupportLevelChip/Experimental explanation',
      variant: 'Experimental explanation',
      prepare: PreviewAction.chipDialog,
      host: PreviewHost.content,
      width: 560,
      height: 600,
      builder:
          (final context, final fixtures, final controller, final update) =>
              const SupportLevelChip(
                supportLevel: SupportLevel.experimental,
                dense: false,
              ),
    );

@UseCase(
  name: 'Deprecated explanation',
  type: SupportLevelChip,
  path: '[Molecules]/chips',
)
Widget supportLevelChipDeprecatedExplanation(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('SupportLevelChip/Deprecated explanation'),
      id: 'SupportLevelChip/Deprecated explanation',
      variant: 'Deprecated explanation',
      prepare: PreviewAction.chipDialog,
      host: PreviewHost.content,
      width: 560,
      height: 600,
      builder:
          (final context, final fixtures, final controller, final update) =>
              const SupportLevelChip(
                supportLevel: SupportLevel.deprecated,
                dense: false,
              ),
    );

@UseCase(
  name: 'Community explanation',
  type: SupportLevelChip,
  path: '[Molecules]/chips',
)
Widget supportLevelChipCommunityExplanation(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('SupportLevelChip/Community explanation'),
      id: 'SupportLevelChip/Community explanation',
      variant: 'Community explanation',
      prepare: PreviewAction.chipDialog,
      host: PreviewHost.content,
      width: 560,
      height: 600,
      builder:
          (final context, final fixtures, final controller, final update) =>
              const SupportLevelChip(
                supportLevel: SupportLevel.community,
                dense: false,
              ),
    );

@UseCase(
  name: 'Unknown explanation',
  type: SupportLevelChip,
  path: '[Molecules]/chips',
)
Widget supportLevelChipUnknownExplanation(
  final BuildContext context,
) => CatalogCase(
  key: const ValueKey('SupportLevelChip/Unknown explanation'),
  id: 'SupportLevelChip/Unknown explanation',
  variant: 'Unknown explanation',
  prepare: PreviewAction.chipDialog,
  host: PreviewHost.content,
  width: 560,
  height: 600,
  builder: (final context, final fixtures, final controller, final update) =>
      const SupportLevelChip(supportLevel: SupportLevel.unknown, dense: false),
);
