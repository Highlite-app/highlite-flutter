import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/buttons/tiny_button.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';

class IconizedButton extends StatelessWidget {
  final String? icon;
  final VoidCallback onTapIcon;

  final String text;

  const IconizedButton(
      {required this.onTapIcon, this.icon, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ColorConstant.neutral50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: BaseTextStyle(
                color: ColorConstant.neutral900,
                fontSize: TypographyTheme.paragraph_p2,
                fontWeight: FontWeight.w600),
          ),
          TinyButton(
              color: ColorConstant.primary500,
              splashColor: ColorConstant.primary500,
              onTap: () {},
              icon: AssetConstant.plusIcon,
              iconPadding: 8,
              iconColor: ColorConstant.neutral50,
              size: 18)
        ],
      ),
    );
  }
}
