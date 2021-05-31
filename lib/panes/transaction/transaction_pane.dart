import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/providers/transactor.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/base/index.dart';

class TkTransactionPane extends TkPane {
  TkTransactionPane({onDone})
      : super(paneTitle: '', onDone: onDone, allowNavigation: true);

  /// Takes the context and user object and creates a web view
  /// widget showing the payment page
  Widget _getPaymentWebView(BuildContext context, TkTransactor transactor) {
    // Create web view controller
    final Completer<WebViewController> _webViewController =
        Completer<WebViewController>();

    return Container(
      height: 1000,
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
          onPageStarted: (String url) {},
          onPageFinished: (String url) async {
            if (url == transactor.callbackPage) onDone();
          },
        ),
      ),
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
