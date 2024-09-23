import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

class RadioText extends StatelessWidget {
  final String text;
  final String selectedText;
  final TextStyle textStyle;
  final Function(String?)? onTap;
  const RadioText({
    super.key,
    required this.text,
    required this.selectedText,
    required this.textStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.centerStart,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: textStyle,
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Transform.scale(
                scale: 1.4,
                child: Radio(
                  value: text,
                  groupValue: selectedText,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: 0),
                  onChanged:onTap ,
                  activeColor: ColorConstant.primary500,
                  fillColor: MaterialStateColor.resolveWith(
                    (states) {
                      if (selectedText == text) {
                        return ColorConstant.primary500;
                      }
                      return ColorConstant.neutral300;
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
