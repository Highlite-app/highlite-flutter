import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';

import '../../../../pages/navigation/profile/default/profile_tags_section.dart';
import '../../../buttons/tag_item.dart';


class CandidateGeneralSection extends StatelessWidget {
  final String salary;
  final String jobDuration;
  final String jobFlexibility;
  const CandidateGeneralSection({
    super.key,
    required this.salary,
    required this.jobDuration,
    required this.jobFlexibility,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileTagsSection(
      header: TranslationKeys.general,
      children: [
        if ( salary != "")
          WrapTag(
            group: TagWrap(
              wrappedTags: [
                if (salary != "")
                  Tag(
                    title: "\$$salary/hr",
                    status: TagStatus.info,
                    size: TagSize.medium,
                  ),
              ],
            ),
          ),
        if (jobDuration != ""  || jobFlexibility != "")
          WrapTag(
            group: TagWrap(
              wrappedTags: [
                if (jobDuration != "") Tag(title: jobDuration),
                if (jobFlexibility != "") Tag(title: jobFlexibility),
            //    if (communication != "") Tag(title: communication),
              ],
            ),
          ),
      ],
    );
  }
}
