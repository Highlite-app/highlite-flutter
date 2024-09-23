import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resources/asset_constants.dart';
import '../../../../../core/resources/color_constants.dart';
import '../../../../../core/resources/typography_theme.dart';
import '../../../buttons/svg_button.dart';
import '../../../constants/text_style.dart';

class EditProfileDetailsSectionContainer<T> extends StatelessWidget {
  final List<T> profileDetails;
  final String heading;
  final bool isEditProfile  ;
  final Widget Function(BuildContext context, int index, T item) itemBuilder;

  const EditProfileDetailsSectionContainer({
    required this.heading,
    required this.profileDetails,
    required this.itemBuilder,
     this.isEditProfile = true ,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                heading,
                style: BaseTextStyle(
                    color: ColorConstant.shade100,
                    fontSize: TypographyTheme.heading_H5,
                    fontWeight: FontWeight.w500),
              ),
              SvgButton(asset: AssetConstant.plusCircleIcon, onTap: () {}),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          ListView.separated(
            shrinkWrap: true, // Prevent infinite height error
            physics: NeverScrollableScrollPhysics(), // Prevent scrolling within ListView.builder
            itemCount: profileDetails.length,
            itemBuilder: (context, index) {
              return itemBuilder(context, index, profileDetails[index]);
            },
            separatorBuilder: (context , index){
              return Divider(color: ColorConstant.neutral200,) ; 
            },
          ),
        ],
      ),
    );
  }
}

class ProfileDetailsItem extends StatelessWidget {
  final int index; // Add index as a parameter
  final String? profileUrl;
  final String title;
  final bool isEditProfile ;
  final String subtitle;
  final String? jobType;
  final String? startDate;
  final String? endDate;
  final String? duration;
  final VoidCallback onTapEditIcon;

   ProfileDetailsItem({
    super.key,
    required this.index, // Initialize the index parameter
    this.profileUrl,
    required this.title,
    required this.subtitle,
    required this.onTapEditIcon,
     this.isEditProfile = true  ,
    this.jobType,
    this.startDate,
    this.endDate,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: CachedNetworkImage(
            imageUrl: profileUrl ?? '',
            width: 42,
            height: 42,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Container(
                  width: 42, // Adjust width to match the image size
                  height: 42, // Adjust height to match the image size
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: ColorConstant.neutral500, width: 1),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AssetConstant.buildingIcon,
                      width: 25,
                      height: 25,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
            errorWidget: (context, url, error) =>
                Container(
                  width: 42, // Adjust width to match the image size
                  height: 42, // Adjust height to match the image size
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: ColorConstant.neutral500, width: 1),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AssetConstant.buildingIcon,
                      width: 25,
                      height: 25,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
          ),
        ),
        const SizedBox(width: 12),
        // Add some spacing between the image and text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p3,
                  fontWeight: FontWeight.w700,
                  color: ColorConstant.shade100,
                ),
              ),
              Text(
                subtitle,
                style: BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p4,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.neutral800,
                ),
              ),
              Row(
                children: [
                  if (jobType != null && jobType!.isNotEmpty)
                    Text(
                      jobType!,
                      style:textStyle,
                    ),
                  if (jobType != null && jobType!.isNotEmpty)
                    Text(
                      " | ",
                      style:textStyle,
                    ),
                  if (startDate != null && startDate!.isNotEmpty)
                    Text(
                      startDate!,
                      style:textStyle,
                    ),
                  if ((startDate != null && startDate!.isNotEmpty) || (endDate != null && endDate!.isNotEmpty))
                    Text(
                      " - ",
                      style: textStyle,
                    ),
                  if (endDate != null && endDate!.isNotEmpty)
                    Text(
                      endDate!,
                      style: textStyle,
                    ),
                  if (endDate == null || endDate!.isEmpty)
                    Text(
                      'Present',
                      style: textStyle,
                    ),
                ],
              )

            ],
          ),
        ),
        if(isEditProfile)
        SvgButton(asset: AssetConstant.editIcon1, onTap: onTapEditIcon),
      ],
    );
  }

  TextStyle textStyle = BaseTextStyle(
      color: ColorConstant.neutral600,
      fontWeight: FontWeight.w400,
      fontSize: TypographyTheme.paragraph_p5) ;

}




