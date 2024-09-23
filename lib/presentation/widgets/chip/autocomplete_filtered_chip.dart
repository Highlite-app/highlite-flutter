import 'package:flutter/material.dart';

import '../../../core/resources/asset_constants.dart';
import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../sectionable/heading.dart';
import '../svg/svg_asset.dart';
import 'filtered_chip.dart';

class AutocompleteFilteredChip extends StatefulWidget {
  final String heading;

  final TextEditingController controller;

  final Function(dynamic) onSelected;

  final String hintSearch;

  final List<String> mainList;

  const AutocompleteFilteredChip(
      {required this.heading,
      required this.controller,
      required this.onSelected,
      required this.hintSearch,
      required this.mainList,
      super.key});

  @override
  State<AutocompleteFilteredChip> createState() =>
      _AutocompleteFilteredChipState();
}

class _AutocompleteFilteredChipState extends State<AutocompleteFilteredChip> {
  bool isOpen = false;

  static const currentSearchIndex = 9;

  static const initialSearchIndex = 3;

  final _mainListMap = <String, dynamic>{};

  var _mainList = <String>[];

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    initializesListFromMap();
    super.initState();
  }

  void initializesListFromMap() {
    controller = widget.controller;
    _mainList = List.from(widget.mainList);
    for (var item in widget.mainList) {
      _mainListMap[item] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool matchesQuery(String text, String query) {
      if (query.isEmpty) return true; // If the query is empty, consider it a match.
      if (text.length < query.length) return false; // If the text is shorter than the query, it's not a match.

      for (int i = 0; i < query.length; i++) {
        if (text[i].toLowerCase() != query[i].toLowerCase()) {
          return false;
        }
      }
      return true;
    }

    final filteredList = _mainList
        .where((skill) => matchesQuery(skill, controller.text))
        .toList()
      ..sort((a, b) => a.compareTo(b));

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Heading(title: widget.heading , textStyle:BaseTextStyle(
          fontSize: TypographyTheme.paragraph_p3,
          fontWeight: FontWeight.w500,
          color: ColorConstant.neutral800,
        )),
        TextField(
          style: BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p3,
              fontWeight: FontWeight.w500,
              color: ColorConstant.neutral900),
          controller: widget.controller,
          onChanged: (value) {
            setState(() {
              isOpen = value.isNotEmpty;
            });
          },
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.neutral400),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.neutral400),
            ),
            prefixIconConstraints: const BoxConstraints(
                maxWidth: 25, minHeight: 25, maxHeight: 25, minWidth: 25),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgAsset(
                asset: AssetConstant.searchIcon,
                color: ColorConstant.neutral600,
              ),
            ),
            hintText: widget.hintSearch,
            hintStyle: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p3,
                fontWeight: FontWeight.w500,
                color: ColorConstant.neutral500),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.neutral400),
            ),
          ),
        ),
        if (isOpen)
          Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: filteredList.take(currentSearchIndex).map(
                (filteredItem) {
                  return CustomFilterChip(
                    label: filteredItem,
                    isSelected: _mainListMap[filteredItem],
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          widget.controller.text = filteredItem;
                          _mainListMap[filteredItem] = selected;
                          widget.onSelected(filteredItem) ;

                        }
                      });
                    },
                  );
                },
              ).toList()),
        if (!isOpen)
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: filteredList.take(initialSearchIndex).map(
              (filteredItem) {
                return CustomFilterChip(
                  label: filteredItem,
                  isSelected: _mainListMap[filteredItem],
                  onSelected: (selected) {
                    if (selected) {
                      widget.controller.text = filteredItem;
                      _mainListMap[filteredItem] = selected;
                      widget.onSelected(filteredItem) ;
                    }
                  },
                );
              },
            ).toList(),
          )
      ],
    );
  }
}
