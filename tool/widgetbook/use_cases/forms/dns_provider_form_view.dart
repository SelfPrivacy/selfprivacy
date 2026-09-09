import 'dart:async';

import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/forms/dns_provider_form.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/ui/forms/dns_provider_form_view.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../catalog_case.dart';
import '../../form_preview.dart';

@UseCase(name: 'Empty', type: DnsProviderFormView, path: '[Forms]')
Widget dnsProviderFormViewEmpty(final BuildContext context) =>
    _example('Empty');

@UseCase(name: 'Required', type: DnsProviderFormView, path: '[Forms]')
Widget dnsProviderFormViewRequired(final BuildContext context) =>
    _example('Required');

@UseCase(name: 'Ready', type: DnsProviderFormView, path: '[Forms]')
Widget dnsProviderFormViewReady(final BuildContext context) =>
    _example('Ready');

@UseCase(name: 'Checking', type: DnsProviderFormView, path: '[Forms]')
Widget dnsProviderFormViewChecking(final BuildContext context) =>
    _example('Checking');

@UseCase(name: 'Rejected', type: DnsProviderFormView, path: '[Forms]')
Widget dnsProviderFormViewRejected(final BuildContext context) =>
    _example('Rejected');

@UseCase(name: 'Unavailable', type: DnsProviderFormView, path: '[Forms]')
Widget dnsProviderFormViewUnavailable(final BuildContext context) =>
    _example('Unavailable');

@UseCase(name: 'Porkbun empty', type: DnsProviderFormView, path: '[Forms]')
Widget dnsProviderFormViewPorkbunEmpty(final BuildContext context) =>
    _example('Porkbun empty');

@UseCase(name: 'Porkbun ready', type: DnsProviderFormView, path: '[Forms]')
Widget dnsProviderFormViewPorkbunReady(final BuildContext context) =>
    _example('Porkbun ready');

@UseCase(name: 'Porkbun required', type: DnsProviderFormView, path: '[Forms]')
Widget dnsProviderFormViewPorkbunRequired(final BuildContext context) =>
    _example('Porkbun required');

CatalogCase _example(final String variant) => CatalogCase(
  key: ValueKey('DnsProviderFormView/$variant'),
  id: 'DnsProviderFormView/$variant',
  variant: variant,
  height: 900,
  builder: (final context, final fixtures, final controller, final update) =>
      FormPreview<DnsProviderForm>(
        create: (final scope) {
          final form = DnsProviderForm(
            providerType: variant.startsWith('Porkbun')
                ? DnsProviderType.porkbun
                : DnsProviderType.cloudflare,
            validateCredential: (_) => scope.check(variant),
            onSubmit: (_) => scope.submit(variant),
          );
          scope.onDispose(form.dispose);
          final inputVariant = variant == 'Porkbun empty'
              ? 'Empty'
              : variant == 'Porkbun required'
              ? 'Required'
              : variant;
          prepareForm(form.form, inputVariant, {
            for (final name in form.form.controls.keys) name: 'catalog-$name',
          });
          if (['Checking', 'Rejected', 'Unavailable'].contains(variant)) {
            unawaited(form.submit());
          }
          return form;
        },
        builder: (final context, final form) => DnsProviderFormView(
          dnsProviderForm: form,
          tokenLabel: form.providerType == DnsProviderType.porkbun
              ? 'Secret API key'
              : 'API token',
          submitLabel: 'Connect',
        ),
      ),
);
