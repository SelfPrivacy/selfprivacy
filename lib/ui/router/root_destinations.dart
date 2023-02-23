import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/router/router.dart';

class RouteDestination {
  const RouteDestination({
    required this.route,
    required this.icon,
    required this.label,
    required this.title,
  });

  final PageRouteInfo route;
  final IconData icon;
  final String label;
  final String title;
}

final rootDestinations = [
  RouteDestination(
    route: const ProvidersRoute(),
    icon: BrandIcons.server,
    label: 'basis.providers'.tr(),
    title: 'basis.providers_title'.tr(),
  ),
  RouteDestination(
    route: const ServicesRoute(),
    icon: BrandIcons.box,
    label: 'basis.services'.tr(),
    title: 'basis.services'.tr(),
  ),
  RouteDestination(
    route: const UsersRoute(),
    icon: BrandIcons.users,
    label: 'basis.users'.tr(),
    title: 'basis.users'.tr(),
  ),
  RouteDestination(
    route: const MoreRoute(),
    icon: Icons.menu_rounded,
    label: 'basis.more'.tr(),
    title: 'basis.more'.tr(),
  ),
];
