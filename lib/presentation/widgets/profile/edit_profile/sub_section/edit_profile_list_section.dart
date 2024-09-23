import 'package:flutter/material.dart';
import 'edit_profile_section.dart';

class EditProfileListSection extends StatelessWidget {
  final List<Widget> navigations;
  const EditProfileListSection({
    super.key,
    required this.navigations,
  });

  @override
  Widget build(BuildContext context) {
    return EditProfileSection(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: navigations,
        ),
      ),
    );
  }
}
