import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/string.dart';

import '../../../../core/resources/typography_theme.dart';
import '../../constants/text_style.dart';
import '../../layout/bordered_box.dart';
import '../../svg/svg_asset.dart';
import '../../text/iconized_text.dart';

class PlaybackTile extends StatelessWidget {
  final String image;
  final String title;
  final String jobLocation;
  final String salary;
  final VoidCallback? onTap;

  const PlaybackTile({
    super.key,
    required this.image,
    required this.title,
    required this.jobLocation,
    required this.salary,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BorderedBox(
      onTap: onTap,
      backgroundColor: ColorConstant.neutral50,
      verticalPadding: 0.0,
      horizontalPadding: 0.0,
      direction: Axis.vertical,
      borderRadius: 4.0,
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 150,
                child: FutureBuilder(
                  future: image.validateImage(),
                  builder: (context, result) {
                    if (result.data == false) {
                      return Container(
                        height: 150,
                        color: ColorConstant.shade00,
                      );
                    }
                    return Stack(
                      children: [
                        Image.network(
                          image,
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        Center(
                          child: SvgAsset(
                            asset: AssetConstant.playIcon2,
                            size: 24,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                child: Wrap(
                  spacing: 6.0,
                  direction: Axis.vertical,
                  children: [
                    Text(
                      title,
                      style: BaseTextStyle(
                        fontSize: TypographyTheme.paragraph_p4,
                        color: ColorConstant.neutral800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconizedText(
                      icon: AssetConstant.briefCaseIcon,
                      text: jobLocation,
                      iconColor: ColorConstant.neutral800,
                      iconSize: 20,
                      spacing: 10.0,
                      textColor: ColorConstant.neutral800,
                      textSize: TypographyTheme.paragraph_p4,
                      fontWeight: FontWeight.w600,
                    ),
                    IconizedText(
                      icon: AssetConstant.currencyDollarIcon,
                      text: salary,
                      iconColor: ColorConstant.neutral800,
                      iconSize: 20,
                      spacing: 10.0,
                      textColor: ColorConstant.neutral800,
                      textSize: TypographyTheme.paragraph_p4,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
