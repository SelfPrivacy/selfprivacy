import 'package:hive/hive.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:pointycastle/api.dart' as crypto;
import 'package:ssh_key/ssh_key.dart' as ssh_key;

class SSHModel {
  Box _box = Hive.box(BNames.sshConfig);
  String? savedPrivateKey;
  String? savedPubKey;

  Future<void> generateKeys() async {
    var helper = RsaKeyHelper();
    crypto.AsymmetricKeyPair pair =
        await helper.computeRSAKeyPair(helper.getSecureRandom());
    var privateKey = pair.privateKey as RSAPrivateKey;
    var publicKey = pair.publicKey as RSAPublicKey;

    savedPrivateKey = helper.encodePrivateKeyToPemPKCS1(privateKey);
    savedPubKey = publicKey.encode(ssh_key.PubKeyEncoding.openSsh);

    await _box.put(BNames.sshPrivateKey, savedPrivateKey);
    await _box.put(BNames.sshPublicKey, savedPubKey);
  }

  void init() {
    savedPrivateKey = _box.get(BNames.sshPrivateKey);
    savedPubKey = _box.get(BNames.sshPublicKey);
  }

  bool get isSSHKeyGenerated => savedPrivateKey != null && savedPubKey != null;

  clear() async {
    savedPrivateKey = null;
    savedPubKey = null;
    await _box.clear();
  }
}
