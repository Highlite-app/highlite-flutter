import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/profile/appbar/settings_page.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';
import '../../../../../core/resources/typography_theme.dart';
import '../../../../widgets/appBar/base_appbar.dart';
import '../../../../widgets/buttons/svg_button.dart';
import '../../../../widgets/constants/text_style.dart';
import '../../../../widgets/navigation/back_button.dart';

class ProfileAppBar extends StatefulWidget with BaseAppBar {
  final String username;
  final String? title ;
  final NavigatorState navigator;
  final Function()? onPop ;
  final bool isPreview;
  final String selectedProfileId;
  final bool? isProfileBookmark ;

  ProfileAppBar({
    super.key,
    required this.username,
    this.onPop ,
    required this.navigator,
    required this.isPreview,
    this.title ,
    required this.selectedProfileId,
     this.isProfileBookmark,
  });

  @override
  State<ProfileAppBar> createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  var isProfileBookmark = false ;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0 ,top: 12 , right: 16 , bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title ?? '',
              style: BaseTextStyle(
                color: ColorConstant.shade100,
                fontWeight: FontWeight.bold,
                fontSize: TypographyTheme.heading_H5_small,
              ),
            ),
            Text(
              widget.username,
              style: BaseTextStyle(
                  color: ColorConstant.shade100,
                  fontSize: TypographyTheme.paragraph_p5,
                  fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ),
      leading: widget.isPreview
          ? BackNavigationButton(
        onPop: widget.onPop,
          navigator: widget.navigator)
          : null,
      backgroundColor: ColorConstant.shade00,
      elevation: 0,
      actions: <Widget>[
        if (widget.isPreview)
        //TODO: NEED TO ADD STATE ONCE UI IS COMPLETED
                 SvgButton(
                 asset: isProfileBookmark ? AssetConstant.bookmarkIconSelectedV2 : AssetConstant.bookmarkIcon,
                  onTap: ()async {
                    if( isProfileBookmark  == false) {
                      //    TODO: WE ADD MY SELECT BOOKMARK OVERLAY 2
                    }else{
                      //    TODO: WE ADD MY SELECT BOOKMARK OVERLAY 2
                    }
                  },
                  size: 24,
                ),

        if (!widget.isPreview)
          SvgButton(
            asset: AssetConstant.settingIcon,
            onTap: () {
              context.navigator.push(
                MaterialPageRoute(
                  builder: (_) => const SettingsPage(),
                ),
              );
            },
            size: 24,
          ),
      ],
    );
  }

  // @override
  // Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
