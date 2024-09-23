import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import '../../../../../pages/navigation/profile/default/profile_tags_section.dart';
import '../../../../buttons/tag_item.dart';

class CompanyGeneralSection extends StatelessWidget {
  final String companyWebsite;
  final int lookingToHire;
  const CompanyGeneralSection({
    super.key,
    required this.companyWebsite,
    required this.lookingToHire,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileTagsSection(
      header: TranslationKeys.general,
      children: [
        if (companyWebsite != "")
          WrapTag(
            group: TagWrap(
              wrappedTags: [
                if (companyWebsite != "")
                  Tag(
                    title: companyWebsite,
                    status: TagStatus.neutral,
                    size: TagSize.medium,
                  ),
              ],
            ),
          ),
        if (lookingToHire != 0)
          WrapTag(
            group: TagWrap(
              wrappedTags: [
                Tag(
                  title: TranslationKeys
                      .lookingToHire(lookingToHire.toString()),
                  status: TagStatus.success,
                  size: TagSize.medium,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
