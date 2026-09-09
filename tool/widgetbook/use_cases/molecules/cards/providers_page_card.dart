import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/atoms/icons/brand_icons.dart';
import 'package:selfprivacy/ui/molecules/cards/providers_page_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(
  name: 'uninitialized',
  type: ProvidersPageCard,
  path: '[Molecules]/cards',
)
Widget providersPageCardUninitialized(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('ProvidersPageCard/uninitialized'),
      id: 'ProvidersPageCard/uninitialized',
      variant: 'uninitialized',
      host: PreviewHost.content,
      width: 560,
      height: 220,
      builder:
          (final context, final fixtures, final controller, final update) =>
              ProvidersPageCard(
                state: StateType.uninitialized,
                icon: BrandIcons.globe,
                title: 'domain.screen_title'.tr(),
                subtitle: 'example.org',
                onTap: () => catalogActions.record('Provider'),
              ),
    );

@UseCase(name: 'stable', type: ProvidersPageCard, path: '[Molecules]/cards')
Widget providersPageCardStable(final BuildContext context) => CatalogCase(
  key: const ValueKey('ProvidersPageCard/stable'),
  id: 'ProvidersPageCard/stable',
  variant: 'stable',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      ProvidersPageCard(
        state: StateType.stable,
        icon: BrandIcons.globe,
        title: 'domain.screen_title'.tr(),
        subtitle: 'example.org',
        onTap: () => catalogActions.record('Provider'),
      ),
);

@UseCase(name: 'warning', type: ProvidersPageCard, path: '[Molecules]/cards')
Widget providersPageCardWarning(final BuildContext context) => CatalogCase(
  key: const ValueKey('ProvidersPageCard/warning'),
  id: 'ProvidersPageCard/warning',
  variant: 'warning',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      ProvidersPageCard(
        state: StateType.warning,
        icon: BrandIcons.globe,
        title: 'domain.screen_title'.tr(),
        subtitle: 'example.org',
        onTap: () => catalogActions.record('Provider'),
      ),
);

@UseCase(name: 'error', type: ProvidersPageCard, path: '[Molecules]/cards')
Widget providersPageCardError(final BuildContext context) => CatalogCase(
  key: const ValueKey('ProvidersPageCard/error'),
  id: 'ProvidersPageCard/error',
  variant: 'error',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      ProvidersPageCard(
        state: StateType.error,
        icon: BrandIcons.globe,
        title: 'domain.screen_title'.tr(),
        subtitle: 'example.org',
        onTap: () => catalogActions.record('Provider'),
      ),
);
