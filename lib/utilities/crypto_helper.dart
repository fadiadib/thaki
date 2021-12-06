import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:thaki/globals/index.dart';
import 'package:encrypt/encrypt.dart';

class TkCryptoHelper {
  static String? hashSha256(String? input) {
    if (kDemoMode) return input;
    if (input == null) return input;
    Digest digest = sha256.convert(utf8.encode(input)); // Hashing Process

    return digest.toString();
  }

  static String hashMD5(String input) {
    if (input == null) return input;
    Digest digest = md5.convert(utf8.encode(input)); // Hashing Process

    return digest.toString();
  }

  static String hashAES(String input) {
    if (input == null) return input;
    var decoded = base64.decode('QSBnb29kIGRheSBpcyBhIGRheSB3aXRob3V0IHNub3c=');

    final key = Key.fromUtf8(utf8.decode(decoded));
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
    final encrypted = encrypter.encrypt(input, iv: iv);

    print(encrypted.base64);
    return encrypted.base64;
  }

  static String extractPayload(String payload) {
    String strPwd = "QSBnb29kIGRheSBpcyBhIGRheSB3aXRob3V0IHNub3c";
    String strIv = 'SuperSecretBLOCK';

    var decoded = base64.decode(strPwd);

    var iv = sha256
        .convert(utf8.encode(strIv))
        .toString()
        .substring(0, 16); // Consider the first 16 bytes of all 64 bytes

    IV ivObj = IV.fromUtf8(iv);
    Key keyObj = Key.fromUtf8(utf8.decode(decoded));

    final encrypter = Encrypter(
        AES(keyObj, mode: AESMode.cbc, padding: null)); // Apply CBC mode
    String firstBase64Decoding = new String.fromCharCodes(
        base64.decode(payload)); // First Base64 decoding
    final decrypted = encrypter.decrypt(
        Encrypted.fromBase64(firstBase64Decoding),
        iv: ivObj); // Second Base64 decoding (during decryption)
    return decrypted;
  }
}
