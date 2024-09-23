import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';

enum DropdownStyle {
  underlined,
  outlined,
}

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String hint;
  final ValueChanged<String?>? onSelected;
  final DropdownStyle style;

  const CustomDropdown({
    Key? key,
    required this.items,
    this.hint = 'Select an item',
    this.onSelected,
    this.style = DropdownStyle.underlined,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool isOpen = false;
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric( vertical: 16),
            decoration: widget.style == DropdownStyle.underlined
                ? BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            )
                : BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedValue ?? widget.hint,
                  style: TextStyle(color: Colors.black),
                ),
                Icon(isOpen ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
        ),
        if (isOpen)
          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                children: widget.items.map((item) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedValue = item;
                        isOpen = false;
                      });
                      if (widget.onSelected != null) {
                        widget.onSelected!(item);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        color: selectedValue == item ? ColorConstant.neutral100: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: ColorConstant.neutral200),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: TypographyTheme.paragraph_p4,
                            color: selectedValue == item ? ColorConstant.neutral900 : ColorConstant.neutral800,
                            fontWeight: selectedValue == item ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }
}
