import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/profile_picture.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/svg/svg_asset.dart';

class CompanyHeaderSectionV2 extends StatefulWidget {
  final String companyLogo ;
  final String followingCount ;
  final String followersCount ;
  final String likeCount ;
  final String location  ;
  final String about ;
  final bool isPreview ;
  final VoidCallback? onChangeProfilePicture ;
  final VoidCallback? onTapEditProfile ;
  final VoidCallback? onTapShareProfile ;
  final VoidCallback? onTapMessage ;
  final VoidCallback? onTapInfo ;
  final VoidCallback? onTapFollow ;

  const CompanyHeaderSectionV2({
    required this.companyLogo ,
    required this.followingCount ,
    required this.followersCount ,
    required this.likeCount ,
    required this.location ,
    required this.about ,
    this.isPreview = false ,
    this.onChangeProfilePicture ,
     this.onTapEditProfile ,
     this.onTapShareProfile ,
     this.onTapMessage ,
    super.key,
    this.onTapInfo,
    this.onTapFollow, })  ;

  @override
  State<CompanyHeaderSectionV2> createState() => _CompanyHeaderSectionV2State();
}

class _CompanyHeaderSectionV2State extends State<CompanyHeaderSectionV2> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: widget.isPreview ? null: widget.onChangeProfilePicture ?? (){} ,
                    child: Stack(
                      children: [
                        ProfilePicture(
                          size: 80,
                          url: widget.companyLogo ,
                        ) ,
                        if(!widget.isPreview)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white , width: 3.1)
                            ),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: ColorConstant.primary500,
                              child: const SvgAsset(
                                  asset: AssetConstant.plusIcon,
                                  color: Colors.white,
                                  size: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileStats(count: int.parse(widget.followingCount), label: 'Following'),
                          const Spacer(),
                          ProfileStats(count:  int.parse(widget.followersCount), label: 'Followers'),
                          const Spacer(),
                          ProfileStats(count: int.parse(widget.likeCount), label: 'Likes'),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        maxLines: 2,
                        widget.about ,
                        style: BaseTextStyle(
                            fontSize: TypographyTheme.paragraph_p4,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.neutral700),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Image.asset(
                            AssetConstant.locationFilledIcon,
                            color: ColorConstant.primary500,
                            width: 15,
                            height: 15,
                          ),
                          const  SizedBox(width: 4),
                          Text(
                            widget.location,
                            style: BaseTextStyle(
                                fontSize: TypographyTheme.paragraph_p4,
                                fontWeight: FontWeight.w400,
                                color: ColorConstant.primary500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              if(!widget.isPreview) ...[
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.isPreview ? null :widget.onTapEditProfile ,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primary500),
                    child: Text(
                      'Edit Profile',
                      textAlign: TextAlign.center,
                      style: BaseTextStyle(
                        color: ColorConstant.shade00,
                        fontSize: TypographyTheme.paragraph_p4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width : 8) ,
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.isPreview ? null :widget.onTapShareProfile,
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: ColorConstant.neutral100),
                    child: Text(
                      'Share',
                      textAlign: TextAlign.center,
                      style: BaseTextStyle(
                        color: ColorConstant.shade100,
                        fontSize: TypographyTheme.paragraph_p4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width : 8) ,
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.isPreview ? null :widget.onTapMessage ,
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: ColorConstant.neutral100),
                    child: Text(
                      'Message',
                      textAlign: TextAlign.center,
                      style: BaseTextStyle(
                        color: ColorConstant.shade100,
                        fontSize: TypographyTheme.paragraph_p4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ] ,

              if(widget.isPreview) ...[
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.isPreview ?(){

                      setState(() {
                         isFollowing = !isFollowing ;
                      });
                      widget.onTapFollow ;
                    }: null ,
                    style: isFollowing ?ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.shade00 , side: BorderSide(color: ColorConstant.primary500)): ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primary500),
                    child: Text(
                      isFollowing ? "Following": 'Follow',
                      textAlign: TextAlign.center,
                      style: BaseTextStyle(
                        color: isFollowing ?ColorConstant.shade100: ColorConstant.shade00,
                        fontSize: TypographyTheme.paragraph_p4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width : 8) ,
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onTapInfo,
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: ColorConstant.neutral100),
                    child: Text(
                      'Info',
                      textAlign: TextAlign.center,
                      style: BaseTextStyle(
                        color: ColorConstant.shade100,
                        fontSize: TypographyTheme.paragraph_p4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width : 8) ,
                Expanded(
                  child: ElevatedButton(
                    onPressed:widget.onTapMessage ,
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: ColorConstant.neutral100),
                    child: Text(
                      'Message',
                      textAlign: TextAlign.center,
                      style: BaseTextStyle(
                        color: ColorConstant.shade100,
                        fontSize: TypographyTheme.paragraph_p4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ]


            ],
          ),
        ],
      ),

    );
  }
}

class ProfileStats extends StatelessWidget {
  final int count;
  final String label;

  const ProfileStats({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$count',
          style: BaseTextStyle(
            color: ColorConstant.shade100,
            fontWeight: FontWeight.w500,
            fontSize: TypographyTheme.paragraph_p3,
          ),
        ),
        Text(
          label,
          maxLines: 1,
          style: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p4,
            fontWeight: FontWeight.w400,
            color: ColorConstant.neutral800,
          ),
        ),
      ],
    );
  }
}
