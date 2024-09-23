import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../core/resources/typography_theme.dart';
import '../../widgets/constants/text_style.dart';
import '../../widgets/svg/svg_asset.dart';

class PreviewPhotoAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final AppBar appBar;
  final VoidCallback onComplete;
  const PreviewPhotoAppBar(
      {super.key, required this.appBar, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        TranslationKeys.previewProfilePhoto,
        style:  BaseTextStyle(
          fontSize: TypographyTheme.paragraph_p3,
          color: ColorConstant.neutral800,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: IconButton(
        icon: const SvgAsset(
          asset: AssetConstant.xIcon,
          color: ColorConstant.neutral800,
          size: 28,
        ),
        onPressed: () {
         context.navigator.pop();
        },
      ),
      backgroundColor: ColorConstant.primary50,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: const SvgAsset(
            asset: AssetConstant.checkIcon,
            color: ColorConstant.neutral800,
            size: 28,
          ),
          onPressed: onComplete,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
