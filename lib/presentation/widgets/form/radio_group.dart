import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';

import '../../../core/resources/typography_theme.dart';
import '../buttons/rippler.dart';
import '../constants/text_style.dart';
import '../utils/initial.dart';

class RadioGroup extends StatefulWidget {
  final List<String> items;
  final Function(String) onSelect;
  final String initialValue;

  const RadioGroup({
    super.key,
    required this.items,
    required this.onSelect,
    this.initialValue = "",
  });

  @override
  State<RadioGroup> createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  String selected = "";
  @override
  void initState() {
    super.initState();
    InitialStater.init().then((value) {
      setState(() {
        selected = widget.initialValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.items
          .mapIndexed(
            (e, index) => Column(
              children: [
                RadioItem(
                  title: e,
                  selected: selected,
                  onSelect: (value) {
                    setState(() {
                      if (value != null) {
                        selected = value;
                        widget.onSelect(selected);
                      }
                    });
                  },
                ),
                const Divider(
                  color: ColorConstant.neutral100,
                  height: 0.5,
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class RadioItem extends StatelessWidget {
  final String title;
  final String selected;
  final Function(String?) onSelect;
  const RadioItem({
    super.key,
    required this.title,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Rippler(
      onTap: () => onSelect(title),
      child: Row(
        children: [
          Text(
            title,
            style:  BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p3,
              color: ColorConstant.neutral900,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Transform.scale(
            scale: 1.4,
            child: Radio(
              value: title,
              groupValue: selected,
              onChanged: onSelect,
              activeColor: ColorConstant.primary500,
              fillColor: MaterialStateColor.resolveWith(
                (states) {
                  if (selected == title) {
                    return ColorConstant.primary500;
                  }
                  return ColorConstant.neutral300;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
