import 'dart:io';

import 'package:thaki/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:thaki/globals/colors.dart';
import 'package:thaki/globals/index.dart';

class TkIDCard extends StatelessWidget {
  TkIDCard({this.title, this.image, this.callback, this.cancelCallback});
  final String title;
  final File image;
  final Function callback;
  final Function cancelCallback;

  void updateImage(ImageSource source, BuildContext context) async {
    // Get the image from the camera or gallery according to source
    ImagePicker imagePicker = new ImagePicker();
    PickedFile image = await imagePicker.getImage(source: source);

    if (image != null) {
      // Allow the user to crop/rotate the picture
      File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: S.of(context).kUploadImage,
            toolbarColor: kPrimaryBgColor,
            toolbarWidgetColor: kWhiteColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );

      // Done, call callback function to update the picture
      if (croppedImage != null) callback(croppedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(title, style: kBoldStyle[kSmallSize])),
        Container(
          height: 164.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: kLightGreyColor,
            border: Border.all(color: kSecondaryColor, width: 1.0),
            image: image == null
                ? null
                : DecorationImage(image: FileImage(image), fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Positioned.fill(child: Container(height: 2000, width: 2000)),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: cancelCallback,
                  child: Icon(kCloseBtnIcon, color: kDarkGreyColor),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(children: [
                    GestureDetector(
                      onTap: () => updateImage(ImageSource.gallery, context),
                      child: Icon(kUploadBtnIcon, size: 60),
                    ),
                    Text(S.of(context).kSelectFromPhoneGallery,
                        style: kBoldStyle[kNormalSize]),
                  ]),
                ),
              ),
              Positioned(
                bottom: -30,
                right: -20,
                child: GestureDetector(
                  onTap: () => updateImage(ImageSource.camera, context),
                  child: Image.asset(kCameraButton),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
