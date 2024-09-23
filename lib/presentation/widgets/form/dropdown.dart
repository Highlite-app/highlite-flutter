import 'package:flutter/material.dart';

import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../buttons/rippler.dart';
import '../constants/text_style.dart';
import '../layout/wrap_stack.dart';
import '../svg/svg_asset.dart';
import 'form_element.dart';

class DropdownForm extends StatefulWidget {
  final String? title;
  final String? captionText;
  final String selected;
  final List<String> items;
  final Function(String) onChangeSelection;

  const DropdownForm({
    super.key,
    this.title,
    this.captionText,
    required this.selected,
    required this.items,
    required this.onChangeSelection,
  });

  @override
  State<DropdownForm> createState() => _DropdownFormState();
}

class _DropdownFormState extends State<DropdownForm> {
  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    return FormElement(
      title: widget.title,
      captionText: widget.captionText,
      hasErrors: false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        clipBehavior: Clip.hardEdge,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorConstant.neutral100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: WrappedStack(
          direction: Axis.vertical,
          spacing: 1,
          widgets: widget.items
              .where((element) {
                if (editMode) {
                  return true;
                } else {
                  return element == widget.selected;
                }
              })
              .map(
                (text) => DropdownOption(
                  text: text,
                  selected: widget.selected == text,
                  editMode: editMode,
                  isSelectable: widget.items.length >= 2,
                  onTap: () {
                    if (editMode) {
                      setState(() {
                        widget.onChangeSelection(text);
                        editMode = false;
                      });
                    } else {
                      setState(() {
                        editMode = true;
                      });
                    }
                  },
                ),
              )
              .toList(),
          alignment: MainAxisAlignment.start,
        ),
      ),
    );
  }
}

class DropdownOption extends StatelessWidget {
  final bool selected;
  final String text;
  final bool editMode;
  final VoidCallback onTap;
  final bool isSelectable;

  const DropdownOption(
      {super.key,
      required this.text,
      required this.selected,
      required this.onTap,
      required this.editMode,
      required this.isSelectable});

  @override
  Widget build(BuildContext context) {
    final option = Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  text,
                  style: BaseTextStyle(
                    fontSize: TypographyTheme.paragraph_p3,
                    color: ColorConstant.neutral900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isSelectable)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (selected)
                          SvgAsset(
                            asset: editMode ? "chevron-right" : "chevron-down",
                            color: ColorConstant.neutral800,
                            width: 24,
                            height: 24,
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
    if (isSelectable) {
      return Rippler(
        backgroundColor:
            selected ? ColorConstant.neutral100 : ColorConstant.neutral50,
        onTap: onTap,
        child: option,
      );
    } else {
      return option;
    }
  }
}
