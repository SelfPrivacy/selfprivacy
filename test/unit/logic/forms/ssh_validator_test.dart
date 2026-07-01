import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/forms/validators/ssh_validator.dart';

String _syntheticRsaPublicKey(final int nBits) {
  final n = (BigInt.one << (nBits - 1)) | BigInt.one;
  var nHex = n.toRadixString(16);
  if (nHex.length.isOdd) {
    nHex = '0$nHex';
  }
  final nBytes = <int>[];
  for (var i = 0; i < nHex.length; i += 2) {
    nBytes.add(int.parse(nHex.substring(i, i + 2), radix: 16));
  }
  final mpintN = (nBytes[0] & 0x80) != 0 ? <int>[0, ...nBytes] : nBytes;

  final keyType = ascii.encode('ssh-rsa');
  const e = <int>[0x01, 0x00, 0x01];

  final keyTypeLen = ByteData(4)..setUint32(0, keyType.length, Endian.big);
  final eLen = ByteData(4)..setUint32(0, e.length, Endian.big);
  final nLen = ByteData(4)..setUint32(0, mpintN.length, Endian.big);

  final blob = <int>[
    ...keyTypeLen.buffer.asUint8List(),
    ...keyType,
    ...eLen.buffer.asUint8List(),
    ...e,
    ...nLen.buffer.asUint8List(),
    ...mpintN,
  ];

  return 'ssh-rsa ${base64.encode(blob)}';
}

void main() {
  group('SshValidator', () {
    group('validate', () {
      group('ed25519', () {
        test('valid key with comment', () {
          expect(
            SshValidator.validate(
              'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+y1mUS1rFbuy2V5ndMWBwS4AavxjSt0JQGwUhddu1h user@host',
            ),
            isTrue,
          );
        });

        test('valid key without comment', () {
          expect(
            SshValidator.validate(
              'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+y1mUS1rFbuy2V5ndMWBwS4AavxjSt0JQGwUhddu1h',
            ),
            isTrue,
          );
        });

        test('invalid base64 blob', () {
          expect(
            SshValidator.validate('ssh-ed25519 notvalidbase64blob'),
            isFalse,
          );
        });
      });

      group('ecdsa', () {
        test('nistp256 valid', () {
          expect(
            SshValidator.validate(
              'ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBPPcBYLSjZw1TCE15ghjzLzYJzCdHhhQPCfqYNER615mhzafWsDTXkAQSkSmZv70Fv4fsJ9BNRQY8vnuaBdW7hc=',
            ),
            isTrue,
          );
        });

        test('nistp384 valid', () {
          expect(
            SshValidator.validate(
              'ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBOwLA7Z+0dZgAL8Xmshrz4vQ1+c/EQI5UnRg3gA5nJlG8awl33b+Br7FtFM1QhjyJ8nPtqN1+fk/6gY11vHZd4ljSKf6sIU2sc4dKyfzWve+69tVhSwrxKQGz+KWq4gkuA==',
            ),
            isTrue,
          );
        });

        test('nistp521 valid', () {
          expect(
            SshValidator.validate(
              'ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAG+613ehWb/xv4FYXYn5vV5Jaq6sPjtjhRnopQTT8bRiAVstMi+8vTqlatwEj3xlgAyqsKtGs1YiG7aKT39d1kNwQCvrt0P6jvhqcZizgBYn6VCuOJMVMJXxdVbNy65WKcrvDN0XK6qFB9p1fbMgK/rbsTvkUOv597e0OMvDzN7KxYfqQ==',
            ),
            isTrue,
          );
        });
      });

      group('fido2 / security keys', () {
        test('sk-ssh-ed25519@openssh.com valid', () {
          expect(
            SshValidator.validate(
              'sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIFuVzlSfuZREjXQmQgOat+NlFrCUhfjioAIfs6DQzhc+AAAABHNzaDo= yubi-A',
            ),
            isTrue,
          );
        });

        test('sk-ssh-ed25519@openssh.com valid without comment', () {
          expect(
            SshValidator.validate(
              'sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIFuVzlSfuZREjXQmQgOat+NlFrCUhfjioAIfs6DQzhc+AAAABHNzaDo=',
            ),
            isTrue,
          );
        });

        test('sk-ecdsa-sha2-nistp256@openssh.com valid', () {
          // The validator only checks that the header keytype matches the
          // blob's embedded keytype and that the keytype is on the allow-list,
          // so a synthetic blob with the right header is enough for non-RSA.
          const keyType = 'sk-ecdsa-sha2-nistp256@openssh.com';
          final keyTypeBytes = ascii.encode(keyType);
          final sizeBytes = ByteData(4)
            ..setUint32(0, keyTypeBytes.length, Endian.big);
          final blob = Uint8List.fromList([
            ...sizeBytes.buffer.asUint8List(),
            ...keyTypeBytes,
            0x00,
            0x00,
            0x00,
            0x00,
          ]);
          final b64 = base64.encode(blob);
          expect(SshValidator.validate('$keyType $b64'), isTrue);
        });
      });

      group('rsa', () {
        test('invalid base64 blob', () {
          expect(SshValidator.validate('ssh-rsa notvalidbase64blob'), isFalse);
        });

        test('1024 bits rejected', () {
          expect(
            SshValidator.validate(
              'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDi3CtYS/gAyWvMbEFmypOdHllyelZjHKlrb56R2moRgOg3aKDDP60rFF1EfzTrlKLq5pZbwJocCARMEDwrfXE1XJUFLTA7V+IAnsUGp7Hi9b7ZmP2VWJXsAi0v+jql0Oi49ZShWcUpufbbf7nScF5EOGRD0yW1wHrZSSZZCRL+pw==',
            ),
            isFalse,
          );
        });

        test('2048 bits accepted', () {
          expect(
            SshValidator.validate(
              'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZz/Yp5h+qn4NJ35d4yASYUYawABga7Vke8BpCRy6EVNAZusslSk0IjSBtDcCdCFEcZ+KW/d55E3bbWBAiSInPQ0hRFeeyDw34aDAJ+vhJ0CHQYFxSeyknnFIRPBnf8T15M7nlUor3JE1z2atoVwQTojmuqtGGqgoz9IK2GQy2WNw00fWlyh364QVKhIzINA7qi2mAkRpX08w8qmSxPQZC/51CuJ8aUuIIy79saLvRg/69EzPl5yaHwU0w24ivQxgNBr3cOL6tOBZnUZp3ilk6uf/LrpXjxRA9DZmLgS1/2AVEiVCCnIjxcTLlHf8Oqzeb7y5iohasEsh6YfmW42T3',
            ),
            isTrue,
          );
        });

        test('3072 bits accepted', () {
          expect(
            SshValidator.validate(
              'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCeJuwyezMS+mgeri2kiBsUTPmJd0PoF81Y3ea8/imCT5wLLtSGUk+vl2xwznQVHEpaD9TbIT5uhBFgJA/zmkc/B+cEAUfvs6MM8XhcDe2YECKD7NFHOEMrN745yD0hCvDtsK/YcT7mBWFjXfUl70SPBjUVz3baj4R7M6sBXxj8ZGYJi9SocHJGnpiW/Wjr2/sO4BxqKphmBx6OFeF9h0fw8ZUkE43gDYFyMxKt78+qUo0cScelQDh+p7BzWdloV/ENA46+CcoW7WCr/uTGo0Oa7ECE8Ws+D94TLjgJ0blDAnWJdggbzPoQqBBthKUiMbdBghcj972xx17dfMBlCpCyp9Kj84/SFEWVbkpjfWUjzlHwXvrkxdzY+z05zqMumSP+kF8P0lXVNtYOrOEto9/TZvrnJtG3tOswOj+4acxWgnxcfHKRjaKcyqjeNiEDYxpzm5egfb2PkG11E8171+Xit2ahTLqBDQWW3MdHtLNGJL/f2kp4ygPTSb4NZV4HfY0=',
            ),
            isTrue,
          );
        });

        test('4096 bits accepted', () {
          expect(
            SshValidator.validate(
              'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC4ImCHXy8c23Q1HVUrLX6ItTL8uKSwcaujBgZ3NSpIk6FsbJhQmhETAdiu6UZRHTZ3Bv3jUmW70sQDd5VS1dNOsqnoU2qFTGlqUKKXh99RgChEuvGndEA1xq5iuxouzOx2P2dcfk6KQEB/Kyoj3dg9JI9MtyeDzTtV+VDrNl75GxfQoZ6cZaIkwDC/3fU71XzizBl4IIjNCQLgSVZ78/AZq5XOxGBGRdRGOeklhGq96A+XlM1hMIEaWJddqFGQwC20aw4jKAzOPnyYJG4/FNlw9pTiMWP20/aEey6uxAgyzrkYHb+6edtM2ouDt+SctuRsNaVD3VyjiXaCw3Hd+8iclpzioFc9ZdExflBENK70AxBZ5/N70RIAPK2X2o/P6xe416fJ00hZon5MX4Mp1W6yRII75HTshqw5R4yJdMPJtmCe8nKbt0jpR4y4fMnfS+aYX471SEvbGK12OniT+kayDa3ZPxGlskX6wQgS+zFkwioRWsk3k++WJc1h2Q/skNrbUpfu6WkS3udJcc8eIXTGD/6Dp5eJAynKkHR6BXJSHXB4lpzdplaE+ETr/yCJaVWIpeZrhJVa0eN/xY7V9qcERMYUabKj4BMcv8n1NQELUPLZtLjz0QOj41n12/RAGNo0JgxWeg+C7GqVwxBnAunxBfHwECDiDM2dlVLewV0oXQ==',
            ),
            isTrue,
          );
        });

        test('16384 bits accepted (upper bound)', () {
          expect(SshValidator.validate(_syntheticRsaPublicKey(16384)), isTrue);
        });

        test('16385 bits rejected (above upper bound)', () {
          expect(SshValidator.validate(_syntheticRsaPublicKey(16385)), isFalse);
        });
      });

      group('malformed input', () {
        test('empty string', () {
          expect(SshValidator.validate(''), isFalse);
        });

        test('whitespace only', () {
          expect(SshValidator.validate('   '), isFalse);
        });

        test('key type only, no blob', () {
          expect(SshValidator.validate('ssh-ed25519'), isFalse);
        });

        test('unknown key type', () {
          expect(
            SshValidator.validate(
              'ssh-dss AAAAB3NzaC1kc3MAAACBAP//////////////////////',
            ),
            isFalse,
          );
        });

        test('key type mismatch between header and blob', () {
          // blob says ssh-ed25519 but header says ecdsa-sha2-nistp256
          expect(
            SshValidator.validate(
              'ecdsa-sha2-nistp256 AAAAC3NzaC1lZDI1NTE5AAAAIK+y1mUS1rFbuy2V5ndMWBwS4AavxjSt0JQGwUhddu1h',
            ),
            isFalse,
          );
        });

        test('blob key_type_size exceeds blob length', () {
          // key_type_size = 100 but actual key type is only 11 bytes
          final malformedBlob = Uint8List.fromList([
            0x00,
            0x00,
            0x00,
            0x64,
            ...ascii.encode('ssh-ed25519'),
          ]);
          final b64 = base64.encode(malformedBlob);
          expect(SshValidator.validate('ssh-ed25519 $b64'), isFalse);
        });

        test('leading/trailing whitespace is tolerated', () {
          expect(
            SshValidator.validate(
              '  ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+y1mUS1rFbuy2V5ndMWBwS4AavxjSt0JQGwUhddu1h  ',
            ),
            isTrue,
          );
        });

        test('multi-word comment is tolerated', () {
          expect(
            SshValidator.validate(
              'sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIFuVzlSfuZREjXQmQgOat+NlFrCUhfjioAIfs6DQzhc+AAAABHNzaDo= yubi key slot A',
            ),
            isTrue,
          );
        });

        test('zero-length key type in blob returns false', () {
          final blob = Uint8List.fromList([0x00, 0x00, 0x00, 0x00, 0x00]);
          final b64 = base64.encode(blob);
          expect(SshValidator.validate('ssh-ed25519 $b64'), isFalse);
        });

        test('rsa blob too short after eLen returns false', () {
          // eLen = 0xFFFFFF pushes offset way past end of bytes
          final blob = Uint8List.fromList([0x00, 0xFF, 0xFF, 0xFF, 0x00]);
          final b64 = base64.encode(blob);
          expect(SshValidator.validate('ssh-rsa $b64'), isFalse);
        });

        test('non-ASCII bytes in blob keytype are rejected', () {
          // ascii.decode throws on bytes > 0x7F; getBlobKeyType swallows it
          // and returns null, so validate must surface that as false rather
          // than letting the exception escape.
          final blob = Uint8List.fromList([
            0x00,
            0x00,
            0x00,
            0x04,
            0x80,
            0x81,
            0x82,
            0x83,
          ]);
          final b64 = base64.encode(blob);
          expect(SshValidator.validate('ssh-ed25519 $b64'), isFalse);
        });
      });
    });

    group('getBlobKeyType', () {
      test('returns null for blobs shorter than 5 bytes', () {
        expect(SshValidator.getBlobKeyType(Uint8List(4)), isNull);
      });

      test('returns null when key_type_size exceeds blob', () {
        final bytes = Uint8List.fromList([0x00, 0x00, 0x00, 0x64, 0x61]);
        expect(SshValidator.getBlobKeyType(bytes), isNull);
      });

      test('parses key type correctly', () {
        final keyType = ascii.encode('ssh-ed25519');
        final sizeBytes = ByteData(4)..setUint32(0, keyType.length, Endian.big);
        final blob = Uint8List.fromList([
          ...sizeBytes.buffer.asUint8List(),
          ...keyType,
          0x00,
        ]);
        final result = SshValidator.getBlobKeyType(blob);
        expect(result, isNotNull);
        expect(result!.$1, equals('ssh-ed25519'));
        expect(result.$2, equals(4 + keyType.length));
      });

      test('returns null when keytype bytes are non-ASCII', () {
        final bytes = Uint8List.fromList([
          0x00,
          0x00,
          0x00,
          0x04,
          0x80,
          0x81,
          0x82,
          0x83,
        ]);
        expect(SshValidator.getBlobKeyType(bytes), isNull);
      });
    });
  });
}
