import 'package:flutter/material.dart';

import '../../../core/resources/color_constants.dart';
import '../layout/wrap_stack.dart';
import '../modal/multiple_selection_modal.dart';
import 'dropdown.dart';
import 'form_element.dart';

class DropdownControl extends StatefulWidget {
  final String title;
  final IDValue selected;
  final List<IDValue> items;
  final Function(IDValue) onChangeSelection;

  const DropdownControl({
    super.key,
    required this.title,
    required this.selected,
    required this.items,
    required this.onChangeSelection,
  });

  @override
  State<DropdownControl> createState() => _DropdownControlState();
}

class _DropdownControlState extends State<DropdownControl> {
  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormElement(
        title: widget.title,
        hasErrors: false,
        titleColor: ColorConstant.neutral800,
        titleWeight: FontWeight.w600,
        titlePadding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
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
                      text: text.value,
                      selected: widget.selected.id == text.id,
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
        ),
      ),
    );
  }
}
