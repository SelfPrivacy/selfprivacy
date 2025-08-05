import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// SelfPrivacy wrapper for Platform information provider.
class PlatformAdapter {
  /// Persistent storage directory for data files.
  static String? get storagePath {
    String? path;
    if (Platform.isLinux) {
      // https://wiki.archlinux.org/title/XDG_Base_Directory
      path = Platform.environment['XDG_DATA_HOME'];
      if (path == null) {
        final String home = Platform.environment['HOME'] ?? '.';
        path = '$home/.local/share';
      }
      path += '/selfprivacy';
    }

    return path;
  }

  /// Running operating environment.
  static Future<String> get deviceName async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      return deviceInfo.webBrowserInfo.then(
        (final WebBrowserInfo value) =>
            '${value.browserName} ${value.platform}',
      );
    } else {
      if (Platform.isAndroid) {
        return deviceInfo.androidInfo.then(
          (final AndroidDeviceInfo value) =>
              '${value.model} ${value.version.release}',
        );
      } else if (Platform.isIOS) {
        return deviceInfo.iosInfo.then(
          (final IosDeviceInfo value) =>
              '${value.utsname.machine} ${value.systemName} ${value.systemVersion}',
        );
      } else if (Platform.isLinux) {
        return deviceInfo.linuxInfo.then(
          (final LinuxDeviceInfo value) => value.prettyName,
        );
      } else if (Platform.isMacOS) {
        return deviceInfo.macOsInfo.then(
          (final MacOsDeviceInfo value) =>
              '${value.hostName} ${value.computerName}',
        );
      } else if (Platform.isWindows) {
        return deviceInfo.windowsInfo.then(
          (final WindowsDeviceInfo value) => value.computerName,
        );
      }
    }

    return 'Unidentified';
  }

  static Future<void> setClipboard(final String clipboardData) async {
    await Clipboard.setData(ClipboardData(text: clipboardData));
  }
}
