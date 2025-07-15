import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/config_item_fields/basic_bool_config_item.dart';
import 'package:selfprivacy/ui/molecules/config_item_fields/basic_enum_config_item.dart';
import 'package:selfprivacy/ui/molecules/config_item_fields/basic_string_config_item.dart';
import 'package:selfprivacy/ui/molecules/config_item_fields/domain_string_config_item.dart';

@RoutePage()
class ServiceSettingsPage extends StatefulWidget {
  const ServiceSettingsPage({
    required this.serviceId,
    this.isInstalling = false,
    super.key,
  });

  final bool isInstalling;
  final String serviceId;

  @override
  State<ServiceSettingsPage> createState() => _ServiceSettingsPageState();
}

class _ServiceSettingsPageState extends State<ServiceSettingsPage> {
  Map<String, dynamic> settings = {};
  bool isFormValid = true;
  bool isJobAlreadyExists = false;

  Widget configurationItemToWidget(
    final BuildContext context,
    final ServiceConfigItem configItem,
    final Map<String, dynamic> settings,
  ) {
    switch (configItem) {
      case StringServiceConfigItem():
        // ignore: avoid_positional_boolean_parameters
        void onChanged(final String value, final bool isFieldValid) {
          if (isFieldValid) {
            setState(() {
              if (value == configItem.value) {
                settings.remove(configItem.id);
              } else {
                settings[configItem.id] = value;
              }
              isFormValid = true;
            });
          } else {
            setState(() {
              isFormValid = false;
            });
          }
        }
        if (configItem.widget == 'subdomain') {
          return DomainStringConfigItem(
            configItem: configItem,
            newValue: settings[configItem.id],
            onChanged: onChanged,
          );
        }
        return BasicStringConfigItem(
          configItem: configItem,
          newValue: settings[configItem.id],
          onChanged: onChanged,
        );
      case BoolServiceConfigItem():
        // ignore: avoid_positional_boolean_parameters
        void onChanged(final bool value) {
          setState(() {
            if (value == configItem.value) {
              settings.remove(configItem.id);
            } else {
              settings[configItem.id] = value;
            }
          });
        }
        return BasicBoolConfigItem(
          configItem: configItem,
          newValue: settings[configItem.id],
          onChanged: onChanged,
        );

      case EnumServiceConfigItem():
        void onChanged(final String value) {
          setState(() {
            if (value == configItem.value) {
              settings.remove(configItem.id);
            } else {
              settings[configItem.id] = value;
            }
          });
        }
        return BasicEnumConfigItem(
          configItem: configItem,
          newValue: settings[configItem.id],
          onChanged: onChanged,
        );
      case FallbackServiceConfigItem():
        return ListTile(
          title: Text(configItem.description),
          subtitle: Text(configItem.id),
          trailing: Text(configItem.type),
          leading: const Icon(Icons.error),
        );
      case IntServiceConfigItem():
        return ListTile(
          title: Text(configItem.description),
          subtitle: Text(configItem.id),
          trailing: Text(configItem.value.toString()),
          leading: const Icon(Icons.error),
        );
    }
  }

  @override
  void initState() {
    super.initState();

    final JobsState state = context.read<JobsCubit>().state;

    if (state is JobsStateWithJobs) {
      final ChangeServiceConfiguration? existingJob =
          state.clientJobList.firstWhereOrNull(
                (final ClientJob job) =>
                    job is ChangeServiceConfiguration &&
                    job.serviceId == widget.serviceId,
              )
              as ChangeServiceConfiguration?;
      if (existingJob != null) {
        setState(() {
          settings = existingJob.settings;
          isJobAlreadyExists = true;
        });
      }
    }
  }

  @override
  Widget build(final BuildContext context) {
    final Service? service = context.watch<ServicesBloc>().state.getServiceById(
      widget.serviceId,
    );

    if (service == null) {
      return const BrandHeroScreen(
        hasBackButton: true,
        children: [Center(child: CircularProgressIndicator.adaptive())],
      );
    }

    final JobsState state = context.watch<JobsCubit>().state;

    if (state is JobsStateLoading) {
      return BrandHeroScreen(
        hasBackButton: true,
        hasFlashButton: true,
        heroIconWidget: SvgPicture.string(
          service.svgIcon,
          width: 48,
          height: 48,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
        heroTitle: service.displayName,
        heroSubtitle: 'service_page.settings'.tr(),
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'service_page.wait_for_jobs'.tr(),
                  textAlign: TextAlign.center,
                ),
                const Gap(16),
                const CircularProgressIndicator.adaptive(),
              ],
            ),
          ),
        ],
      );
    }

    final bool isModified = settings.isNotEmpty;

    return BrandHeroScreen(
      hasBackButton: true,
      hasFlashButton: true,
      heroIconWidget: SvgPicture.string(
        service.svgIcon,
        width: 48,
        height: 48,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onSurface,
          BlendMode.srcIn,
        ),
      ),
      heroTitle: service.displayName,
      heroSubtitle: 'service_page.settings'.tr(),
      children: [
        ...service.configuration.map(
          (final ServiceConfigItem configItem) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: configurationItemToWidget(context, configItem, settings),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: FilledButton(
            onPressed:
                ((widget.isInstalling || isModified) && isFormValid)
                    ? () async {
                      if (widget.isInstalling) {
                        context.read<JobsCubit>().addJob(
                          ServiceToggleJob(
                            service: service,
                            needToTurnOn: true,
                          ),
                        );
                      }
                      context.read<JobsCubit>().addJob(
                        ChangeServiceConfiguration(
                          serviceId: service.id,
                          serviceDisplayName: service.displayName,
                          settings: settings,
                        ),
                      );
                      if (widget.isInstalling) {
                        context.router.popUntilRoot();
                      } else {
                        await context.router.maybePop();
                      }
                    }
                    : null,
            child: Text(
              isJobAlreadyExists
                  ? 'service_page.update_job'.tr()
                  : 'service_page.create_job'.tr(),
            ),
          ),
        ),
      ],
    );
  }
}
