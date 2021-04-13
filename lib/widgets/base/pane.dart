import 'package:flutter/material.dart';

/// A class that holds the bottom navigation icon data
/// It holds an icon
@immutable
class TkNavIconData {
  TkNavIconData({
    this.icon,
    this.disabled = false,
  });

  final ImageProvider icon;
  final bool disabled;
}

/// Abstract class that defines a pane with a title and an onDone callback
/// the callback should be called when the pane is about to pop with the
/// appropriate variable passed (should be the identifier of what was clicked
/// last to pop the pane)
abstract class TkPane extends StatelessWidget {
  TkPane({
    this.paneTitle,
    this.image,
    this.navIconData,
    this.floatingButton,
    this.onDone,
    this.onSelect,
    this.onClose,
    this.allowNavigation = true,
    this.allowClose = true,
    this.enabled = true,
  });

  // Pane title
  final String paneTitle;

  // Allow navigation
  final bool allowNavigation;

  // Allow close
  final bool allowClose;

  // On done callback
  final Function onDone;

  // On select callback
  final Function onSelect;

  // On close callback
  final Function onClose;

  // Navigation button icon
  final TkNavIconData navIconData;

  // Floating button widget
  final Widget floatingButton;

  // Is this pane ready to be loaded
  final bool enabled;

  // Pane top image
  final String image;

  // Getters
  String get title => paneTitle;
  bool get close => allowClose;
}
