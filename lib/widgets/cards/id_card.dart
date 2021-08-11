import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';

class TkIDCard extends StatefulWidget {
  TkIDCard({this.title, this.image, this.callback, this.cancelCallback});

  final String title;
  final File image;
  final Function callback;
  final Function cancelCallback;

  @override
  _TkIDCardState createState() => _TkIDCardState();
}

class _TkIDCardState extends State<TkIDCard> {
  bool isLoading = false;

  Future<File> testCompressAndGetFile(
      String sourcePath, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      sourcePath,
      targetPath,
      quality: 88,
    );
    return result;
  }

  void updateImage(ImageSource source, BuildContext context) async {
    // Get the image from the camera or gallery according to source
    ImagePicker imagePicker = new ImagePicker();
    PickedFile image = await imagePicker.getImage(source: source);

    if (image != null) {
      setState(() => isLoading = true);

      Directory tempDir = await getTemporaryDirectory();
      File temp = new File('${tempDir.path}/temp.jpeg');
      File compressedImage =
          await testCompressAndGetFile(image.path, temp.path);

      setState(() => isLoading = false);

      // Allow the user to crop/rotate the picture
      File croppedImage = await ImageCropper.cropImage(
        sourcePath: compressedImage.path,
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
            toolbarWidgetColor: kPrimaryColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );

      compressedImage.delete();

      // Done, call callback function to update the picture
      if (croppedImage != null) widget.callback(croppedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(widget.title, style: kBoldStyle[kSmallSize])),
        Container(
          height: 164.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: kLightGreyColor,
            border: Border.all(color: kSecondaryColor, width: 1.0),
            image: widget.image == null
                ? null
                : DecorationImage(
                    image: FileImage(widget.image), fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Positioned.fill(child: Container(height: 2000, width: 2000)),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: widget.cancelCallback,
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
              ),
              if (isLoading)
                GestureDetector(
                    onTap: () {},
                    child: Container(
                        color: kBlackColor.withOpacity(0.5),
                        child: TkProgressIndicator()))
            ],
          ),
        ),
      ],
    );
  }
}
