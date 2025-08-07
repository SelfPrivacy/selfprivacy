import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/domain_setup_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/atoms/cards/outlined_card.dart';
import 'package:selfprivacy/ui/layouts/responsive_layout_with_infobox.dart';

class DomainPicker extends StatefulWidget {
  const DomainPicker({super.key});

  @override
  State<DomainPicker> createState() => _DomainPickerState();
}

class _DomainPickerState extends State<DomainPicker> {
  String? selectedDomain;

  @override
  Widget build(final BuildContext context) {
    final DomainSetupState state = context.watch<DomainSetupCubit>().state;

    return ResponsiveLayoutWithInfobox(
      topChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (state is MoreThenOne)
                ? 'initializing.multiple_domains_found'.tr()
                : 'initializing.use_this_domain'.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            (state is MoreThenOne)
                ? 'initializing.multiple_domains_found_text'.tr()
                : 'initializing.use_this_domain_text'.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
      primaryColumn: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state is Empty)
            Text(
              'initializing.no_connected_domains'.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          if (state is Loading)
            Text(
              state.type == LoadingTypes.loadingDomain
                  ? 'initializing.loading_domain_list'.tr()
                  : 'basis.saving'.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          if (state is MoreThenOne)
            ...state.domains.map(
              (final domain) => Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedCard(
                      borderColor:
                          domain == selectedDomain
                              ? Theme.of(context).colorScheme.primary
                              : null,
                      borderWidth: domain == selectedDomain ? 3 : 1,
                      child: InkResponse(
                        highlightShape: BoxShape.rectangle,
                        onTap:
                            () => setState(() {
                              selectedDomain = domain;
                            }),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio<String>(
                                value: domain,
                                groupValue: selectedDomain,
                                onChanged: (final String? value) {
                                  setState(() {
                                    selectedDomain = value;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(
                                  domain,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Button to select and save domain
                ],
              ),
            ),
          if (state is MoreThenOne)
            BrandButton.filled(
              onPressed:
                  (selectedDomain != null &&
                          state.domains.contains(selectedDomain))
                      ? () => context.read<DomainSetupCubit>().saveDomain(
                        selectedDomain!,
                      )
                      : null,
              child: Text('initializing.use_this_domain'.tr()),
            ),
          if (state is Loaded) ...[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    state.domain,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ],
          if (state is Empty) ...[
            const SizedBox(height: 30),
            BrandButton.filled(
              onPressed: () => context.read<DomainSetupCubit>().load(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.refresh, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    'domain.update_list'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
          if (state is Loaded) ...[
            const SizedBox(height: 32),
            BrandButton.filled(
              onPressed:
                  () =>
                      context.read<DomainSetupCubit>().saveDomain(state.domain),
              title: 'initializing.save_domain'.tr(),
            ),
          ],
        ],
      ),
    );
  }
}
