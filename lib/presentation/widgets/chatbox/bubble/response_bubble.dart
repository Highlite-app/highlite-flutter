import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../../core/resources/typography_theme.dart';
import '../../constants/text_style.dart';
import '../../svg/svg_asset.dart';

enum ResponseContentStyle {
  primary,
  warning,
  error;
}

class ResponseContent {
  final String content;
  final String icon;
  final ResponseContentStyle style;
  final String? bottomLine;
  final bool isLastMessage;
  const ResponseContent({
    required this.content,
    required this.icon,
    required this.style,
    this.bottomLine,
    this.isLastMessage = false,
  });
}

class ResponseBubble extends StatelessWidget {
  final ResponseContent responseContent;
  const ResponseBubble({
    super.key,
    required this.responseContent,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = ColorConstant.warning600;
    Color iconColor = ColorConstant.warning500;
    Color dividerColor = ColorConstant.warning100;
    Color buttonColor = ColorConstant.warning50;
    Color buttonTextColor = ColorConstant.warning600;
    switch (responseContent.style) {
      case ResponseContentStyle.primary:
        textColor = ColorConstant.primary500;
        iconColor = ColorConstant.primary500;
        dividerColor = ColorConstant.primary100;
        buttonColor = ColorConstant.primary50;
        buttonTextColor = ColorConstant.primary600;
        break;
      case ResponseContentStyle.warning:
        textColor = ColorConstant.warning600;
        iconColor = ColorConstant.warning500;
        dividerColor = ColorConstant.warning100;
        buttonColor = ColorConstant.warning50;
        buttonTextColor = ColorConstant.warning600;
        break;
      case ResponseContentStyle.error:
        textColor = ColorConstant.destructive600;
        iconColor = ColorConstant.destructive500;
        dividerColor = ColorConstant.destructive100;
        buttonColor = ColorConstant.destructive50;
        buttonTextColor = ColorConstant.destructive600;
        break;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Text(
            responseContent.content,
            textAlign: TextAlign.center,
            style: BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p3,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  color: dividerColor,
                  height: 2.0,
                  width: 100,
                  alignment: Alignment.center,
                ),
              ),
              const SizedBox(width: 8),
              SvgAsset(
                asset: responseContent.icon,
                height: 20,
                width: 15,
                color: iconColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  color: dividerColor,
                  height: 2.0,
                  width: 100,
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
          if (responseContent.bottomLine != null)
            Column(
              children: [
                const SizedBox(height: 24.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    responseContent.bottomLine!,
                    style: BaseTextStyle(
                      fontSize: TypographyTheme.paragraph_p3,
                      color: buttonTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          if (responseContent.isLastMessage) const SizedBox(height: 200),
          if (!responseContent.isLastMessage) const SizedBox(height: 30),
        ],
      ),
    );
  }
}
