import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../chat/chat_responder.dart';
import '../constants/text_style.dart';
import 'primary_button.dart';

class TagResponder extends StatefulWidget {
  final List<String> tags;
  final double bottomPadding;
  final Function onSubmit;
  final MinMax<int> tagsSelection;

  const TagResponder(
      {super.key,
      required this.tags,
      required this.bottomPadding,
      required this.onSubmit,
      required this.tagsSelection});

  @override
  State<TagResponder> createState() => _TagResponderState();
}

class _TagResponderState extends State<TagResponder> {
  List<String> selectedTags = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomPadding),
      child: Column(
        children: [
          Container(
            decoration:  BoxDecoration(
                border: Border.symmetric(
                    horizontal:
                        BorderSide(color: ColorConstant.neutral100, width: 1))),
            child: TagGroup(
              tags: widget.tags,
              height: widget.tags.length >= 20
                  ? 390
                  : (widget.tags.length / 4) * 60,
              onSelectTag: (selectedTags) {
                setState(() {
                  this.selectedTags = selectedTags;
                });
              },
              maxSelection: widget.tagsSelection.max,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PrimaryButton(
              title: TranslationKeys.continueText,
              onTap: selectedTags.length >= widget.tagsSelection.min
                  ? () {
                      widget.onSubmit(selectedTags);
                    }
                  : null,
            ),
          )
        ],
      ),
    );
  }
}

class TagGroup extends StatefulWidget {
  final List<String> tags;
  final double height;
  final double maxWidth;
  final Function onSelectTag;
  final int maxSelection;
  final bool selectable;
  const TagGroup({
    super.key,
    required this.tags,
    this.maxWidth = double.infinity,
    required this.height,
    required this.onSelectTag,
    required this.maxSelection,
    this.selectable = true,
  });

  @override
  State<TagGroup> createState() => _TagGroupState();
}

class _TagGroupState extends State<TagGroup> {
  List<String> selectedTags = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: widget.height,
            maxHeight: widget.height,
            maxWidth: widget.maxWidth),
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 8.0,
            runSpacing: 8.0,
            direction: Axis.horizontal,
            children: widget.tags
                .map(
                  (tag) => TagButton(
                    title: tag,
                    onTap: selectedTags.length < widget.maxSelection ||
                            selectedTags.contains(tag)
                        ? () {
                            if (widget.selectable) {
                              setState(() {
                                if (selectedTags.contains(tag)) {
                                  selectedTags.remove(tag);
                                } else {
                                  selectedTags.add(tag);
                                }
                              });
                              widget.onSelectTag(selectedTags);
                            }
                          }
                        : null,
                    selected: selectedTags.contains(tag),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class TagButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool selected;
  const TagButton(
      {super.key,
      required this.title,
      required this.onTap,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      elevation: 0,
      pressElevation: 0,
      onPressed: onTap ?? () {},
      backgroundColor: onTap == null
          ? ColorConstant.neutral50
          : (selected ? ColorConstant.primary500 : ColorConstant.shade00),
      disabledColor: ColorConstant.neutral50,
      label: Text(title),
      clipBehavior: Clip.none,
      labelStyle: BaseTextStyle(
          fontSize: TypographyTheme.paragraph_p3,
          color: onTap != null
              ? (selected ? ColorConstant.shade00 : ColorConstant.neutral900)
              : ColorConstant.neutral600,
          fontWeight: FontWeight.w600,
          height: 1.1),
      labelPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          side: BorderSide(
              color: ColorConstant.neutral300, width: selected ? 0 : 1)),
    );
  }
}
