import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/string.dart';

import '../buttons/rippler.dart';
import '../buttons/tiny_button.dart';
import 'empty_profile.dart';


class ProfilePicture extends StatefulWidget {
  final double size;
  final double emptySize;
  final bool allowEdit;
  final bool isPremiumUser;
  final bool isSuperPremiumUser;
  final bool showOnlineIndicator;
  final String url;
  final VoidCallback? onEdit;
  final VoidCallback? onTapProfile;
  final double? padding;
  final Color? emptyBackground;
  final double? tinySize;
  final Color? tinyColor;
  final Widget? overlayIcon;
  final double opacity;
  final bool shouldAllowEmptyProfile;
  const ProfilePicture({
    super.key,
    required this.size,
    this.allowEdit = false,
    this.onEdit,
    this.onTapProfile,
    this.isPremiumUser = false,
    this.isSuperPremiumUser = false,
    required this.url,
    this.emptySize = 90,
    this.padding,
    this.emptyBackground,
    this.tinySize,
    this.tinyColor,
    this.showOnlineIndicator = false,
    this.overlayIcon,
    this.opacity = 1,
    this.shouldAllowEmptyProfile = true,
  });

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTapProfile,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width:
                widget.url.isValidURLForImage() ? widget.size : widget.emptySize,
            height:
                widget.url.isValidURLForImage() ? widget.size : widget.emptySize,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(

              border: widget.isPremiumUser || widget.isSuperPremiumUser
                  ? Border.all(color: ColorConstant.primary500, width: 3)
                  : null,
              shape: BoxShape.circle,
            ),
            child: FutureBuilder(
                future: widget.url.validateImage(),
                builder: (context, result) {
                  if (result.data == false) {
                    return Rippler(
                      onTap: widget.onTapProfile,
                      backgroundColor: widget.emptyBackground != null
                          ? widget.emptyBackground!
                          : Colors.transparent,
                      child: EmptyProfile(
                        size: widget.size,
                        padding: widget.padding,
                        backgroundColor: Colors.transparent,
                        shouldAllowEmptyProfile: widget.shouldAllowEmptyProfile,
                      ),
                    );
                  }
                  return Rippler(
                    onTap: widget.onTapProfile,
                    child: Opacity(
                      opacity: widget.opacity,
                      child: ClipOval(
                        child: widget.url.isValidURLForImage()
                            ? Image.network(
                                widget.url,
                                errorBuilder: (context, url, error) =>
                                    EmptyProfile(
                                  size: widget.size,
                                  padding: widget.padding,
                                  backgroundColor: widget.emptyBackground,
                                ),
                                fit: BoxFit.fill,
                              )
                            : EmptyProfile(
                                size: widget.size,
                                padding: widget.padding,
                                backgroundColor: widget.emptyBackground,
                              ),
                      ),
                    ),
                  );
                }),
          ),
          if (widget.overlayIcon != null)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: widget.overlayIcon!,
              ),
            ),
          if (widget.allowEdit)
            Positioned(
              bottom: -5,
              right: 0,
              width: 25,
              height: widget.tinySize ?? 25,
              child: _editIcon(),
            ),
          if (widget.isPremiumUser)
            Positioned(
              bottom: -5,
              right: 10,
              width: 25,
              height: widget.tinySize ?? 25,
              child: _lightningIcon(),
            ),
          if (widget.isSuperPremiumUser)
            Positioned(
              bottom: -5,
              right: 10,
              width: 25,
              height: widget.tinySize ?? 25,
              child: _superLightningIcon(),
            ),
          if (widget.showOnlineIndicator)
            Positioned(
              bottom: -5,
              right: -5,
              width: 18,
              height: 18,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstant.success500,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 3,
                    color: ColorConstant.shade00,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _lightningIcon() {
    return TinyButton(
      color: widget.tinyColor ?? ColorConstant.primary500,
      splashColor: ColorConstant.primary500,
      onTap: () {},
      icon: AssetConstant.lightingIcon,
      iconColor: ColorConstant.shade00,
      iconPadding: 4.0,
      size: 15,
    );
  }
  Widget _superLightningIcon() {
    return TinyButton(
      color: widget.tinyColor ?? ColorConstant.primary500,
      splashColor: ColorConstant.primary500,
      onTap: () {},
      icon: AssetConstant.superLightningIcon,
      iconColor: ColorConstant.shade00,
      iconPadding: 4.0,
      size: 15,
    );
  }

  Widget _editIcon() {
    return TinyButton(
      color: widget.tinyColor ?? ColorConstant.neutral200,
      splashColor: ColorConstant.neutral400,
      onTap: widget.onEdit ?? () {},
      icon: "icon-pencil",
      iconColor: ColorConstant.shade100,
      iconPadding: 7.0,
      size: 15,
    );
  }
}
