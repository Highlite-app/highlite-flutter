
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/profile_picture.dart';
class PublicProfileInfoHeader extends StatelessWidget {
  final String profilePicture ;
  final String heading ;
  final String lastUpdated ;

  const PublicProfileInfoHeader({
    required this.profilePicture,
    required this.heading,
    required this.lastUpdated,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding:const  EdgeInsets.all(16 ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ProfilePicture(
              size: 60,
              url: profilePicture
            ),
            const SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: BaseTextStyle(
                      fontSize: TypographyTheme.heading_H5_small,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.shade100),
                ),
                const SizedBox(height: 4),
                Text(lastUpdated , style: BaseTextStyle(
                    color: ColorConstant.neutral600 ,
                    fontSize: TypographyTheme.paragraph_p5 ,
                    fontWeight: FontWeight.w400
                ),),
              ],
            ),

          ],
        ),
      ),
    );
  }
}