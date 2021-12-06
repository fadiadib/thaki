import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';

/// Widget that creates a ListTile menu item, takes a
/// title for the menu item and an action to perform
/// when the menu item is clicked. This widget takes
/// care of popping the menu.
class TkListMenuItem extends StatelessWidget {
  TkListMenuItem(
      {this.title, this.action, this.child, this.textStyle, this.pop = true});

  final String? title;
  final TextStyle? textStyle;
  final Widget? child;
  final Function? action;
  final bool pop;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
          // Menu item title
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Menu title
              SizedBox(
                width: 200,
                child: Text(
                  title!,
                  style: textStyle ?? kRegularStyle[kSmallSize],
                ),
              ),

              // And additional widget
              if (child != null) child!,
            ],
          ),

          // On tap action, pop menu and call action callback
          onTap: () {
            if (pop) Navigator.pop(context);
            action!();
          },
        ),

        // Add a small divider
        Divider(thickness: 0.5, height: 1)
      ],
    );
  }
}
