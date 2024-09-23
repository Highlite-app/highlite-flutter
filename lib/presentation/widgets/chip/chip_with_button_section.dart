import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';

import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../chat/chat_responder.dart';
import '../constants/text_style.dart';

enum ChipWithButtonType { normal, formField }

class ChipWithButtonSection extends StatefulWidget {
  final String title;

  final TextEditingController? aboutText;

  final List<String> items;

  final Function onSubmit;

  final bool buttonEnabled;

  final VoidCallback? onTapNext;

  final ChipWithButtonType chipWithButtonType;

  final MinMax<int> maxItemSelection;

  const ChipWithButtonSection(
      {required this.title,
       this.aboutText ,
      required this.items,
      required this.onSubmit,
        this.onTapNext,
      required this.buttonEnabled,
      this.chipWithButtonType = ChipWithButtonType.normal,
      required this.maxItemSelection,
      super.key}): assert(chipWithButtonType != ChipWithButtonType.formField || aboutText !=null,
       'aboutText must be provided when chipWithButtonType is formField' ,
  ) ;

  @override
  State<ChipWithButtonSection> createState() => _ChipWithButtonSectionState();
}

class _ChipWithButtonSectionState extends State<ChipWithButtonSection> {
  var selectedLanguage = <String>[];
  var showAllLanguages = false;
  var onTapShowMore = false;

  List<String> getDisplayLanguage() {
    if (widget.items.length <= 5) {
      return widget.items;
    } else {
      return widget.items.take(5).toList();
    }
  }

  List<String> displayLanguages() {
    if (onTapShowMore ) {
      return widget.items;
    } else {
      return getDisplayLanguage();
    }
  }

  bool get isFormField => widget.chipWithButtonType == ChipWithButtonType.formField  ;

  bool get isButtonEnabled
  {

    return (selectedLanguage.isNotEmpty) && (isFormField ? widget.aboutText?.text!="" && widget.aboutText !=null: true) && (widget.buttonEnabled) ;
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${widget.title}*",
          style: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p4,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16.0),
        ChipGroup(
          displayItems: displayLanguages(),
          totalItems: widget.items,
          height: onTapShowMore
              ? screen.height * .45
              : selectedLanguage.length == 3
                  ? (getDisplayLanguage().length / 2) * 60
                  : (getDisplayLanguage().length / 2.5) * 60,
          onSelectedItem: (selectedLanguage) {
            setState(() {
              this.selectedLanguage = selectedLanguage;
            });
            widget.onSubmit(selectedLanguage);
          },
          maxSelectableItem: widget.maxItemSelection.max,
          showMore: widget.items.length > 5 && onTapShowMore != true,
          onTapShowMore: () {
            setState(() {
              onTapShowMore = true;
            });
          },
        ),
        const SizedBox(height: 8.0),
          if(isButtonEnabled )
            AnimatedOpacity(
              opacity:isButtonEnabled
                  ? 1.0
                  : 0.0,
              duration: const Duration(milliseconds: 700),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeInOut,
                child: SizedBox(
                  width: double.infinity,
                  child:
                  ElevatedButton(
                    onPressed:
                        selectedLanguage.length >= widget.maxItemSelection.min
                            ? () {

                                widget.onTapNext?.call() ;
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

class ChipGroup extends StatefulWidget {
  final List<String> displayItems;

  final List<String> totalItems;

  final double height;

  final double maxWidth;

  final int maxSelectableItem;

  final Function onSelectedItem;

  final VoidCallback onTapShowMore;

  final bool selectable;

  final bool showMore;

  const ChipGroup(
      {required this.displayItems,
      required this.totalItems,
      required this.height,
      this.maxWidth = double.infinity,
      this.selectable = true,
      required this.onSelectedItem,
      required this.maxSelectableItem,
      required this.onTapShowMore,
      this.showMore = false,
      super.key});

  @override
  State<ChipGroup> createState() => _ChipGroupState();
}

class _ChipGroupState extends State<ChipGroup> {
  var selectedLanguages = <String>[];
  var showAllLanguages = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.maxWidth,
        minHeight: widget.height,
        maxHeight: widget.height,
      ),
      child: SingleChildScrollView(
        child: Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            spacing: 10.0,
            runSpacing: 8.0,
            children: [
              ...widget.displayItems
                  .map((language) => ActionChipTag(
                      title: language,
                      isSelected: selectedLanguages.contains(language),
                      onTap:
                          selectedLanguages.length < widget.maxSelectableItem ||
                                  selectedLanguages.contains(language)
                              ? () {
                                  if (widget.selectable) {
                                    if (selectedLanguages.contains(language)) {
                                      selectedLanguages.remove(language);
                                    } else {
                                      selectedLanguages.add(language);
                                    }
                                  }
                                  widget.onSelectedItem(selectedLanguages);
                                }
                              : null))
                  .toList(),
              if (widget.showMore)
                InkWell(
                  onTap: widget.onTapShowMore,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      "+ ${widget.totalItems.length - 5} more",
                      style: BaseTextStyle(
                          fontSize: TypographyTheme.paragraph_p3,
                          fontWeight: FontWeight.w500,
                          color: ColorConstant.primary500),
                    ),
                  ),
                ),
              if (selectedLanguages.length == 3)
                Text(
                  "You can’t add more than 3 language",
                  style: BaseTextStyle(
                      fontSize: TypographyTheme.paragraph_p3,
                      color: ColorConstant.destructive400,
                      fontWeight: FontWeight.w500),
                )
            ]),
      ),
    );
  }
}

class ActionChipTag extends StatelessWidget {
  final String title;

  final VoidCallback? onTap;

  final bool voidTap;

  final bool isSelected;

  const ActionChipTag(
      {required this.title,
      this.onTap,
      required this.isSelected,
      this.voidTap = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      padding: EdgeInsets.zero,
      label: Text(title),
      onPressed: onTap ?? () {},
      disabledColor: ColorConstant.neutral50,
      backgroundColor: onTap == null
          ? ColorConstant.transparent
          : (isSelected ? ColorConstant.neutral100 : ColorConstant.shade00),
      labelStyle: BaseTextStyle(
        fontSize: TypographyTheme.paragraph_p4,
        color: ColorConstant.neutral700,
        fontWeight: FontWeight.w500,
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: ColorConstant.neutral500, width: 1),
      ),
    );
  }
}
