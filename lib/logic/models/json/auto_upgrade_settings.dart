import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auto_upgrade_settings.g.dart';

@JsonSerializable(createToJson: true)
class AutoUpgradeSettings extends Equatable {
  final bool enable;
  final bool allowReboot;

  const AutoUpgradeSettings({
    required this.enable,
    required this.allowReboot,
  });

  @override
  List<Object?> get props => [enable, allowReboot];
  factory AutoUpgradeSettings.fromJson(Map<String, dynamic> json) =>
      _$AutoUpgradeSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$AutoUpgradeSettingsToJson(this);
}
