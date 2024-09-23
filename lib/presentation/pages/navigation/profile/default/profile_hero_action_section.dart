import 'package:flutter/material.dart';
import '../../../../../core/resources/l10n/translation_key.dart';
import '../../../../widgets/buttons/capsule_button.dart';
import '../../../../widgets/profile/profile_section.dart';

class ProfileHeroAction extends StatelessWidget {
  final VoidCallback onTap;
  const ProfileHeroAction({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileSection(
      includePadding: false,
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CapsuleButton(
              title: TranslationKeys.editProfile,
              bordered: true,
              onTap: onTap,
              autoGrow: false,
              autoExpand: true,
              size: CapsuleButtonSize.xlarge,
            ),
          ],
        ),
      ),
    );
  }
}
