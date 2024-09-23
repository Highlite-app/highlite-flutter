import 'package:flutter/material.dart';
import '../../../../../core/resources/asset_constants.dart';
import '../../../../../core/resources/color_constants.dart';
import '../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../core/resources/typography_theme.dart';
import '../../../chip/status_chip.dart';
import '../../../constants/text_style.dart';
import '../../../svg/svg_asset.dart';
import '../../profile_picture.dart';

enum VideoStatus {
  draft,
  active,
  pending,
  inactive;
}

class EditProfileGraphicContainer extends StatelessWidget {
  final String profile;
  final String icon;
  final String text;
  final VideoStatus? videoStatus;
  final VoidCallback onTap;

  const EditProfileGraphicContainer({
    super.key,
    required this.icon,
    required this.profile,
    required this.text,
    required this.onTap,
    this.videoStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePicture(
          size: 80,
          emptySize: 80,
          opacity: 0.3,
          url: profile,
          shouldAllowEmptyProfile: false,
          emptyBackground: ColorConstant.neutral100,
          overlayIcon: SvgAsset(
            asset: icon,
            size: 24,
          ),
          onTapProfile: onTap,
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style:  BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p3,
            color: ColorConstant.neutral800,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (videoStatus != null) const SizedBox(height: 8),
        if (videoStatus != null) VideoStatusChip(status: videoStatus!),
      ],
    );
  }
}

class VideoStatusChip extends StatelessWidget {
  final VideoStatus status;
  final ChipSize size;
  const VideoStatusChip({
    super.key,
    required this.status,
    this.size = ChipSize.normal,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case VideoStatus.draft:
        return StatusChip(
          icon: AssetConstant.chipDraftIcon,
          text: TranslationKeys.draft,
          status: ChipStatus.neutral,
          size: size,
        );
      case VideoStatus.pending:
        return StatusChip(
          icon: AssetConstant.chipDraftIcon,
          text: TranslationKeys.pending,
          status: ChipStatus.pending,
          size: size,
        );
      case VideoStatus.active:
        return StatusChip(
          icon: AssetConstant.chipActiveIcon,
          text: TranslationKeys.active,
          status: ChipStatus.active,
          size: size,
        );
      case VideoStatus.inactive:
        return StatusChip(
          icon: AssetConstant.chipInActiveIcon,
          text: TranslationKeys.inactive,
          status: ChipStatus.inactive,
          size: size,
        );
    }
  }
}
