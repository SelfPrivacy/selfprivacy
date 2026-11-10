import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/models/credential_policy.dart';
import 'package:selfprivacy/ui/organisms/credential_policy_selection.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../catalog_case.dart';

@UseCase(name: 'Current', type: CredentialPolicySelection, path: '[Organisms]')
Widget policyCurrent(final BuildContext context) => _example('Current');

@UseCase(
  name: 'Attested passkey',
  type: CredentialPolicySelection,
  path: '[Organisms]',
)
Widget policyAttested(final BuildContext context) =>
    _example('Attested passkey');

@UseCase(name: 'Unknown', type: CredentialPolicySelection, path: '[Organisms]')
Widget policyUnknown(final BuildContext context) => _example('Unknown');

@UseCase(name: 'Loading', type: CredentialPolicySelection, path: '[Organisms]')
Widget policyLoading(final BuildContext context) => _example('Loading');

@UseCase(name: 'Error', type: CredentialPolicySelection, path: '[Organisms]')
Widget policyError(final BuildContext context) => _example('Error');

@UseCase(name: 'Stale', type: CredentialPolicySelection, path: '[Organisms]')
Widget policyStale(final BuildContext context) => _example('Stale');

@UseCase(name: 'Queued', type: CredentialPolicySelection, path: '[Organisms]')
Widget policyQueued(final BuildContext context) => _example('Queued');

@UseCase(name: 'Applying', type: CredentialPolicySelection, path: '[Organisms]')
Widget policyApplying(final BuildContext context) => _example('Applying');

@UseCase(
  name: 'Unsupported',
  type: CredentialPolicySelection,
  path: '[Organisms]',
)
Widget policyUnsupported(final BuildContext context) => _example('Unsupported');

@UseCase(name: 'Wide', type: CredentialPolicySelection, path: '[Organisms]')
Widget policyWide(final BuildContext context) => _example('Wide');

CatalogCase _example(final String variant) => CatalogCase(
  id: 'CredentialPolicySelection/$variant',
  variant: variant,
  width: variant == 'Wide' ? 640 : 360,
  builder: (final context, final fixtures, final controller, final update) =>
      CredentialPolicySelection(
        snapshot: CachedValue(
          data: switch (variant) {
            'Loading' || 'Error' || 'Unsupported' => null,
            'Unknown' => CredentialPolicy.unknown,
            'Attested passkey' => CredentialPolicy.attestedPasskey,
            _ => CredentialPolicy.any,
          },
          support: variant == 'Unsupported'
              ? DomainSupport.unsupported
              : DomainSupport.supported,
          freshness: variant == 'Stale' ? Freshness.stale : Freshness.fresh,
          isRefreshing: variant == 'Loading',
          lastError: variant == 'Error' ? StateError('offline') : null,
        ),
        pendingPolicy: variant == 'Queued' ? CredentialPolicy.mfa : null,
        enabled: variant != 'Applying',
        applying: variant == 'Applying',
        onAdd: (final policy) =>
            catalogActions.record('Queue credential policy: ${policy.name}'),
        onRefresh: () => catalogActions.record('Refresh credential policy'),
        onShowOperation: () => catalogActions.record('Show operation'),
      ),
);
