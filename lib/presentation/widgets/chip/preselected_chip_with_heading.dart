import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';

import '../../../core/resources/l10n/translation_key.dart';

class PreSelectedChipWithHeading extends StatefulWidget {
  final String heading;

  final List<String> chips;
  final Function(String selectedItem) onSubmitSelectedItem;

  final String? preSelectedItem;
  final bool preSelected;

  final bool isButtonEnabled;

  final VoidCallback? onTapNext;

  const PreSelectedChipWithHeading(
      {this.heading = '',
      required this.chips,
      required this.onSubmitSelectedItem,
      this.preSelectedItem,
      this.preSelected = true,
      this.isButtonEnabled = false,
      this.onTapNext,
      super.key});

  @override
  State<PreSelectedChipWithHeading> createState() =>
      _PreSelectedChipWithHeadingState();
}

class _PreSelectedChipWithHeadingState
    extends State<PreSelectedChipWithHeading> {
  String selectedItem = '';

  @override
  void initState() {
    if (widget.preSelected) {
      selectedItem = widget.preSelectedItem ?? widget.chips.first;
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.preSelected) {
      selectedItem = widget.preSelectedItem ?? widget.chips.first;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.heading != '')
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              widget.heading,
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p3,
                fontWeight: FontWeight.w500,
                color: ColorConstant.shade100,
              ),
            ),
          ),
        Wrap(
            spacing: 8.0,
            children: widget.chips
                .map((item) => SelectedChip(
                    title: item,
                    selected: selectedItem == item,
                    onSelected: (bool selected) {
                      setState(() {
                        //  selectedItem = (selected ? item : null) ?? '' ;
                        selectedItem = item;
                        widget.onSubmitSelectedItem(selectedItem);
                      });
                    }))
                .toList()),
        const SizedBox(height: 8.0),
        if (widget.isButtonEnabled)
          AnimatedOpacity(
            opacity: widget.isButtonEnabled ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 700),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedItem != ''
                      ? () {
                          widget.onTapNext?.call();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primary500),
                  child: Text(
                    TranslationKeys.next,
                    style: BaseTextStyle(
                      color: ColorConstant.shade00,
                      fontSize: TypographyTheme.paragraph_p3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class SelectedChip extends StatelessWidget {
  final String title;

  final bool selected;

  final Function(bool) onSelected;

  const SelectedChip(
      {required this.title,
      required this.onSelected,
      required this.selected,
      super.key});

  @override
  Widget build(BuildContext context) {
    return RawChip(
        showCheckmark: false,
        label: Text(title),
        labelStyle: BaseTextStyle(
          color: ColorConstant.shade100,
          fontSize: TypographyTheme.paragraph_p4,
          fontWeight: FontWeight.w500,
        ),
        selected: selected,
        backgroundColor: Colors.white,
        selectedColor: ColorConstant.neutral100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: ColorConstant.neutral500, width: 1),
        ),
        onSelected: onSelected);
  }
}
