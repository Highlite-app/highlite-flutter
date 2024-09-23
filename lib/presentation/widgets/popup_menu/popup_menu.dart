import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';

class ActionItem {
  final String value;
  final String label;
  final String? icon;
  const ActionItem({
    required this.value,
    required this.label,
    required this.icon,
  });
}

class ActionMenu extends StatelessWidget {
  final List<ActionItem> actions;
  final Function(String) onTap;
  final String? icon;
  const ActionMenu({
    super.key,
    required this.actions,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: SvgAsset(
        asset: icon ?? AssetConstant.dottedVerticalIcon,
        size: 24,
        color: ColorConstant.neutral800,
      ),
      padding: const EdgeInsets.all(0),
      itemBuilder: (context) => actions
          .map(
            (action) => PopupMenuItem<String>(
              onTap: () {
                onTap(action.value);
              },
              value: action.value,
              child: ActionMenuItem(item: action),
            ),
          )
          .toList(),
      offset: const Offset(0, 50),
      elevation: 1,
    );
  }
}

class ActionMenuItem extends StatelessWidget {
  final ActionItem item;
  const ActionMenuItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (item.icon != null)
          SvgAsset(
            asset: item.icon!,
            size: 24,
            color: ColorConstant.primary500,
          ),
        if (item.icon != null)
          const SizedBox(
            width: 8.0,
          ),
        Text(
          item.label,
          style:  BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p3,
            color: ColorConstant.primary500,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
