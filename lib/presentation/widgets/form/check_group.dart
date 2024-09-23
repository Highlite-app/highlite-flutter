import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';

import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../buttons/rippler.dart';
import '../constants/text_style.dart';
import '../modal/multiple_selection_modal.dart';

class CheckGroup extends StatefulWidget {
  final List<IDValue> items;
  final List<String> selectedIds;
  final Function(IDValue) onSelect;
  final String initialValue;

  const CheckGroup({
    super.key,
    required this.items,
    required this.selectedIds,
    required this.onSelect,
    this.initialValue = "",
  });

  @override
  State<CheckGroup> createState() => _CheckGroupState();
}

class _CheckGroupState extends State<CheckGroup> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 18.0,
      runSpacing: 18.0,
      children: widget.items
          .mapIndexed(
            (e, index) => Column(
              children: [
                CheckItem(
                  idValue: e,
                  selected: widget.selectedIds
                      .where((id) => id == e.id)
                      .toList()
                      .isNotEmpty,
                  onSelect: (value) {
                    widget.onSelect(widget.items
                        .where((idValue) => idValue.id == value)
                        .first);
                  },
                  enableDivider: (index != widget.items.length - 1),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class CheckItem extends StatelessWidget {
  final IDValue idValue;
  final bool selected;
  final bool enableDivider;
  final Function(String?) onSelect;

  const CheckItem({
    super.key,
    required this.idValue,
    required this.selected,
    required this.onSelect,
    this.enableDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Rippler(
      onTap: () => onSelect(idValue.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Text(
                  idValue.value,
                  style: BaseTextStyle(
                    fontSize: TypographyTheme.paragraph_p2,
                    color: ColorConstant.neutral900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 1.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: selected
                          ? ColorConstant.primary500
                          : ColorConstant.shade00,
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 1.5, color: ColorConstant.neutral300),
                    ),
                    child: SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: Checkbox(
                        value: selected,
                        onChanged: (selected) {
                          onSelect(idValue.id);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: ColorConstant.primary500,
                        fillColor: MaterialStateColor.resolveWith(
                          (states) {
                            if (selected) {
                              return ColorConstant.primary500;
                            }
                            return ColorConstant.transparent;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (enableDivider)
            Divider(
              color: ColorConstant.neutral300,
              height: 0.5,
            ),
        ],
      ),
    );
  }
}
