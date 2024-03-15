import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/ui/components/brand_loader/brand_loader.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/utils/breakpoints.dart';
import 'package:selfprivacy/utils/extensions/duration.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';
import 'package:timezone/timezone.dart';

part 'server_settings.dart';
part 'time_zone/time_zone.dart';

@RoutePage()
class ServerSettingsScreen extends StatefulWidget {
  const ServerSettingsScreen({super.key});

  @override
  State<ServerSettingsScreen> createState() => _ServerSettingsScreenState();
}

class _ServerSettingsScreenState extends State<ServerSettingsScreen> {
  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
        hasFlashButton: true,
        heroIcon: Icons.settings_outlined,
        heroTitle: 'server.settings'.tr(),
        children: const [
          _ServerSettings(),
        ],
      );
}
