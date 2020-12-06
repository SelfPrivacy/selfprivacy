import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';

enum ProviderTypes {
  server,
  domain,
  backup,
}

class ProviderModel extends Equatable {
  const ProviderModel({this.state, this.type});

  final ServiceStateType state;
  final ProviderTypes type;

  ProviderModel updateState(ServiceStateType newState) => ProviderModel(
        state: newState,
        type: type,
      );

  @override
  List<Object> get props => [state, type];

  IconData get icon {
    switch (type) {
      case ProviderTypes.server:
        return BrandIcons.server;

      case ProviderTypes.domain:
        return BrandIcons.globe;

        break;
      case ProviderTypes.backup:
        return BrandIcons.save;
    }
    return null;
  }
}
