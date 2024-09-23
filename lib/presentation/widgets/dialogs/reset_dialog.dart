import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/dialogs/dialog_helper.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';

class ResetDialog {


  static Future<void> showResetDialog({required BuildContext context , required VoidCallback onLoadChat }) async {
    return DialogHelper.showAdaptiveAlertDialog(
      context,
      TranslationKeys.startOverTitle,
      TranslationKeys.startOverMessage,
      [
        TextButton(
          child: Text(
            TranslationKeys.cancel,
            style:  BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p2,
              color: ColorConstant.primary500,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(
            TranslationKeys.startOver,
            style:  BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p2,
              color: ColorConstant.primary500,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            onLoadChat();
            context.navigator.pop();
          },
        ),
      ],
    );
  }
}