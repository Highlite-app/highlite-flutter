import 'package:flutter/material.dart';
import '../../../../widgets/profile/profile_section.dart';

class ProfileTagsSection extends StatelessWidget {
  final List<Widget> children;
  final String header;
  const ProfileTagsSection({
    super.key,
    required this.children,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileSection(
      includePadding: false,
      addPadding: true,
      header: header,
      widget: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
            ),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: -4.0,
              runSpacing: 5.0,
              direction: Axis.vertical,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
