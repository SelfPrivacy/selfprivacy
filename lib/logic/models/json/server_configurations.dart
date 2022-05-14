import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'server_configurations.g.dart';

@JsonSerializable(createToJson: true)
class AutoUpgradeConfigurations extends Equatable {
  const AutoUpgradeConfigurations({
    required this.enable,
    required this.allowReboot,
  });

  final bool enable;
  final bool allowReboot;

  factory AutoUpgradeConfigurations.fromJson(Map<String, dynamic> json) =>
      _$AutoUpgradeConfigurationsFromJson(json);
  Map<String, dynamic> toJson() => _$AutoUpgradeConfigurationsToJson(this);

  @override
  List<Object?> get props => [enable, allowReboot];
}
