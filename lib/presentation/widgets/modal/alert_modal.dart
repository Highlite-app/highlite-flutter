import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';
import 'package:sizer/sizer.dart';
import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../buttons/tiny_button.dart';
import '../constants/text_style.dart';

class AlertModal extends StatelessWidget {
  final String title;
  final Widget child;
  const AlertModal({
    super.key,
    required this.title,
    required this.child,
  });

  static Future<void> showModal(
    BuildContext context,
    String title,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return AlertModal(
          title: title,
          child: Container(color: ColorConstant.shade00),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            color: ColorConstant.transparent,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorConstant.shade00,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style:  BaseTextStyle(
                            color: ColorConstant.primary900,
                            fontSize: TypographyTheme.paragraph_p1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TinyButton(
                        color: ColorConstant.neutral100,
                        splashColor: ColorConstant.neutral50,
                        onTap: () {
                          context.navigator.pop();
                        },
                        icon: "x-01",
                        iconColor: ColorConstant.neutral800,
                        size: 24,
                      )
                    ],
                  ),
                  child,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
