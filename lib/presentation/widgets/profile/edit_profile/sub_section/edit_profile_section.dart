import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

class EditProfileSection extends StatelessWidget {
  final Widget child;
  const EditProfileSection({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.shade00,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          child,
        ],
      ),
    );
  }
}
