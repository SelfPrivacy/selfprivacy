import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';

class ServiceStatusCard extends StatelessWidget {
  const ServiceStatusCard({required this.status, super.key});
  final ServiceStatus status;

  @override
  Widget build(final BuildContext context) {
    late IconData icon;
    late String buttonTitle;

    switch (status) {
      case ServiceStatus.active:
        icon = Icons.check_circle_outline;
        buttonTitle = 'service_page.status.active';

      case ServiceStatus.inactive:
        icon = Icons.stop_circle_outlined;
        buttonTitle = 'service_page.status.inactive';

      case ServiceStatus.failed:
        icon = Icons.error_outline;
        buttonTitle = 'service_page.status.failed';

      case ServiceStatus.off:
        icon = Icons.power_settings_new;
        buttonTitle = 'service_page.status.off';

      case ServiceStatus.activating:
        icon = Icons.restart_alt_outlined;
        buttonTitle = 'service_page.status.activating';

      case ServiceStatus.deactivating:
        icon = Icons.restart_alt_outlined;
        buttonTitle = 'service_page.status.deactivating';

      case ServiceStatus.reloading:
        icon = Icons.restart_alt_outlined;
        buttonTitle = 'service_page.status.reloading';
    }

    return FilledCard(
      tertiary: true,
      child: ListTile(
        leading: Icon(icon, size: 24),
        title: Text(buttonTitle.tr()),
      ),
    );
  }
}
