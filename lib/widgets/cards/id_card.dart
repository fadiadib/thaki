import 'package:flutter/material.dart';
import 'package:thaki/globals/colors.dart';
import 'package:thaki/globals/index.dart';

class TkIDCard extends StatelessWidget {
  TkIDCard({this.title, this.image});
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 164.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: kLightGreyColor,
            border: Border.all(color: kSecondaryColor, width: 1.0),
            image: image == null
                ? null
                : DecorationImage(image: NetworkImage(image)),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(height: 2000, width: 2000),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(children: [
                    Icon(kUploadBtnIcon, size: 60),
                    Text(kSelectFromPhoneGallery,
                        style: kRegularStyle[kNormalSize]),
                  ]),
                ),
              ),
              Positioned(
                  bottom: -30, right: -20, child: Image.asset(kCameraButton))
            ],
          ),
        ),
        if (title != null)
          Padding(padding: const EdgeInsets.only(top: 10.0), child: Text(title))
      ],
    );
  }
}
