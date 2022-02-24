import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TkSocialLogin extends StatelessWidget {
  TkSocialLogin({this.callback});
  final Function callback;

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 64]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Apple login
  Future<void> signInWithApple(BuildContext context) async {
    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    account.socialError = null;

    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        // nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      account.user = TkUser.fromJson({
        kUserTag: {
          kUserFirstNameTag: appleCredential.givenName,
          kUserLastNameTag: appleCredential.familyName,
          kUserEmailTag: appleCredential.email,
          kUserSocialTokenTag: appleCredential.userIdentifier,
          kUserLoginTypeTag: 'Apple',
        }
      });

      callback();
    } catch (error) {
      account.socialError = S.of(context).kLoginUnsuccessful;
    }
  }

  /// Google login
  Future<void> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    account.socialError = null;
    try {
      if (googleUser == null) throw 'Social Login was cancelled';
      account.user = TkUser.fromJson({
        kUserTag: {
          kUserFirstNameTag: googleUser.displayName.split(' ').first,
          kUserLastNameTag: googleUser.displayName.split(' ').last,
          kUserEmailTag: googleUser.email,
          kUserSocialTokenTag: googleUser.id,
          kUserLoginTypeTag: 'Google',
        }
      });
      callback();
    } catch (error) {
      account.socialError = S.of(context).kLoginUnsuccessful;
    }
  }

  /// Facebook login
  Future<void> signInWithFacebook(BuildContext context) async {
    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    account.socialError = null;

    try {
      final LoginResult result = await FacebookAuth.instance.login();
      final token = result.accessToken.token;
      final graphResponse = await http.get(Uri(
          path:
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,middle_name,last_name,email&access_token=$token'));
      final profile = json.decode(graphResponse.body);

      account.user = TkUser.fromJson({
        kUserTag: {
          kUserFirstNameTag: profile['first_name'],
          kUserMiddleNameTag: profile['middle_name'],
          kUserLastNameTag: profile['last_name'],
          kUserEmailTag: profile['email'],
          kUserSocialTokenTag: result.accessToken.userId,
          kUserLoginTypeTag: 'Facebook',
        }
      });
      callback();
    } catch (error) {
      account.socialError = S.of(context).kLoginUnsuccessful;
    }
  }

  /// Twitter login
  Future<void> signInWithTwitter(BuildContext context) async {
    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    account.socialError = null;

    try {
      // Create a TwitterLogin instance
      final TwitterLogin twitterLogin = new TwitterLogin(
        apiKey: kTwitterAPIKey,
        apiSecretKey: kTwitterAPISecretKey,
        redirectURI: kTwitterRedirectURI,
      );

      final authResult = await twitterLogin.login();
      switch (authResult.status) {
        case TwitterLoginStatus.loggedIn:
          // success
          account.user = TkUser.fromJson({
            kUserTag: {
              kUserFirstNameTag: authResult.user.name.split(' ').first,
              kUserLastNameTag: authResult.user.name.split(' ').last,
              kUserEmailTag: authResult.user.email,
              kUserSocialTokenTag: authResult.authToken,
              kUserLoginTypeTag: 'Twitter',
            }
          });
          callback();
          return;
        case TwitterLoginStatus.cancelledByUser:
          // Cancelled
          account.socialError = S.of(context).kLoginCancelledByUser;
          return;
        case TwitterLoginStatus.error:
          // error
          account.socialError = authResult.errorMessage;
          return;
      }
    } catch (error) {
      account.socialError = S.of(context).kLoginUnsuccessful;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(S.of(context).kYouCanAlsoLoginWith),
        Container(
          width: 250,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (Platform.isIOS)
                GestureDetector(
                  child: Image.asset(kAppleBtn, height: 52.0),
                  onTap: () async {
                    await signInWithApple(context);
                  },
                ),
              GestureDetector(
                child: Image.asset(kFacebookBtn, height: 52.0),
                onTap: () async {
                  await signInWithFacebook(context);
                },
              ),
              GestureDetector(
                child: Image.asset(kTwitterBtn, height: 52.0),
                onTap: () async {
                  await signInWithTwitter(context);
                },
              ),
              GestureDetector(
                child: Image.asset(kGoogleBtn, height: 52.0),
                onTap: () async {
                  await signInWithGoogle(context);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
