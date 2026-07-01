import 'dart:convert';
import 'dart:typed_data';

/// Quite basic SSH public key validator, ported from our API at this commit:
/// https://git.selfprivacy.org/SelfPrivacy/selfprivacy-rest-api/src/commit/a1a567ca58ba2b0c82b880028ecf881d26b91bbe/selfprivacy_api/utils/ssh.py#L5
class SshValidator {
  static const List<String> validSshKeyTypes = [
    'ssh-rsa',
    'ssh-ed25519',
    'ecdsa-sha2-nistp256',
    'ecdsa-sha2-nistp384',
    'ecdsa-sha2-nistp521',
    'sk-ssh-ed25519@openssh.com',
    'sk-ecdsa-sha2-nistp256@openssh.com',
  ];

  static (String keyType, int keyTypeSize)? getBlobKeyType(
    final Uint8List bytes,
  ) {
    if (bytes.lengthInBytes <= 4) {
      return null;
    }
    final keyTypeSize = ByteData.sublistView(
      bytes,
      0,
      4,
    ).getUint32(0, Endian.big);
    if (4 + keyTypeSize > bytes.lengthInBytes) {
      return null;
    }
    try {
      return (ascii.decode(bytes.sublist(4, 4 + keyTypeSize)), 4 + keyTypeSize);
    } catch (e) {
      return null;
    }
  }

  /// returns RSA modulus bit-length from OpenSSH key blob. doesn't check if n is a prime or if e is sane.
  static int? rsaModulusFromBlob(final Uint8List bytes) {
    if (bytes.lengthInBytes < 4) {
      return null;
    }
    final eLen = ByteData.sublistView(bytes, 0, 4).getUint32(0, Endian.big);
    var offset = 4 + eLen;

    if (offset + 4 > bytes.lengthInBytes) {
      return null;
    }

    final nLen = ByteData.sublistView(
      bytes,
      offset,
      offset + 4,
    ).getUint32(0, Endian.big);

    offset += 4;
    if (offset + nLen > bytes.lengthInBytes) {
      return null;
    }

    final nBytes = bytes.sublist(offset, offset + nLen);
    if (nBytes.lengthInBytes == 0) {
      return null;
    }

    final start = (nBytes[0] == 0) ? 1 : 0;
    final n = BigInt.parse(
      nBytes
          .sublist(start)
          .map((final b) => b.toRadixString(16).padLeft(2, '0'))
          .join(),
      radix: 16,
    );
    return n.bitLength;
  }

  static bool validate(final String key) {
    if (key.trim().isEmpty) {
      return false;
    }

    try {
      final keyParts = key.trim().split(' ');

      if (keyParts.length < 2) {
        return false;
      }

      final keyType = keyParts[0];

      final rawKeyData = base64.decode(keyParts[1]);
      final keyTypeFromBlobResult = getBlobKeyType(rawKeyData);
      if (keyTypeFromBlobResult == null) {
        return false;
      }
      if (keyTypeFromBlobResult.$1 != keyType) {
        return false;
      }
      final keyData = rawKeyData.sublist(keyTypeFromBlobResult.$2);

      if (keyType == 'ssh-rsa') {
        final bits = rsaModulusFromBlob(keyData);
        if (bits == null) {
          return false;
        }
        if (bits < 2048 || bits > 16384) {
          return false;
        }
        return true;
      }
      if (validSshKeyTypes.contains(keyType)) {
        return true;
      }
    } catch (e) {
      return false;
    }

    return false;
  }
}
