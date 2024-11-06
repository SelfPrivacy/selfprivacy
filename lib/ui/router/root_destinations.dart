import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/icons/brand_icons.dart';
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

const List<RouteDestination> rootDestinations = [
  RouteDestination(
    route: ProvidersRoute(),
    icon: BrandIcons.server,
    label: 'basis.providers',
    title: 'basis.providers_title',
  ),
  RouteDestination(
    route: ServicesRoute(),
    icon: BrandIcons.box,
    label: 'basis.services',
    title: 'basis.services',
  ),
  RouteDestination(
    route: UsersRoute(),
    icon: BrandIcons.users,
    label: 'basis.users',
    title: 'basis.users',
  ),
  RouteDestination(
    route: MoreRoute(),
    icon: Icons.menu_rounded,
    label: 'basis.more',
    title: 'basis.more',
  ),
];
