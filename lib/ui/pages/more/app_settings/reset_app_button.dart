part of 'app_settings.dart';

class _ResetAppTile extends StatelessWidget {
  const _ResetAppTile({super.key});

  @override
  Widget build(final BuildContext context) => ListTile(
    title: Text('application_settings.reset_config_title'.tr()),
    subtitle: Text('application_settings.reset_config_description'.tr()),
    onTap:
        () => showDialog(
          context: context,
          builder: (final context) => const _ResetAppDialog(),
        ),
  );
}

class _ResetAppDialog extends StatelessWidget {
  const _ResetAppDialog();

  @override
  Widget build(final BuildContext context) => AlertDialog(
    title: Text('modals.are_you_sure'.tr()),
    content: Text('modals.purge_all_keys'.tr()),
    actions: [
      DialogActionButton(
        text: 'modals.purge_all_keys_confirm'.tr(),
        isRed: true,
        onPressed: () async {
          unawaited(context.read<ServerInstallationCubit>().clearAppConfig());

          unawaited(context.router.maybePop([const RootRoute()]));
          await context.resetLocale();
        },
      ),
      DialogActionButton(text: 'basis.cancel'.tr()),
    ],
  );
}
