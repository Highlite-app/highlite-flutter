import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';


import '../toaster/toast_container.dart';
import 'indicator_contents.dart';

class UploadIndicator extends StatefulWidget {
  final bool isUploadingProfile;
  final double progressProfile;
  final int millisProfile;
  final bool isUploadingVideo;
  final double progressVideo;
  final int millisVideo;
  const UploadIndicator({
    super.key,
    required this.isUploadingProfile,
    required this.progressProfile,
    required this.millisProfile,
    required this.isUploadingVideo,
    required this.progressVideo,
    required this.millisVideo,
  });

  @override
  State<UploadIndicator> createState() => _UploadIndicatorState();
}

class _UploadIndicatorState extends State<UploadIndicator>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _offsetAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -300.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticIn,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToastContainer(
      visible: true,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          children: [
            SizedBox(
              height: widget.isUploadingProfile && widget.isUploadingVideo
                  ? 8.0
                  : 8.0,
            ),
            if (widget.isUploadingProfile)
              IndicatorContents(
                placeholder: widget.progressProfile == 100
                    ? (TranslationKeys.uploadProfileCompleted)
                    : (TranslationKeys.uploadingProfile),
                progress: widget.progressProfile,
                millis: widget.millisProfile,
                onClose: () {
                 // context.read<UploaderBloc>().add(const CloseEvent("profile"));
                },
              ),
            const SizedBox(
              height: 8.0,
            ),
            if (widget.isUploadingProfile && widget.isUploadingVideo)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(height: 1),
              ),
            if (widget.isUploadingProfile && widget.isUploadingVideo)
              const SizedBox(
                height: 4.0,
              ),
            if (widget.isUploadingVideo)
              IndicatorContents(
                placeholder: widget.progressVideo == 100
                    ? (TranslationKeys.uploadVideoCompleted)
                    : (TranslationKeys.uploadingVideo),
                progress: widget.progressVideo,
                millis: widget.millisVideo,
                onClose: () {
                //  context.read<UploaderBloc>().add(const CloseEvent("video"));
                },
              ),
          ],
        ),
      ),
      offsetAnimation: _offsetAnimation,
    );
  }
}
