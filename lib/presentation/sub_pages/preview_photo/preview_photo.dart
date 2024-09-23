import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/sub_pages/preview_photo/preview_photo_appbar.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/resources/l10n/translation_key.dart';
import '../../widgets/buttons/button_stack.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/image/zoomable_image.dart';
import '../../widgets/utils/file.dart';

class PreviewPhotoPage extends StatefulWidget {
  final ImageProvider image;
  const PreviewPhotoPage({super.key, required this.image});

  @override
  State<PreviewPhotoPage> createState() => _PreviewPhotoPageState();

  static Future<FileImage?> showPreviewPhoto(ImageProvider image) async {
    return await Get.to(PreviewPhotoPage(image: image));
  }

  static Future<FileImage?> showPreviewPhotoToNavigator(
      ImageProvider image) async {
    return await Get.to(()=>PreviewPhotoPage(image: image));
  }
}

class _PreviewPhotoPageState extends State<PreviewPhotoPage> {
  ImageProvider? finalImage;
  late GlobalKey globalKey;
  @override
  void initState() {
    super.initState();
    finalImage = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreviewPhotoAppBar(
        appBar: AppBar(),
        onComplete: () {
          sendToParent(context.navigator);
        },
      ),
      body: Container(
        color: ColorConstant.primary50,
        width: double.infinity,
        height: double.infinity,
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: [
              _profile(),
              _buttons(),
              const SizedBox(height: 20.0,)
            ],
          ),
        ),
      ),
    );
  }


  ButtonStack _buttons() {
    return ButtonStack(
      widgets: [
        PrimaryButton(
          title: TranslationKeys.retakePhoto,
          onTap: () {
            _takePhoto(context, ImageSource.camera);
          },
          autoGrow: true,
          borderRadius: 6,
          buttonStyle: PrimaryButtonStyle.bordered,
          textColor: ColorConstant.neutral700,
        ),
        PrimaryButton(
          title: TranslationKeys.chooseFromGallery,
          onTap: () {
            _takePhoto(context, ImageSource.gallery);
          },
          autoGrow: true,
          borderRadius: 6,
          buttonStyle: PrimaryButtonStyle.bordered,
          textColor: ColorConstant.neutral700,
        ),
        PrimaryButton(
          title: TranslationKeys.save,
          onTap: () {
            sendToParent(context.navigator);
          },
          autoGrow: true,
          borderRadius: 6,
        ),
      ],
      alignment: MainAxisAlignment.start,
      direction: Axis.vertical,
    );
  }

  Future<void> sendToParent(NavigatorState navigatorState) async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    RenderRepaintBoundary boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData?.buffer.asUint8List();
    File imgFile = File('$directory/screenshot.png');
    await imgFile.writeAsBytes(pngBytes!);
    FileImage fileImage = FileImage(imgFile);
    navigatorState.pop(fileImage) ;

  }

  Future<void> _takePhoto(BuildContext context, ImageSource source) async {
    FileImage? image = await FileManager().takePhoto(source);
    if (image != null) {
      setState(() {
        finalImage = image;
      });
    }
  }

  Widget _profile() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (finalImage != null)
            ZoomableImage(
              image: finalImage!,
              size: 350,
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstant.shade100,
              ),
              screenshotHandler: (globalKey) {
                this.globalKey = globalKey;
              },
            ),
        ],
      ),
    );
  }
}
