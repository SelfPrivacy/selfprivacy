import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
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
  vpn,
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
      case ServiceTypes.vpn:
        return 'services.vpn.title'.tr();
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
      case ServiceTypes.vpn:
        return 'services.vpn.subtitle'.tr();
    }
  }

  String get loginInfo {
    switch (this) {
      case ServiceTypes.mail:
        return 'services.mail.login_info'.tr();
      case ServiceTypes.messenger:
        return 'services.messenger.login_info'.tr();
      case ServiceTypes.passwordManager:
        return 'services.password_manager.login_info'.tr();
      case ServiceTypes.video:
        return 'services.video.login_info'.tr();
      case ServiceTypes.cloud:
        return 'services.cloud.login_info'.tr();
      case ServiceTypes.socialNetwork:
        return 'services.social_network.login_info'.tr();
      case ServiceTypes.git:
        return 'services.git.login_info'.tr();
      case ServiceTypes.vpn:
        return '';
    }
  }

  String get subdomain {
    switch (this) {
      case ServiceTypes.passwordManager:
        return 'password';
      case ServiceTypes.video:
        return 'meet';
      case ServiceTypes.cloud:
        return 'cloud';
      case ServiceTypes.socialNetwork:
        return 'social';
      case ServiceTypes.git:
        return 'git';
      case ServiceTypes.vpn:
      case ServiceTypes.messenger:
      default:
        return '';
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
      case ServiceTypes.vpn:
        return Ionicons.shield_checkmark_outline;
    }
  }

  String get txt => this.toString().split('.')[1];
}
