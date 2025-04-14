import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/cards/services_page_card.dart';

@RoutePage()
class ServicesCatalogPage extends StatelessWidget {
  const ServicesCatalogPage({super.key});

  @override
  Widget build(final BuildContext context) {
    final availableServices =
        context.watch<ServicesBloc>().state.availableServices;

    return BrandHeroScreen(
      heroTitle: 'services_catalog.title'.tr(),
      heroIcon: Icons.menu_book_outlined,
      children: [
        ...availableServices.map(
          (final service) => Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
            ),
            child: ServicesPageCard(service: service),
          ),
        ),
      ],
    );
  }
}
