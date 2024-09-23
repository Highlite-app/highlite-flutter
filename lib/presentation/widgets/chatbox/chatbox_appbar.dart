import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../core/resources/asset_constants.dart';
import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../appBar/base_appbar.dart';
import '../buttons/svg_button.dart';
import '../constants/text_style.dart';
import '../navigation/back_button.dart';
import '../profile/profile_picture.dart';

class ChatboxAppbar extends StatelessWidget with BaseAppBar {
  final String name;
  final String profile;
  final bool online;
  final VoidCallback onTap;
  final VoidCallback onInfo;

  ChatboxAppbar({
    super.key,
    required this.name,
    required this.profile,
    required this.online,
    required this.onTap,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackNavigationButton(navigator: context.navigator),
      elevation: 0,
      title: UserActiveIndicator(
        profile: profile,
        name: name,
        online: online,
      ),
      flexibleSpace: GestureDetector(onTap: onTap),
      shape: Border(
        bottom: BorderSide(
          color: ColorConstant.shade100.withOpacity(0.10),
          width: 1,
        ),
      ),
      actions: [
        SvgButton(asset: AssetConstant.infoCircleIcon, onTap: onInfo),
      ],
    );
  }
}

class UserActiveIndicator extends StatelessWidget {
  final String profile;
  final String name;
  final bool online;

  const UserActiveIndicator({
    super.key,
    required this.profile,
    required this.name,
    required this.online,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfilePicture(
          size: 32,
          emptySize: 32,
          showOnlineIndicator: online,
          url: profile,
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p3,
                color: ColorConstant.neutral800,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Active now",
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p4,
                color: ColorConstant.neutral600,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        )
      ],
    );
  }
}
