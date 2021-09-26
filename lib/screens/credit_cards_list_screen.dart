import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaki/globals/index.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/models/credit.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/screens/add_card_screen.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/lists/payment_list.dart';
import 'package:thaki/widgets/general/logo_box.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkCreditCardsListScreen extends StatefulWidget {
  static const String id = 'credit_cards_screen';

  @override
  _TkCreditCardsListScreenState createState() =>
      _TkCreditCardsListScreenState();
}

class _TkCreditCardsListScreenState extends State<TkCreditCardsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TkAccount>(
      builder: (context, account, _) {
        return Scaffold(
          appBar: TkAppBar(
            context: context,
            enableClose: true,
            enableNotifications: false,
            removeLeading: false,
            title: TkLogoBox(),
          ),
          body: TkScaffoldBody(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TkSectionTitle(
                    title: S.of(context).kMyCards,
                    icon: kAddCircleBtnIcon,
                    action: () =>
                        Navigator.of(context).pushNamed(TkAddCardScreen.id),
                  ),
                ),
                TkPaymentList(
                  langCode:
                      Provider.of<TkLangController>(context, listen: false)
                          .lang
                          .languageCode,
                  enableTitle: false,
                  cards: account.user.cards,
                  onTap: (TkCredit card) async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        settings: RouteSettings(name: TkAddCardScreen.id),
                        builder: (context) =>
                            TkAddCardScreen(editMode: true, card: card),
                      ),
                    );
                  },
                  onDelete: (TkCredit card) async {
                    if (await TkDialogHelper.gShowConfirmationDialog(
                          context: context,
                          message: S.of(context).kAreYouSureCard,
                          type: gDialogType.yesNo,
                        ) ??
                        false) account.deleteCard(card);
                  },
                  onEdit: (TkCredit card) async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        settings: RouteSettings(name: TkAddCardScreen.id),
                        builder: (context) =>
                            TkAddCardScreen(editMode: true, card: card),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
