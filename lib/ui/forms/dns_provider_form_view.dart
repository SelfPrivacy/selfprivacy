import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/credential_checks/credential_check_state.dart';
import 'package:selfprivacy/logic/forms/dns_provider_form.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/forms/credential_check_error.dart';

class DnsProviderFormView extends StatelessWidget {
  const DnsProviderFormView({
    required this.dnsProviderForm,
    required this.tokenLabel,
    required this.submitLabel,
    super.key,
  });

  final DnsProviderForm dnsProviderForm;
  final String tokenLabel;
  final String submitLabel;

  @override
  Widget build(final BuildContext context) => ReactiveForm(
    formGroup: dnsProviderForm.form,
    child: ValueListenableBuilder<CredentialCheckState>(
      valueListenable: dnsProviderForm.credentialCheckState,
      builder: (final context, final checkState, final _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (dnsProviderForm.providerType.requiredCredentials.requiresTokenId)
            const _CredentialField(
              controlName: DnsProviderForm.tokenIdControlName,
              label: 'Provider API Token ID',
            ),
          if (dnsProviderForm.providerType.requiredCredentials.requiresTokenId)
            const Gap(16),
          _CredentialField(
            controlName: DnsProviderForm.tokenControlName,
            label: tokenLabel,
          ),
          if (dnsProviderForm.providerType.requiredCredentials.requiresUrl) ...[
            const Gap(16),
            const _CredentialField(
              controlName: DnsProviderForm.urlControlName,
              label: 'Provider API URL',
            ),
          ],
          if (dnsProviderForm
              .providerType
              .requiredCredentials
              .requiresTenant) ...[
            const Gap(16),
            const _CredentialField(
              controlName: DnsProviderForm.tenantControlName,
              label: 'Provider API Tenant',
            ),
          ],
          if (dnsProviderForm
              .providerType
              .requiredCredentials
              .requiresSecondaryToken) ...[
            const Gap(16),
            const _CredentialField(
              controlName: DnsProviderForm.secondaryTokenControlName,
              label: 'Provider API Secondary Token',
            ),
          ],
          if (checkState case CredentialCheckFailed(:final failure)) ...[
            const Gap(16),
            CredentialCheckError(
              failure: failure,
              rejectedMessage: 'initializing.dns_provider_bad_key_error'.tr(),
            ),
          ],
          const Gap(32),
          ReactiveFormConsumer(
            builder: (final context, final form, final _) => BrandButton.filled(
              onPressed: form.valid && checkState is! CredentialCheckRunning
                  ? dnsProviderForm.submit
                  : null,
              title: submitLabel,
            ),
          ),
        ],
      ),
    ),
  );
}

class _CredentialField extends StatelessWidget {
  const _CredentialField({required this.controlName, required this.label});

  final String controlName;
  final String label;

  @override
  Widget build(final BuildContext context) => ReactiveTextField<String>(
    formControlName: controlName,
    autofocus: true,
    scrollPadding: const EdgeInsets.only(bottom: 70),
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label,
    ),
    validationMessages: {
      ValidationMessage.required: (final _) => 'validations.required'.tr(),
    },
  );
}
