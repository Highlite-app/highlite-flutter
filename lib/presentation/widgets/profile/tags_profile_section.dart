import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/profile_section.dart';
import '../buttons/tag_item.dart';
import '../text_field/submittable_field.dart';
import 'credentials_button_stack.dart';

class TagsProfileSection extends StatefulWidget {
  final String title;
  final String? addText;
  final TagWrap groupTags;
  final bool isPreview;
  final Function(List<String>) onSave;
  const TagsProfileSection(
      {super.key,
      required this.title,
      this.addText,
      required this.groupTags,
      required this.isPreview,
      required this.onSave});

  @override
  State<TagsProfileSection> createState() => _TagsProfileSectionState();
}

class _TagsProfileSectionState extends State<TagsProfileSection> {
  bool editMode = false;
  @override
  Widget build(BuildContext context) {
    List<Tag> tags = widget.groupTags.wrappedTags
        .map((tag) => Tag(title: tag.title, size: tag.size))
        .toList();
    final editableTags = tags;
    if (widget.addText != null &&
        editMode == false &&
        widget.isPreview == false) {
      editableTags.add(Tag(
        title: widget.addText!,
        enabledPlus: true,
      ));
    }
    final editableWrapTag =
        TagWrap(wrappedTags: editableTags, axis: widget.groupTags.axis);

    List<Tag> deletableTags = widget.groupTags.wrappedTags
        .map(
            (tag) => Tag(title: tag.title, size: tag.size, enabledDelete: true))
        .toList();
    final deletableWrapTag =
        TagWrap(wrappedTags: deletableTags, axis: widget.groupTags.axis);

    String? title;
    if (widget.isPreview && !editMode) {
      title = tags.isNotEmpty ? widget.title : null;
    } else {
      title = widget.title;
    }
    return ProfileSection(
      includePadding: false,
      addPadding: true,
      widget: editMode
          ? TagsProfileEditor(
              title: widget.title,
              group: deletableWrapTag,
              onEditMode: () {
                setState(() {
                  editMode = true;
                });
              },
              cancelAction: () {
                setState(() {
                  editMode = false;
                });
              },
              saveAction: (tags) {
                widget.onSave(tags);
                setState(() {
                  editMode = false;
                });
              },
            )
          : TagsPreview(
              groupTags: editableWrapTag,
              onTapTag: (tag) {
                if (tag.title == widget.addText) {
                  setState(() {
                    editMode = true;
                  });
                }
              },
            ),
      onEdit: widget.isPreview || editMode
          ? null
          : () {
              setState(() {
                editMode = true;
              });
            },
      header: title,
    );
  }
}

class TagsProfileEditor extends StatefulWidget {
  final String title;
  final TagWrap group;
  final VoidCallback onEditMode;
  final VoidCallback cancelAction;
  final Function(List<String>) saveAction;
  final String? addText;

  const TagsProfileEditor(
      {super.key,
      required this.title,
      required this.group,
      required this.onEditMode,
      required this.cancelAction,
      required this.saveAction,
      this.addText});

  @override
  State<TagsProfileEditor> createState() => _TagsProfileEditorState();
}

class _TagsProfileEditorState extends State<TagsProfileEditor> {
  late TagWrap modifiedTags;
  @override
  void initState() {
    super.initState();
    modifiedTags = widget.group;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: WrapTag(
                  group: modifiedTags,
                  onTapTag: (tag) {
                    if (tag.title == widget.addText) {
                      widget.onEditMode.call();
                    }
                    if (tag.enabledDelete) {
                      setState(() {
                        modifiedTags.wrappedTags.removeWhere(
                            (element) => element.title == tag.title);
                      });
                    }
                  },
                ),
              ),
              SubmittableField(
                captionText:
                    "${modifiedTags.wrappedTags.length} of 12 ${widget.title}.",
                group: modifiedTags,
                placeholderText: "Bookkeeper",
                submitText: "Add",
                onSubmit: (value) {
                  setState(() {
                    if (modifiedTags.wrappedTags
                        .where((element) => element.title == value)
                        .isEmpty) {
                      modifiedTags.wrappedTags
                          .add(Tag(title: value, enabledDelete: true));
                    }
                  });
                },
              ),
            ],
          ),
        ),
        CredentialsButtonStack(
          isRequestButton: false,
          cancelAction: widget.cancelAction,
          // saveAction: () => widget.saveAction(
          //       modifiedTags.wrappedTags.map((tag) => tag.title).toList()),
          saveAction: () {
            if (modifiedTags.wrappedTags.length < 13) {
              widget.saveAction(
                  modifiedTags.wrappedTags.map((tag) => tag.title).toList());
            }
          },
        ),
      ],
    );
  }
}

class TagsPreview extends StatelessWidget {
  final TagWrap groupTags;
  final Function(Tag) onTapTag;
  const TagsPreview(
      {super.key, required this.groupTags, required this.onTapTag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        left: 16.0,
        right: 16.0,
      ),
      child: SizedBox(
        width: double.infinity,
        child: WrapTag(
          group: groupTags,
          onTapTag: onTapTag,
        ),
      ),
    );
  }
}
