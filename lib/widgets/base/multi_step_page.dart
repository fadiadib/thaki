import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/general/logo_box.dart';

abstract class TkMultiStepPage extends StatefulWidget {
  @override
  TkMultiStepPageState createState() => TkMultiStepPageState();
}

class TkMultiStepPageState extends State<TkMultiStepPage> {
  /// Panes control
  int _paneIndex = 0;
  List<TkPane> _panes = [];

  /// Returns the current pane title
  // String _getPaneTitle() => _panes[_paneIndex].title;

  /// Loads the previous pane in the list
  Future<bool> _loadPreviousPane() async {
    //  Disallow navigating back when pane 4 (payment web view) is active
    if (!_panes[_paneIndex].allowNavigation) return false;

    if (_paneIndex > 0) {
      setState(() => _paneIndex--);
    } else {
      _paneIndex = 0;
      Navigator.pop(context);
    }
    return false;
  }

  /// Loads the next pane in the list - Must be called in
  /// the onDone callback for all child panes
  void loadNextPane({bool advance = false}) {
    if (advance) {
      if (_paneIndex < _panes.length - 2) {
        setState(() => _paneIndex += 2);
      } else {
        _paneIndex = 0;
        Navigator.pop(context);
      }
    } else {
      if (_paneIndex < _panes.length - 1) {
        setState(() => _paneIndex++);
      } else {
        _paneIndex = 0;
        Navigator.pop(context);
      }
    }
  }

  /// Creates the panes - Must be overridden
  List<TkPane> getPanes() => null;

  /// Initializes the data - Must be overridden
  void initData() {}

  @override
  void initState() {
    super.initState();

    // Initialize panes
    _panes = getPanes();

    // Initialize data
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _loadPreviousPane,
      child: Scaffold(
        appBar: TkAppBar(
          context: context,
          enableNotifications: false,
          enableClose: _panes[_paneIndex].close,
          removeLeading: !_panes[_paneIndex].allowNavigation,

          // Back button
          leading: _panes[_paneIndex].allowNavigation
              ? IconButton(
                  icon: Icon(kBackBtnIcon, color: kPrimaryIconColor),
                  onPressed: _loadPreviousPane,
                )
              : null,

          // Pane title
          title: TkLogoBox(),

          // Close button callback
          closeCallback: !_panes[_paneIndex].close
              ? () {}
              : _panes[_paneIndex].onClose ?? () => Navigator.pop(context),
        ),

        // Scaffold body: pane title and pane body
        body: TkScaffoldBody(child: _panes[_paneIndex]),
      ),
    );
  }
}
