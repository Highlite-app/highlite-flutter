import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/app.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/core/services/location_service.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chip/status_chip.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/svg/svg_asset.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/string.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../google_map/google_map_view.dart';

enum ContentStyle { text, chip , location }

class ProfileSection extends StatelessWidget {
  final String title;
  final String? content;
  final String? icon;
  final Color? iconColor ;
  final List<String>? items;
  final bool isSelected ;
  final ContentStyle contentStyle;

  final bool isLink;

  const ProfileSection(
      {super.key,
      required this.title,
      this.contentStyle = ContentStyle.text,
       this.content,
      this.items,
      this.icon,
        this.iconColor ,
      this.isLink = false,
         this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size ;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
          color: ColorConstant.shade00,
        borderRadius: BorderRadius.circular(8),
      ),


      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            title,
            style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p1,
                fontWeight: FontWeight.w500,
                color: ColorConstant.shade100),
          ),
          const SizedBox(height: 8),
          if (contentStyle == ContentStyle.text && !content.isNullOrEmpty)
            Row(
              children: [
                if (!icon.isNullOrEmpty) SvgAsset(asset: icon ?? '' , color: iconColor ,),
                if (!icon.isNullOrEmpty) const SizedBox(width: 8),
                isLink
                    ? GestureDetector(
                        onTap: () async{

                          final Uri url = Uri.parse(content?? '');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            // Handle the case when the URL can't be launched
                            print('Could not launch $content');
                          }
                        },
                        child: Text(
                          content ?? '',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.solid,
                              decorationColor: ColorConstant.primary500,
                              fontWeight: FontWeight.w400,
                              fontSize: TypographyTheme.paragraph_p4,
                              color: ColorConstant.primary500),
                        ),
                      )
                    : Expanded(
                      child: Text(
                          content ?? '',
                          maxLines: 2,
                          style: BaseTextStyle(
                              color: ColorConstant.shade100,
                              fontSize: TypographyTheme.paragraph_p4,
                              fontWeight: FontWeight.w400),
                        ),
                    ),
              ],
            ),
          if(contentStyle == ContentStyle.location && !content.isNullOrEmpty)
          Row(
            children: [
              if (!icon.isNullOrEmpty) SvgAsset(asset: icon ?? '' , color: iconColor ,),
              if (!icon.isNullOrEmpty) const SizedBox(width: 8),
              if (isLink) GestureDetector(
                onTap: () async{
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
                //  globalNavKey.currentState!.push(MaterialPageRoute(builder: (_)=> GoogleMapWebView(latitude:latLong?['latitude'] ?? 0.0 , longitude: latLong?['longitude'] ?? 0.0) , )) ;
                },
                child: Text(
                  content ?? '',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: ColorConstant.primary500,
                      fontWeight: FontWeight.w400,
                      fontSize: TypographyTheme.paragraph_p4,
                      color: ColorConstant.primary500),
                ),
              ) else Expanded(
                child: Text(
                  content ?? '',
                  maxLines: 2,
                  style: BaseTextStyle(
                      color: ColorConstant.shade100,
                      fontSize: TypographyTheme.paragraph_p4,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          if (contentStyle == ContentStyle.chip && !items.isNullOrEmpty)
            Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: items!
                  .map((language) =>
                  Chip(
                backgroundColor: isSelected ? ColorConstant.primary500 :ColorConstant.shade00,
                        elevation: 0,
                        clipBehavior: Clip.none,
                        labelPadding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 0.5,
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: ColorConstant.neutral300),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                        ),
                        label: Text(
                          language,
                          style: BaseTextStyle(
                              color: isSelected? ColorConstant.shade00 :ColorConstant.shade100,
                              fontWeight: FontWeight.w500,
                              fontSize: TypographyTheme.paragraph_p4),
                        ),
                      ))
                  .toList(),
            ),
        ]),
      ),
    );
  }
}
