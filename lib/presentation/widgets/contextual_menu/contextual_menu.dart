import 'package:flutter/material.dart';

import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../modal/selectable_modal.dart';
import '../svg/darken_svg.dart';

class ContextualMenuOption {
  final String icon;
  final String text;
  final List<ContextualMenuOption>? submenu;
  final bool bordered;
  const ContextualMenuOption({
    required this.icon,
    required this.text,
    this.submenu,
    this.bordered = false,
  });
}

class ContextualMenuWidget extends StatelessWidget {
  final List<ContextualMenuOption> options;
  final Function(String) onTap;
  const ContextualMenuWidget({
    super.key,
    required this.options,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: ColorConstant.shade00,
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle:  BaseTextStyle(
        fontSize: TypographyTheme.paragraph_p3,
        color: ColorConstant.neutral800,
        fontWeight: FontWeight.w500,
      ),
      selectedLabelStyle:  BaseTextStyle(
        fontSize: TypographyTheme.paragraph_p3,
        color: ColorConstant.neutral800,
        fontWeight: FontWeight.w500,
      ),
      selectedItemColor: ColorConstant.neutral800,
      unselectedItemColor: ColorConstant.neutral800,
      onTap: (index) {
        if (options[index].submenu != null) {
          SelectableModal.showModal(
                  context,
                  "Message",
                  options[index]
                      .submenu!
                      .map((menu) =>
                          SelectableOption(title: menu.text, icon: menu.icon))
                      .toList())
              .then((value) {
            if (value != null) {
              onTap(value);
            }
            onTap("");
          });
        } else {
          onTap(options[index].text);
        }
      },
      items: options
          .map(
            (option) => BottomNavigationBarItem(
              icon: PaddedDarkenSvg(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                asset: option.icon,
                assetPadding: option.bordered ? 8 : 4,
                size: option.bordered ? 20 : 28,
                bordered: option.bordered,
              ),
              label: option.text,
            ),
          )
          .toList(),
    );
  }
}
