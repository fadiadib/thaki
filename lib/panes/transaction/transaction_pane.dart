import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/providers/transactor.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/base/index.dart';

class TkTransactionPane extends TkPane {
  TkTransactionPane({onDone, onClose, this.guest = false, @required this.type})
      : super(
          paneTitle: '',
          onDone: onDone,
          onClose: onClose,
          allowNavigation: false,
        );
  final bool guest;
  final TkTransactionType type;

  void _paymentCallback(bool result) => onDone();

  /// Takes the context and user object and creates a web view
  /// widget showing the payment page
  Widget _getPaymentWebView(BuildContext context, TkTransactor transactor) {
    // Create web view controller
    final Completer<WebViewController> _webViewController =
        Completer<WebViewController>();

    return Stack(
      children: [
        Container(
          height: 1000,
          // width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: WebView(
              initialUrl: transactor.transactionPage.replaceAll(' ', '%20'),
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true,
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController.complete(webViewController);
              },
              navigationDelegate: (NavigationRequest request) {
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                transactor.isTransacting = true;

                if (url == transactor.transactionPage) {
                  transactor.startTransactionChecker(
                    type: type,
                    user: Provider.of<TkAccount>(context, listen: false).user,
                    langController:
                        Provider.of<TkLangController>(context, listen: false),
                    guest: guest,
                    callback: _paymentCallback,
                  );
                }
              },
              onPageFinished: (String url) async {
                transactor.isTransacting = false;

                if (url == transactor.callbackPage) {
                  transactor.stopTransactionChecker();
                  onDone();
                }
              },
            ),
          ),
        ),
        if (transactor.isTransacting)
          Align(
            alignment: Alignment.center,
            child: TkProgressIndicator(color: kSecondaryColor.withOpacity(0.5)),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkTransactor>(builder: (context, transactor, _) {
      return transactor.isLoading
          ? TkProgressIndicator()
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child:
                      TkSectionTitle(title: S.of(context).kEnterPaymentDetails),
                ),
                transactor.transactionError == null
                    ? _getPaymentWebView(context, transactor)
                    : TkError(message: transactor.transactionError),
              ],
            );
    });
  }
}
