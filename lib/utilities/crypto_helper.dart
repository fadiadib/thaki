import 'dart:convert';
import 'package:crypto/crypto.dart';

class TkCryptoHelper {
  String hashSha256(String input) {
    Digest digest = sha256.convert(utf8.encode(input)); // Hashing Process

    return digest.toString();
  }
}
