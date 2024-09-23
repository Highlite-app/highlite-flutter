import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/profile_picture.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/svg/svg_asset.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../core/services/location_service.dart';

class CandidatePublicProfileHeader extends StatelessWidget {
  final String profileUrl ;
  final String followingCount ;
  final String followersCount ;
  final String likeCount ;
  final String location  ;
  final String about ;
  final VoidCallback? onChangeProfilePicture ;
  final VoidCallback onTapResume ;
  final VoidCallback onTapMessage ;
  final VoidCallback onTapFollow ;

  const CandidatePublicProfileHeader({
    required this.profileUrl ,
    required this.followingCount ,
    required this.followersCount ,
    required this.likeCount ,
    required this.location ,
    required this.about ,
    this.onChangeProfilePicture ,
    required this.onTapResume ,
    required this.onTapMessage ,
    required this.onTapFollow ,
    super.key, })  ;

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
                    onTap: onChangeProfilePicture ?? (){} ,
                    child: Stack(
                      children: [
                        ProfilePicture(
                          size: 80,
                          url: profileUrl ,
                        ) ,
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
                          ProfileStats(count: int.parse(followingCount), label: 'Following'),
                          const Spacer(),
                          ProfileStats(count:  int.parse(followersCount), label: 'Followers'),
                          const Spacer(),
                          ProfileStats(count: int.parse(likeCount), label: 'Likes'),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        maxLines: 2,
                        about ,
                        style: BaseTextStyle(
                            fontSize: TypographyTheme.paragraph_p4,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.neutral700),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          InkWell(
                            onTap:() async{
                              final locationManager = LocationService();
                              final latLong = await locationManager.getLatLong();
                              final  latitude = latLong?['latitude'] ;
                              final longitude = latLong?['longitude'] ;
                              String googleMapUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                              if (await canLaunchUrl(Uri.parse(googleMapUrl))) {
                              await launchUrl(Uri.parse(googleMapUrl));
                              } else {
                              throw 'Could not open the map.';
                              }
                },
                            child: Image.asset(
                              AssetConstant.locationFilledIcon,
                              color: ColorConstant.primary500,
                              width: 15,
                              height: 15,
                            ),
                          ),
                          const  SizedBox(width: 4),
                          Text(
                            location,
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
              Expanded(
                child:
                ElevatedButton(
                  onPressed: onTapFollow ,
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: ColorConstant.primary500),
                  child: Text(
                    'Follow',
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
                  onPressed: onTapResume,
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: ColorConstant.neutral100),
                  child: Text(
                    'Resume',
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
                  onPressed: onTapMessage ,
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
