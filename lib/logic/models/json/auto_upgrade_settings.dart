import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auto_upgrade_settings.g.dart';

@JsonSerializable(createToJson: true)
class AutoUpgradeSettings extends Equatable {
  factory AutoUpgradeSettings.fromJson(final Map<String, dynamic> json) =>
      _$AutoUpgradeSettingsFromJson(json);

  const AutoUpgradeSettings({
    required this.enable,
    required this.allowReboot,
  });
  final bool enable;
  final bool allowReboot;

  @override
  List<Object?> get props => [enable, allowReboot];

  Map<String, dynamic> toJson() => _$AutoUpgradeSettingsToJson(this);
}
