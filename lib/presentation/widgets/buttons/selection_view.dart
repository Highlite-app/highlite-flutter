import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/buttons/selection_button.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/buttons/selection_search.dart';

class Selection {
  final String text;
  String? icon;
  bool isFlagIcon;
  Selection({required this.text, this.icon, this.isFlagIcon = false});
}

// ignore: must_be_immutable
class SelectionView extends StatefulWidget {
  SelectionView({
    super.key,
    required this.bottomPadding,
    required this.selections,
    required this.onSelect,
    this.capitalize = false,
    this.searchable = false,
    this.forceVertical = false,
  }) {
    savedSelections = selections;
    displayedSelections = selections;
  }

  final List<Selection> selections;
  late final List<Selection> savedSelections;
  List<Selection> displayedSelections = [];
  final Function onSelect;
  final double bottomPadding;
  final bool capitalize;
  final bool searchable;
  final bool forceVertical;

  @override
  State<SelectionView> createState() => _SelectionViewState();
}

class _SelectionViewState extends State<SelectionView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.searchable == true)
          SelectionSearch(
            onChange: (query) {
              setState(() {
                if (query == "") {
                  widget.displayedSelections = widget.savedSelections;
                } else {
                  widget.displayedSelections = widget.savedSelections
                      .where((element) => element.text
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                }
              });
            },
          ),
        if (widget.displayedSelections.length <= 2 && !widget.searchable)
          if (!widget.forceVertical)
            Row(
              children: widget.displayedSelections
                  .map(
                    (selection) => Expanded(
                      child: SelectionButton(
                        text: selection.text,
                        onTap: () => widget.onSelect(selection.text),
                        capitalize: widget.capitalize,
                        rowView: widget.selections.length >= 3,
                        icon: selection.icon,
                        isFlagIcon: selection.isFlagIcon,
                      ),
                    ),
                  )
                  .toList(),
            )
          else
            Column(
              children: [
                ...widget.displayedSelections.map(
                  (selection) => SelectionButton(
                    text: selection.text,
                    onTap: () => widget.onSelect(selection.text),
                    capitalize: widget.capitalize,
                    rowView: widget.selections.length >= 3,
                    icon: selection.icon,
                    isFlagIcon: selection.isFlagIcon,
                  ),
                ),
              ],
            ),
        if (widget.displayedSelections.length >= 3 && !widget.searchable)
          Column(
            children: [
              ...widget.displayedSelections.map(
                (selection) => SelectionButton(
                  text: selection.text,
                  onTap: () => widget.onSelect(selection.text),
                  capitalize: widget.capitalize,
                  rowView:
                      widget.capitalize ? true : widget.selections.length >= 3,
                  icon: selection.icon,
                  isFlagIcon: selection.isFlagIcon,
                ),
              ),
            ],
          ),
        if (widget.searchable)
          Container(
            width: double.infinity,
            height: 200,
            decoration:  BoxDecoration(
              color: ColorConstant.neutral50,
            ),
            constraints: const BoxConstraints(minHeight: 200, maxHeight: 200),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...widget.displayedSelections.map(
                    (selection) => SelectionButton(
                      text: selection.text,
                      onTap: () => widget.onSelect(selection.text),
                      capitalize: widget.capitalize,
                      rowView: widget.selections.length >= 3,
                      icon: selection.icon,
                      isFlagIcon: selection.isFlagIcon,
                    ),
                  ),
                ],
              ),
            ),
          ),
        Container(
          height: widget.bottomPadding,
          decoration:  BoxDecoration(color: ColorConstant.neutral50),
        ),
      ],
    );
  }
}
