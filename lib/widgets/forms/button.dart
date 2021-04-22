import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';

class TkButton extends StatelessWidget {
  // Button theme
  TkButton({
    @required this.onPressed,
    @required this.title,
    this.btnIcon,
    this.preBtnIcon,
    this.btnColor = kDefaultButtonBgColor,
    this.btnBorderColor = kDefaultButtonBgColor,
    this.titleColor = kDefaultButtonTextColor,
    this.disabledTitleColor = kDefaultButtonDisabledTextColor,
    this.enableShadow = false,
    this.btnHeight = kDefaultButtonHeight,
    this.btnWidth,
    this.uppercaseTitle = false,
    this.titleSize,
    this.gapSize = kDefaultButtonGapSize,
    this.isLoading = false,
    this.enabled = true,
    this.iconRotation = 0.0,
  });

  final bool enabled;
  final bool enableShadow;
  final Color btnColor;
  final Color btnBorderColor;
  final Color titleColor;
  final Color disabledTitleColor;
  final String title;
  final Function onPressed;
  final double btnHeight;
  final double btnWidth;
  final IconData btnIcon;
  final IconData preBtnIcon;
  final bool uppercaseTitle;
  final double titleSize;
  final double gapSize;
  final bool isLoading;
  final double iconRotation;

  Widget getTitle() {
    // Add a text widget inside the button
    return Text(
      uppercaseTitle ? title.toUpperCase() : title,
      style: kBoldStyle[kNormalSize].copyWith(
        color: isLoading || !enabled ? disabledTitleColor : titleColor,
        fontSize: titleSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: btnWidth,
        height: btnHeight,

        // Button border decoration (radius, gradient and shadow)
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultButtonRadius),
          color: btnColor,
          boxShadow: enableShadow ? kFormShadow : [],
          border: Border.all(color: btnBorderColor, width: 1.0),
        ),

        // The internal parts: title and action
        child: MaterialButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Show the gap and icon only if the button has an icon
              preBtnIcon != null
                  ? Row(
                      children: <Widget>[
                        Transform.rotate(
                          angle: iconRotation,
                          child: Icon(
                            preBtnIcon,
                            color: !enabled ? disabledTitleColor : titleColor,
                            size: titleSize,
                          ),
                        ),
                        SizedBox(width: gapSize)
                      ],
                    )
                  : Container(),

              // Add a text widget inside the button
              getTitle(),

              // Show the gap and icon only if the button has an icon
              btnIcon != null || isLoading
                  ? SizedBox(width: gapSize)
                  : Container(),
              isLoading
                  ? SizedBox(
                      height: 20.0,
                      width: 20.0,
                      child: TkProgressIndicator(
                          strokeWidth: 3.0, color: kWhiteColor),
                    )
                  : btnIcon != null
                      ? Transform.rotate(
                          angle: iconRotation,
                          child: Icon(
                            btnIcon,
                            color: !enabled ? disabledTitleColor : titleColor,
                            size: titleSize,
                          ),
                        )
                      : Container(),
            ],
          ),

          // On pressed button action
          onPressed: isLoading || !enabled ? null : onPressed,
        ),
      ),
    );
  }
}
