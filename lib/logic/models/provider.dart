import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';

enum ProviderType {
  server,
  domain,
  backup,
}

class ProviderModel extends Equatable {
  const ProviderModel({this.state, this.type});

  final StateType state;
  final ProviderType type;

  ProviderModel updateState(StateType newState) => ProviderModel(
        state: newState,
        type: type,
      );

  @override
  List<Object> get props => [state, type];

  IconData get icon {
    switch (type) {
      case ProviderType.server:
        return BrandIcons.server;

      case ProviderType.domain:
        return BrandIcons.globe;

        break;
      case ProviderType.backup:
        return BrandIcons.save;
    }
    return null;
  }
}
