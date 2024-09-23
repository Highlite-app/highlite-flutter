import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../../core/resources/typography_theme.dart';
import '../../buttons/tag_item.dart';
import '../../constants/text_style.dart';

class SkillSearchSection extends StatelessWidget {
  final String title;
  final List<String> skills;
  final Function(Tag)? onTapTag;
  const SkillSearchSection({
    super.key,
    required this.title,
    required this.skills,
    this.onTapTag,
  });

  @override
  Widget build(BuildContext context) {
    if (skills.isEmpty) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:  BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p4,
              color: ColorConstant.neutral600,
              fontWeight: FontWeight.w500,
            ),
          ),
          WrapTag(
            group: TagWrap(
              wrappedTags: skills
                  .map((skill) => Tag(
                      title: skill, enabledSelect: true, size: TagSize.medium))
                  .toList(),
            ),
            onTapTag: onTapTag ?? (tag) {},
          ),
        ],
      ),
    );
  }
}
