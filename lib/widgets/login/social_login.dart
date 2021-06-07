import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// Facebook
// Key Hash: xSLzBBuLJunOQPB89rtzM54FXx4=

class TkSocialLogin extends StatelessWidget {
  TkSocialLogin({this.callback});
  final Function callback;

  Future<void> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    account.socialError = null;
    try {
      account.user = TkUser.fromJson({
        kUserTag: {
          kUserNameTag: googleUser.displayName,
          kUserEmailTag: googleUser.email,
          kUserSocialTokenTag: googleUser.id,
          kUserLoginTypeTag: 'Google',
        }
      });
      callback();
    } catch (error) {
      account.socialError = error;
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    final AccessToken result = await FacebookAuth.instance.login();
  }

  Future<void> signInWithTwitter(BuildContext context) async {
    // Create a TwitterLogin instance
    final TwitterLogin twitterLogin = new TwitterLogin(
      apiKey: kTwitterAPIKey,
      apiSecretKey: kTwitterAPISecretKey,
      redirectURI: kTwitterRedirectURI3,
    );

    final authResult = await twitterLogin.login();
    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    account.socialError = null;

    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        // success
        print(authResult.user.name);
        print(authResult.user.email);
        account.user = TkUser.fromJson({
          kUserTag: {
            kUserNameTag: authResult.user.name,
            kUserEmailTag: authResult.user.email,
            kUserSocialTokenTag: authResult.user.hashCode.toString(),
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
              )
            ],
          ),
        )
      ],
    );
  }
}
