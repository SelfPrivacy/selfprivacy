import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/preferences_repository/datasources/preferences_datasource.dart';
import 'package:selfprivacy/config/preferences_repository/preferences_repository.dart';

class _PreferencesRepositoryInjector extends InheritedWidget {
  const _PreferencesRepositoryInjector({
    required this.settingsRepository,
    required super.child,
  });

  final PreferencesRepository settingsRepository;

  @override
  bool updateShouldNotify(
    covariant final _PreferencesRepositoryInjector oldWidget,
  ) => oldWidget.settingsRepository != settingsRepository;
}

/// Creates and injects app preferences repository inside widget tree.
class InheritedPreferencesRepository extends StatefulWidget {
  const InheritedPreferencesRepository({
    required this.child,
    required this.dataSource,
    super.key,
  });

  final PreferencesDataSource dataSource;
  final Widget child;

  @override
  State<InheritedPreferencesRepository> createState() =>
      _InheritedPreferencesRepositoryState();

  static PreferencesRepository? of(final BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<_PreferencesRepositoryInjector>()
          ?.settingsRepository;
}

class _InheritedPreferencesRepositoryState
    extends State<InheritedPreferencesRepository> {
  late PreferencesRepository repo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// recreate repo each time dependencies change
    repo = PreferencesRepository(
      dataSource: widget.dataSource,
      setDelegateLocale: EasyLocalization.of(context)!.setLocale,
      resetDelegateLocale: EasyLocalization.of(context)!.resetLocale,
      getDelegateLocale: () => EasyLocalization.of(context)!.locale,
      getSupportedLocales: () => EasyLocalization.of(context)!.supportedLocales,
    );
  }

  @override
  Widget build(final BuildContext context) => _PreferencesRepositoryInjector(
    settingsRepository: repo,
    child: widget.child,
  );
}
