import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'catalog_case.dart';

class CatalogBinding extends WidgetsFlutterBinding {
  @override
  BinaryMessenger createBinaryMessenger() =>
      CatalogMessenger(super.createBinaryMessenger());
}

class CatalogMessenger extends BinaryMessenger {
  CatalogMessenger(this.delegate);
  final BinaryMessenger delegate;
  @override
  Future<ByteData?>? send(final String channel, final ByteData? message) {
    if (channel == 'flutter/platform' && message != null) {
      const codec = JSONMethodCodec();
      final call = codec.decodeMethodCall(message);
      if (call.method.startsWith('Clipboard.')) {
        catalogActions.record(
          call.method == 'Clipboard.setData'
              ? 'Copy to clipboard (preview)'
              : 'Read clipboard (preview)',
        );
        return Future.value(
          codec.encodeSuccessEnvelope(
            call.method == 'Clipboard.getData'
                ? <String, String>{'text': ''}
                : null,
          ),
        );
      }
    }
    if (channel.startsWith('dev.flutter.pigeon.url_launcher_linux.')) {
      const codec = StandardMessageCodec();
      catalogActions.record(
        'External link (preview): ${message == null ? '' : codec.decodeMessage(message)}',
      );
      return Future.value(
        codec.encodeMessage([
          if (channel.contains('canLaunchUrl')) true else null,
        ]),
      );
    }
    return delegate.send(channel, message);
  }

  @override
  void setMessageHandler(final String channel, final MessageHandler? handler) =>
      delegate.setMessageHandler(channel, handler);
  @override
  Future<void> handlePlatformMessage(
    final String channel,
    final ByteData? data,
    final ui.PlatformMessageResponseCallback? callback,
  ) =>
      // ignore: deprecated_member_use
      delegate.handlePlatformMessage(channel, data, callback);
}
