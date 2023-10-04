import 'package:auto_route/auto_route.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/backups_wizard/backups_wizard_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/components/buttons/outlined_button.dart';
import 'package:selfprivacy/ui/components/drawers/progress_drawer.dart';
import 'package:selfprivacy/ui/components/progress_bar/progress_bar.dart';
import 'package:selfprivacy/ui/components/drawers/support_drawer.dart';
import 'package:selfprivacy/ui/pages/backups/setup/backup_provider_picker.dart';
import 'package:selfprivacy/ui/pages/backups/setup/backup_settings_page.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/breakpoints.dart';

@RoutePage()
class BackupsInitializingPage extends StatelessWidget {
  const BackupsInitializingPage({super.key});

  @override
  Widget build(final BuildContext context) {
    final Widget actualInitializingPage;
    final cubit = context.watch<BackupsWizardCubit>();
    final currentStep = cubit.state.currentStep;
    switch (currentStep) {
      case BackupsWizardStep.settingsInitialization:
        actualInitializingPage = const BackupSettingsPage();
        break;
      case BackupsWizardStep.hostingRecovery:
      case BackupsWizardStep.hostingInitialization:
      default:
        actualInitializingPage = const BackupProviderPicker();
        break;
    }

    final List<String> titles = [
      'backup.steps.hosting',
      'backup.steps.period',
      'backup.steps.rotation',
    ];

    return BlocListener<BackupsWizardCubit, BackupsWizardState>(
      listener: (final context, final state) {
        if (cubit.state.currentStep == BackupsWizardStep.finished) {
          context.router.pop();
        }
      },
      child: Scaffold(
        endDrawer: const SupportDrawer(),
        endDrawerEnableOpenDragGesture: false,
        appBar: Breakpoints.large.isActive(context)
            ? null
            : AppBar(
                actions: [
                  if (cubit.state.currentStep == BackupsWizardStep.finished)
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        context.router.pop();
                      },
                    ),
                  const SizedBox.shrink(),
                ],
                title: Text(
                  'more_page.configuration_wizard'.tr(),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(28),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: ProgressBar(
                      steps: const [
                        'Hosting',
                        'Automatic backups',
                        'Rotation settings',
                      ],
                      activeIndex: currentStep.index,
                    ),
                  ),
                ),
              ),
        body: LayoutBuilder(
          builder: (final context, final constraints) => Row(
            children: [
              if (Breakpoints.large.isActive(context))
                ProgressDrawer(
                  steps: titles,
                  currentStep: currentStep.index,
                  title: 'more_page.configuration_wizard'.tr(),
                  constraints: constraints,
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (cubit.state is ServerInstallationEmpty ||
                          cubit.state is ServerInstallationNotFinished)
                        Container(
                          alignment: Alignment.center,
                          child: BrandButton.filled(
                            text: 'basis.connect_to_existing'.tr(),
                            onPressed: () {
                              context.router.replace(const RecoveryRoute());
                            },
                          ),
                        ),
                      // const SizedBox(height: 8),
                      BrandOutlinedButton(
                        child: Text(
                          'basis.later'.tr(),
                        ),
                        onPressed: () {
                          context.router.pop();
                        },
                      ),
                    ],
                  ),
                ),
              SizedBox(
                width: constraints.maxWidth -
                    (Breakpoints.large.isActive(context) ? 300 : 0),
                height: constraints.maxHeight,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: Breakpoints.large.isActive(context)
                            ? const EdgeInsets.all(16.0)
                            : const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0.0),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: actualInitializingPage,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
