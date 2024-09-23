import 'package:flutter/material.dart';

import '../buttons/tag_item.dart';
import '../text_field/submittable_field.dart';

class TagsSelection extends StatefulWidget {
  final String title;
  final List<String> selection;
  final Function(List<String>) onSelect;
  final String? placeholderText;
  final int maxCount;
  final String? errorMessage;
  const TagsSelection({
    super.key,
    required this.title,
    required this.selection,
    required this.onSelect,
    this.placeholderText,
    this.maxCount = 12,
    this.errorMessage,
  });

  @override
  State<TagsSelection> createState() => _TagsSelectionState();
}

class _TagsSelectionState extends State<TagsSelection> {
  @override
  Widget build(BuildContext context) {
    List<Tag> tags = widget.selection
        .map(
          (tag) => Tag(title: tag, size: TagSize.medium, enabledDelete: true),
        )
        .toList();
    final modifiedTags = TagWrap(wrappedTags: tags, axis: Axis.horizontal);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SubmittableField(
          hasErrors: modifiedTags.wrappedTags.length == widget.maxCount ,
          captionText:
              "${modifiedTags.wrappedTags.length} of ${widget.maxCount} ${widget.title}. ${modifiedTags.wrappedTags.length == widget.maxCount ? widget.errorMessage : ''}",
          group: modifiedTags,
          placeholderText: widget.placeholderText ?? "Bookkeeper",
          submitText: "Add",
          isEnabled: modifiedTags.wrappedTags.length < widget.maxCount
              ? true
              : false,
          onSubmit: (value) {
            if (modifiedTags.wrappedTags.length <= widget.maxCount && value.isNotEmpty) {
              setState(() {
                if (modifiedTags.wrappedTags
                    .where((element) => element.title == value)
                    .isEmpty) {
                  modifiedTags.wrappedTags
                      .add(Tag(title: value, enabledDelete: true));
                  widget.onSelect(
                      modifiedTags.wrappedTags.map((e) => e.title).toList());
                }
              });
            }
          },
        ),
        SizedBox(
          width: double.infinity,
          child: WrapTag(
            group: modifiedTags,
            onTapTag: (tag) {
              if (tag.enabledDelete) {
                setState(() {
                  modifiedTags.wrappedTags
                      .removeWhere((element) => element.title == tag.title);
                  widget.onSelect(
                      modifiedTags.wrappedTags.map((e) => e.title).toList());
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
