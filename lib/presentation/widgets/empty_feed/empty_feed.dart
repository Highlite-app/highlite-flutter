import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../profile/profile_picture.dart';

class EmptyFeedPage extends StatelessWidget {
  final String profile;
  final String emptyDesc;

  const EmptyFeedPage({
    super.key,
    required this.profile,
    required this.emptyDesc,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _pulseView(ColorConstant.primary500),
        Positioned(
          bottom: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                emptyDesc,
                style: BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p3,
                  color: ColorConstant.neutral600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pulseView(Color pulseColor) {
    return PulseView(
      pulseColor: pulseColor,
      child: ProfilePicture(
        url: profile,
        size: 100,
        emptyBackground: ColorConstant.shade00,
      ),
    );
  }
}

class PulseView extends StatelessWidget {
  final Color pulseColor;
  final Widget child;

  const PulseView({
    super.key,
    required this.pulseColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AvatarGlow(
        glowColor: pulseColor,
        endRadius: 200.0,
        duration: const Duration(milliseconds: 3000),
        repeat: true,
        showTwoGlows: false,
        child: AvatarGlow(
          glowColor: pulseColor,
          endRadius: 200.0,
          duration: const Duration(milliseconds: 4000),
          repeat: true,
          showTwoGlows: false,
          child: AvatarGlow(
            glowColor: pulseColor,
            endRadius: 200.0,
            duration: const Duration(milliseconds: 5000),
            repeat: true,
            showTwoGlows: false,
            child: AvatarGlow(
              glowColor: pulseColor,
              endRadius: 200.0,
              duration: const Duration(milliseconds: 6000),
              repeat: true,
              showTwoGlows: false,
              child: AvatarGlow(
                glowColor: pulseColor,
                endRadius: 200.0,
                duration: const Duration(milliseconds: 7000),
                repeat: true,
                showTwoGlows: false,
                child: AvatarGlow(
                  glowColor: pulseColor,
                  endRadius: 200.0,
                  duration: const Duration(milliseconds: 8000),
                  repeat: true,
                  showTwoGlows: false,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
