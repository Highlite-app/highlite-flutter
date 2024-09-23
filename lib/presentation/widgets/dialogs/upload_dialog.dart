import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/buttons/icon_button.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/svg/svg_asset.dart';

import '../buttons/tiny_button.dart';

// class UploadDialog {
//   static void showUploadDialog(
//       {required BuildContext context,
//       required VoidCallback onTapUploadVideo,
//       required VoidCallback onTapUploadResume}) {
//     showGeneralDialog(
//         context: context,
//         barrierDismissible: true,
//         barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
//         barrierColor: Colors.black45,
//         transitionBuilder:(context, animation, secondaryAnimation, child) {
//           return SlideTransition(
//             position: Tween<Offset>(
//               begin: const Offset(0, 1),
//               end: Offset.zero,
//             ).animate(animation),
//             child: child,
//           );
//         } ,
//         pageBuilder: (context, animation1, animation2) {
//           return UploadDialogWidget(
//             onTapUploadVideo: onTapUploadVideo,
//             onTapDetails: onTapUploadResume,
//           );
//         });
//   }
// }

class UploadDialogWidget extends StatelessWidget {
  final VoidCallback onTapUploadVideo;
  final VoidCallback onTapDetails;
  final String detailText ;
  const UploadDialogWidget(
      {required this.onTapUploadVideo,
      required this.onTapDetails,
        required this.detailText ,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  TranslationKeys.uploadText,
                  style: BaseTextStyle(
                      color: ColorConstant.primary900,
                      fontSize: TypographyTheme.paragraph_p2,
                      fontWeight: FontWeight.w600),
                ),


              ],
            ),
            const SizedBox(height: 16.0),
            InkWell(
              onTap: (){
                onTapUploadVideo() ;
              },
              child: IconizedButton(
                  onTapIcon: onTapUploadVideo,
                  text: TranslationKeys.uploadingVideo),
            ),
            const SizedBox(height: 16.0),
            InkWell(
              onTap: (){
                onTapDetails() ;
              },
              child: IconizedButton(
                  onTapIcon: onTapDetails, text:detailText),
            )
          ],
        ),
      ),
    );
  }
}
