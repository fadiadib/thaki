import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';

import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/transactor.dart';

import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/general/logo_box.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/lists/transaction_list.dart';

class TkTransactionsScreen extends StatefulWidget {
  static String id = 'transactions_screen';

  @override
  _TkTransactionsScreenState createState() => _TkTransactionsScreenState();
}

class _TkTransactionsScreenState extends State<TkTransactionsScreen> {
  Future<void> _loadUserTransactions() async {
    final TkAccount account = Provider.of<TkAccount>(context, listen: false);
    final TkTransactor transactor =
        Provider.of<TkTransactor>(context, listen: false);

    await transactor.loadTransactions(user: account.user);
  }

  Widget _createTabs(TkTransactor transactor) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TabBar(
                isScrollable: true,
                labelStyle: kBoldStyle[kSmallSize].copyWith(
                    fontFamily:
                        Provider.of<TkLangController>(context, listen: false)
                            .fontFamily,
                    fontSize:
                        Provider.of<TkLangController>(context, listen: false)
                                .isRTL
                            ? 18.0
                            : 12.0),
                indicatorWeight: 4.0,
                labelColor: kPrimaryColor,
                indicatorColor: kPrimaryColor,
                unselectedLabelColor: kMediumGreyColor.withOpacity(0.5),
                tabs: [
                  Tab(text: S.of(context).kPackages.toUpperCase()),
                  Tab(text: S.of(context).kSubscriptions.toUpperCase()),
                  Tab(text: S.of(context).kViolations.toUpperCase()),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                TkTransactionList(
                  transactions: transactor.transactions<TkPackageTransaction>(),
                ),
                TkTransactionList(
                  transactions:
                      transactor.transactions<TkSubscriptionTransaction>(),
                ),
                TkTransactionList(
                  transactions:
                      transactor.transactions<TkViolationTransaction>(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadUserTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkTransactor>(
      builder: (context, transactor, child) {
        return RefreshIndicator(
          onRefresh: _loadUserTransactions,
          child: Scaffold(
            appBar: TkAppBar(
              context: context,
              enableNotifications: false,
              enableClose: true,
              removeLeading: false,
              title: TkLogoBox(),
            ),
            body: TkScaffoldBody(
              child: transactor.isLoading
                  ? TkProgressIndicator()
                  : transactor.loadTransactionsError != null
                      ? TkError(message: transactor.loadTransactionsError)
                      : _createTabs(transactor),
            ),
          ),
        );
      },
    );
  }
}
