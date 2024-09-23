import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/spacing_theme.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';

class ChatHeadline extends StatelessWidget {
  const ChatHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        decoration:  BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 2, color: ColorConstant.neutral200))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(child: avatar()),
            user(),
            footer(),
          ],
        ),
      ),
    );
  }

  Padding footer() {
    return  Padding(
      padding: const EdgeInsets.only(
          top: Spacing.spacing_xx_sm, bottom: Spacing.spacing_xxx_big),
      child: Column(
        children: [
          Text(
            "Personal Assistant",
            style: BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p2,
              color: ColorConstant.neutral700,
            ),
          )
        ],
      ),
    );
  }

  Container avatar() {
    return Container(
      width: 128,
      height: 128,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetConstant.avatarIcon),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Padding user() {
    return Padding(
      padding: const EdgeInsets.only(top: Spacing.spacing_x_sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 10,
            ),
            width: 10,
            height: 10,
            decoration:  BoxDecoration(
                shape: BoxShape.circle, color: ColorConstant.success500),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child:  Text(
              "EJ",
              style: BaseTextStyle(
                  fontSize: TypographyTheme.heading_H5,
                  color: ColorConstant.neutral900,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
