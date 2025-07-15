part of 'app_settings.dart';

class _LanguagePicker extends StatelessWidget {
  const _LanguagePicker({super.key});

  @override
  Widget build(final BuildContext context) => ListTile(
    title: Text('application_settings.language'.tr()),
    subtitle: Text('application_settings.click_to_change_locale'.tr()),
    trailing: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        Localization.getLanguageName(context.locale),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    ),
    onTap: () async {
      final appController = InheritedAppController.of(context);
      final Locale? newLocale = await showDialog<Locale?>(
        context: context,
        builder: (final context) => const _LanguagePickerDialog(),
        routeSettings: _LanguagePickerDialog.routeSettings,
      );

      if (newLocale != null) {
        await appController.setLocale(newLocale);
      }
    },
  );
}

class _LanguagePickerDialog extends StatelessWidget {
  const _LanguagePickerDialog();
  static const routeSettings = RouteSettings(name: 'LanguagePickerDialog');

  @override
  Widget build(final BuildContext context) {
    final appController = InheritedAppController.of(context);

    return SimpleDialog(
      title: Text('application_settings.language'.tr()),
      children: [
        for (final locale in appController.supportedLocales)
          RadioMenuButton(
            groupValue: appController.locale,
            value: locale,
            child: Text(
              Localization.getLanguageName(locale),
              style: TextStyle(
                fontWeight:
                    locale == appController.locale
                        ? FontWeight.w800
                        : FontWeight.w400,
              ),
            ),
            onChanged: (final newValue) => Navigator.of(context).pop(newValue),
          ),
      ],
    );
  }
}
