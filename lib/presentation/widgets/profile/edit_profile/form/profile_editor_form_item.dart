import 'package:flutter/material.dart';

import 'profile_editor_form_label.dart';

class ProfileEditorFormItem extends StatelessWidget {
  final String label;
  final Widget children;
  final String? caption;
  final bool padded;
  final bool spaced;
  const ProfileEditorFormItem({
    super.key,
    required this.label,
    required this.children,
    this.caption,
    this.padded = false,
    this.spaced = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileEditorFormLabel(label: label, padded: padded),
        if (spaced) const SizedBox(height: 8.0),
        children,
        if (caption != null)
          ProfileEditorFormLabel(
            label: caption!,
            padded: padded,
          ),
      ],
    );
  }
}
