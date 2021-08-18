import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';

enum InitializingSteps {
  setHeznerKey,
  setCloudFlareKey,
  setDomainName,
  setRootUser,
  createServer,
  checkCloudFlareDns,
  startServer,
  checkSystemDnsAndDkimSet,
}
enum Period { hour, day, month }

enum ServiceTypes {
  mail,
  messenger,
  passwordManager,
  video,
  cloud,
  socialNetwork,
  git,
}

extension ServiceTypesExt on ServiceTypes {
  String get title {
    switch (this) {
      case ServiceTypes.mail:
        return 'services.mail.title'.tr();
      case ServiceTypes.messenger:
        return 'services.messenger.title'.tr();
      case ServiceTypes.passwordManager:
        return 'services.password_manager.title'.tr();
      case ServiceTypes.video:
        return 'services.video.title'.tr();
      case ServiceTypes.cloud:
        return 'services.cloud.title'.tr();
      case ServiceTypes.socialNetwork:
        return 'services.social_network.title'.tr();
      case ServiceTypes.git:
        return 'services.git.title'.tr();
    }
  }

  String get subtitle {
    switch (this) {
      case ServiceTypes.mail:
        return 'services.mail.subtitle'.tr();
      case ServiceTypes.messenger:
        return 'services.messenger.subtitle'.tr();
      case ServiceTypes.passwordManager:
        return 'services.password_manager.subtitle'.tr();
      case ServiceTypes.video:
        return 'services.video.subtitle'.tr();
      case ServiceTypes.cloud:
        return 'services.cloud.subtitle'.tr();
      case ServiceTypes.socialNetwork:
        return 'services.social_network.subtitle'.tr();
      case ServiceTypes.git:
        return 'services.git.subtitle'.tr();
    }
  }

  IconData get icon {
    switch (this) {
      case ServiceTypes.mail:
        return BrandIcons.envelope;
      case ServiceTypes.messenger:
        return BrandIcons.messanger;
      case ServiceTypes.passwordManager:
        return BrandIcons.key;
      case ServiceTypes.video:
        return BrandIcons.webcam;
      case ServiceTypes.cloud:
        return BrandIcons.upload;
      case ServiceTypes.socialNetwork:
        return BrandIcons.social;
      case ServiceTypes.git:
        return BrandIcons.git;
    }
  }
}
