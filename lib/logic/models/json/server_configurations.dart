import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'server_configurations.g.dart';

@JsonSerializable(createToJson: true)
class AutoUpgradeConfigurations extends Equatable {
  const AutoUpgradeConfigurations({
    required this.enable,
    required this.allowReboot,
  });

  factory AutoUpgradeConfigurations.fromJson(final Map<String, dynamic> json) =>
      _$AutoUpgradeConfigurationsFromJson(json);

  final bool enable;
  final bool allowReboot;
  Map<String, dynamic> toJson() => _$AutoUpgradeConfigurationsToJson(this);

  @override
  List<Object?> get props => [enable, allowReboot];
}
