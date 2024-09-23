import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import 'capsule_button.dart';

enum ButtonSelectionType {
  normal,
  neutral,
  destructive;
}

class ButtonSelection {
  final String text;
  final ButtonSelectionType type;
  ButtonSelection({
    required this.text,
    required this.type,
  });
}

class ButtonSelectionView extends StatelessWidget {
  final List<ButtonSelection> selections;
  final Function(String) onSelect;
  final double bottomPadding;
  const ButtonSelectionView({
    super.key,
    required this.selections,
    required this.onSelect,
    required this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: bottomPadding,
          decoration:  BoxDecoration(color: ColorConstant.transparent),
        ),
        Wrap(
          spacing: 12.0,
          children: selections
              .map(
                (selection) => ButtonSelectionItem(
                  selection: selection,
                  onTap: () => onSelect(selection.text),
                ),
              )
              .toList(),
        ),
        Container(
          height: bottomPadding,
          decoration:  BoxDecoration(color: ColorConstant.transparent),
        ),
      ],
    );
  }
}

class ButtonSelectionItem extends StatelessWidget {
  final ButtonSelection selection;
  final VoidCallback onTap;
  const ButtonSelectionItem({
    super.key,
    required this.selection,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    CapsuleButtonType type = CapsuleButtonType.primary;
    switch (selection.type) {
      case ButtonSelectionType.normal:
        type = CapsuleButtonType.primary;
        break;
      case ButtonSelectionType.neutral:
        type = CapsuleButtonType.neutral;
        break;
      case ButtonSelectionType.destructive:
        type = CapsuleButtonType.destructive;
        break;
    }
    return CapsuleButton(
      title: selection.text,
      onTap: onTap,
      autoGrow: false,
      size: CapsuleButtonSize.large,
      type: type,
    );
  }
}
