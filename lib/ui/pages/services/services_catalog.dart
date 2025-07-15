import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/atoms/masks/icon_status_mask.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/placeholders/empty_page_placeholder.dart';
import 'package:selfprivacy/ui/router/router.dart';

@RoutePage()
class ServicesCatalogPage extends StatelessWidget {
  const ServicesCatalogPage({super.key});

  @override
  Widget build(final BuildContext context) {
    final availableServices =
        context.watch<ServicesBloc>().state.availableServices;

    if (availableServices.isEmpty) {
      return BrandHeroScreen(
        heroTitle: 'services_catalog.title'.tr(),
        heroIcon: Icons.menu_book_outlined,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 64),
            child: EmptyPagePlaceholder(
              title: 'services_catalog.empty_title'.tr(),
              description: 'services_catalog.empty_subtitle'.tr(),
              iconData: Icons.widgets_outlined,
            ),
          ),
        ],
      );
    }

    return BrandHeroScreen(
      heroTitle: 'services_catalog.title'.tr(),
      heroIcon: Icons.menu_book_outlined,
      children: [
        ...availableServices.map(
          (final service) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _ServicesCatalogPageCard(service: service),
          ),
        ),
      ],
    );
  }
}

class _ServicesCatalogPageCard extends StatelessWidget {
  const _ServicesCatalogPageCard({required this.service});

  final Service service;

  @override
  Widget build(final BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    child: InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => context.pushRoute(ServiceRoute(serviceId: service.id)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconStatusMask(
                  status: StateType.stable,
                  icon: SvgPicture.string(
                    service.svgIcon,
                    width: 32,
                    height: 32,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const Gap(8),
                Expanded(
                  child: Text(
                    service.displayName,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  service.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
