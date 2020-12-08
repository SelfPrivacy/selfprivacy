part of 'app_settings_cubit.dart';

class AppSettingsState extends Equatable {
  const AppSettingsState({
    @required this.isDarkModeOn,
  });

  final bool isDarkModeOn;

  @override
  List<Object> get props => [isDarkModeOn];
}
