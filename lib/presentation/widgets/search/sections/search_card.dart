import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/buttons/svg_button.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/svg/svg_asset.dart';

class SearchCard extends StatelessWidget {
  final String title;

  final String jobRole;

  final String location;

  final List<String> skills;

  final List<String> tools;

  final String salary;

  final String jobDuration;

  final String workType;

  final String imageUrl;

  final VoidCallback onTapBookmark;

  final List<String> selectedSkills;
  final List<String> selectedTools;

  const SearchCard(
      {required this.title,
      required this.location,
      required this.jobRole,
      required this.skills,
      required this.tools,
      required this.salary,
      required this.jobDuration,
      required this.workType,
      required this.imageUrl,
      this.selectedSkills = const [],
      this.selectedTools = const [],
      required this.onTapBookmark,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorConstant.neutral300),
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CircleAvatar(
                      radius: 24,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const SvgAsset(asset: AssetConstant.profileIcon),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jobRole,
                          style: BaseTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.primary500,
                          ),
                        ),
                        Text(
                          title,
                          style: BaseTextStyle(
                            color: ColorConstant.neutral900,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          location,
                          style: BaseTextStyle(
                            fontSize: TypographyTheme.paragraph_p4,
                            fontWeight: FontWeight.w500,
                            color: ColorConstant.neutral700,
                          ),
                        ),
                        Row(
                          children: [
                            smallText('\$$salary/hr | '),
                            smallText('$jobDuration | '),
                            smallText(workType),
                          ],
                        ),
                        // _buildTag('\$$salary' , color: ColorConstant.success600 , textColor: ColorConstant.shade00),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  SvgButton(
                    asset: AssetConstant.bookmarkIcon,
                    onTap: onTapBookmark,
                  ),
                ],
              ),
              Wrap(
                children: [
                  ...skills.take(2).map((skill) => buildTag(skill,
                      selected: selectedSkills.contains(skill))),
                  ...tools.take(1).map((tool) =>
                      buildTag(tool, selected: selectedTools.contains(tool))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTag(String label, {bool? selected}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        clipBehavior: Clip.none,
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 0.5,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorConstant.neutral300),
          borderRadius: const BorderRadius.all(Radius.circular(100)),
        ),
        label: Text(
          label,
          style: BaseTextStyle(
              color: selected ?? false
                  ? ColorConstant.shade00
                  : ColorConstant.shade100,
              fontWeight: FontWeight.w500,
              fontSize: TypographyTheme.paragraph_p4),
        ),
        elevation: 0,
        backgroundColor: selected ?? false
            ? ColorConstant.primary500
            : ColorConstant.shade00,
      ),
    );
  }

  Widget smallText(String text) {
    return Text(text,
        style: BaseTextStyle(
          color: ColorConstant.neutral700,
          fontWeight: FontWeight.w400,
          fontSize: TypographyTheme.paragraph_p5,
        ));
  }
}

class BuildTag extends StatelessWidget {
  final String label ;
  final bool selected ;
  const BuildTag({
      required this.label ,
       this.selected  = false ,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        clipBehavior: Clip.none,
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 0.5,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorConstant.neutral300),
          borderRadius: const BorderRadius.all(Radius.circular(100)),
        ),
        label: Text(
          label,
          style: BaseTextStyle(
              color: selected ?? false
                  ? ColorConstant.shade00
                  : ColorConstant.shade100,
              fontWeight: FontWeight.w500,
              fontSize: TypographyTheme.paragraph_p4),
        ),
        elevation: 0,
        backgroundColor: selected ?? false
            ? ColorConstant.primary500
            : ColorConstant.shade00,
      ),
    );;
  }
}

