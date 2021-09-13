import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/lang_controller.dart';

class TkTabs extends StatelessWidget {
  TkTabs(
      {@required this.length, @required this.titles, @required this.children});
  final int length;
  final List<String> titles;
  final List<Widget> children;

  List<Widget> _getTitleTabs() {
    List<Widget> _tabsTitles = [];

    for (String title in titles) {
      _tabsTitles.add(Tab(text: title));
    }

    return _tabsTitles;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: length,
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
                tabs: _getTitleTabs(),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(children: children),
          ),
        ],
      ),
    );
  }
}
