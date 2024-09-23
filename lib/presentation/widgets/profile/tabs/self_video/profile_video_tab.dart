import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/candidate/profile/candidate_profile_repository.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_state.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/tabs/self_video/self_video_player_screen.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/svg/svg_asset.dart';

class ProfileVideoTab extends StatelessWidget {
  final List<CandidateVideoFeed> candidateVideoFeed ;
  final CandidateOnBoarding candidateOnBoarding ;
  const ProfileVideoTab({super.key,
    required this.candidateVideoFeed,
    required this.candidateOnBoarding});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final thumbnailWidth = (screenWidth - 35) / 3.3;
    debugPrint('$thumbnailWidth'); // 32 accounts for padding and spacing

    return  ( candidateVideoFeed.isEmpty) ? const NoPostPage() :Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(
                candidateVideoFeed.length  ,  (index) {

              return GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => SelfVideoPlayerScreen(index: index, candidateVideoFeed:  candidateVideoFeed, candidateOnBoarding:  candidateOnBoarding,),
                    ));
                  },
                  child: VideoThumbnail(candidateVideoFeed:  candidateVideoFeed , index: index, width: thumbnailWidth));
            }),
          ),
        );
  }
}

class VideoThumbnail extends StatelessWidget {
  final List<CandidateVideoFeed> candidateVideoFeed ;
  final int index;
  final double width;

  const VideoThumbnail({
    required this.candidateVideoFeed ,
    required this.index, required this.width});

  @override
  Widget build(BuildContext context) {
    debugPrint("The thumbnail url is :: ${candidateVideoFeed[index].thumbnailUrl}") ;
    return Container(
      width: width ,
      height: width,
      color: Colors.grey[300],
      child: Stack(
        children: [
          Image.network(
             candidateVideoFeed[index].thumbnailUrl ,
            width: width,
            height: width,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 4,
            left: 4,
            child: Row(
              children: [
                Icon(Icons.play_arrow, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(
                  '${index * 100 + 100}', // Example play count
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NoPostPage extends StatelessWidget {
  const NoPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorConstant.neutral50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SvgAsset(asset: AssetConstant.camera2Icon  , width: 100, height: 100,) ,
          Text(TranslationKeys.noPostYet , style: BaseTextStyle(
              color: ColorConstant.neutral700,
              fontWeight: FontWeight.w400,
              fontSize: TypographyTheme.paragraph_p3),)
        ],
      ),
    );
  }
}

