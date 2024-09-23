import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/appBar/base_appbar.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chat/chat_bubble.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';
class OnBoardingAppBar extends StatelessWidget with BaseAppBar {
  final List<ChatMessage> messages ;
  final VoidCallback onClickReset;
  final bool enabledRefreshButton;
   OnBoardingAppBar({
    required this.messages ,
    required this.onClickReset ,
    required this.enabledRefreshButton ,
    super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: messages.length >= 10
          ? const AssistantHeader()
          : const HighliteLogo(),
      elevation: 0,
      bottomOpacity: 0.0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      shape: Border(
        bottom: BorderSide(
          color: ColorConstant.shade100.withOpacity(0.10),
          width: 1,
        ),
      ),
      actions: [
        enabledRefreshButton
            ? Container(
          margin: const EdgeInsets.only(right: 10),
          child:  IconButton(
            icon: SvgAsset(
                asset: AssetConstant.refreshIcon,
                color: ColorConstant.neutral500),
            onPressed: null,
          ),
        )
            : Container(
          margin: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon:  const SvgAsset(asset:AssetConstant.refreshIcon),
            onPressed: onClickReset,
          ),
        ),
      ],
    );
  }
}

class AssistantHeader extends StatelessWidget {
  const AssistantHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(top: 5),
                  decoration:  BoxDecoration(
                      shape: BoxShape.circle, color: ColorConstant.success500),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child:  Text(
                    "EJ",
                    style: BaseTextStyle(
                        fontSize: TypographyTheme.paragraph_p3,
                        color: ColorConstant.neutral900,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 2),
              child:  Text("Personal Assistant",
                  style: BaseTextStyle(
                      fontSize: TypographyTheme.paragraph_p4,
                      color: ColorConstant.neutral600)),
            )
          ],
        ),
      ),
    );
  }
}

class HighliteLogo extends StatelessWidget {
  const HighliteLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: Image.asset(AssetConstant.icHighLiteSMLogo),
    );
  }
}
