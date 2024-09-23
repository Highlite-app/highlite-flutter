import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/profile_section.dart';

class ProfileSectionSpacer extends StatelessWidget {
  final double height;
  final VoidCallback? onEdit;
  final String? header;
  const ProfileSectionSpacer(
      {super.key, required this.height, this.onEdit, this.header});

  @override
  Widget build(BuildContext context) {
    return ProfileSection(
      includePadding: false,
      widget: Container(
        height: height,
      ),
      onEdit: onEdit,
      header: header,
    );
  }
}
