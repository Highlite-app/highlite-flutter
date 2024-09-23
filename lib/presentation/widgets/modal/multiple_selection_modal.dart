import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';
import '../../../core/resources/typography_theme.dart';
import '../buttons/primary_button.dart';
import '../constants/text_style.dart';
import '../form/check_group.dart';
import '../utils/initial.dart';
import 'alert_modal.dart';

class IDValue {
  final String id;
  final String value;

  const IDValue({required this.id, required this.value});
}

class MultipleSelectionModal extends StatefulWidget {
  final String title;
  final String caption;
  final int maxSelection;
  final String buttonTitle;
  final String iconAsset;
  final List<IDValue> selections;
  final List<IDValue> currentSelections;

  const MultipleSelectionModal({
    super.key,
    required this.title,
    required this.caption,
    this.maxSelection = 3,
    required this.buttonTitle,
    required this.iconAsset,
    required this.selections,
    required this.currentSelections,
  });

  static Future<List<IDValue>?> showModal({
    required BuildContext context,
    required String title,
    required String caption,
    required int maxSelection,
    required String buttonTitle,
    required String iconAsset,
    required List<IDValue> selections,
    required List<IDValue> currentSelections,
  }) async {
    return showDialog<List<IDValue>>(
      context: context,
      barrierDismissible: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return MultipleSelectionModal(
          title: title,
          caption: caption,
          maxSelection: maxSelection,
          buttonTitle: buttonTitle,
          iconAsset: iconAsset,
          selections: selections,
          currentSelections: currentSelections,
        );
      },
    );
  }

  @override
  State<MultipleSelectionModal> createState() => _MultipleSelectionModalState();
}

class _MultipleSelectionModalState extends State<MultipleSelectionModal> {
  List<IDValue> selectedIds = [];

  @override
  void initState() {
    super.initState();
    InitialStater.init().then((value) {
      setState(() {
        selectedIds = widget.currentSelections;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertModal(
      title: widget.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstant.neutral50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: CheckGroup(
                    items: widget.selections.toList(),
                    selectedIds: selectedIds.map((e) => e.id).toList(),
                    onSelect: (selection) {
                      setState(() {
                        if (selectedIds
                            .where((e) => e.id == selection.id)
                            .toList()
                            .isNotEmpty) {
                          final index = selectedIds
                              .indexWhere((e) => e.id == selection.id);
                          selectedIds.removeAt(index);
                        } else {
                          selectedIds.add(selection);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.caption,
            style: BaseTextStyle(
              color: ColorConstant.neutral500,
              fontSize: TypographyTheme.paragraph_p4,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16.0),
          PrimaryButton(
            title: widget.buttonTitle,
            iconAsset: widget.iconAsset,
            iconSize: 16.0,
            onTap: () {
              context.navigator.pop(selectedIds);
            },
            size: PrimaryButtonSize.small,
            horizontalPadding: 0.0,
          ),
        ],
      ),
    );
  }
}
