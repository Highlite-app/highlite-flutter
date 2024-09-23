import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';

import '../../../core/constants/mocked_image.dart';
import '../../../data/models/apis/dashboard/company/home/company_job_feed.dart';
import '../buttons/rippler.dart';
import '../tiles/playback/playback_tile.dart';

class JobPostTile extends StatelessWidget {
  final CompanyJobPost? jobPost;
  final CompanyJobFeed? jobFeed;
  final bool isFromOwnProfile;

  const JobPostTile({
    super.key,
    this.jobPost,
    this.jobFeed,
    this.isFromOwnProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isFromOwnProfile && jobFeed != null) {
      return Rippler(
        onTap: () {
          // globalNavKey.currentState?.push(CompanyPreviewVideoFeed.previewRoute,
          //     extra: jobFeed!.jobVideoFeed.playbackId);
        },
        child: PlaybackTile(
          image: jobFeed!?.assetId ?? "",
          title: "Hiring: ${jobFeed!.companyJobPost.position}",
          jobLocation: jobFeed!.companyJobPost.workType,
          salary: "\$${jobFeed!.companyJobPost.salary}/hr",
        ),
      );
    }
    // return CompanyEditorBuilderWidget(builder: (context, state) {
    //   List<HighliteCompanyJobPostVideoFeed> videoJobPosts =
    //       state.companyJobPostVideoFeed;
    //   HighliteCompanyJobPostVideoFeed item = videoJobPosts
    //       .firstWhere((item) => item.id == jobPost!.jobVideoFeedID);
    //   final thumbnail =
    //       "https://image.mux.com/${item.playbackId}/thumbnail.jpg?time=0&fit_mode=preserve";
    final jobPostVideoFeed = authService.companyJobPostVideoFeed != null
        ? authService.companyJobPostVideoFeed!
            .firstWhere((element) => element.jobVideoFeedId == jobPost!.jobVideoFeedId)
        : null;
    if (jobPostVideoFeed == null) {
      return Container();
    }
    return Rippler(
      onTap: () {
// GenericPreviewVideoFeedState videoFeed = GenericPreviewVideoFeedState(
// title: jobPost!.title,
// name: authService.companyProfile?.companyName,
// location:
//     "${authService.companyProfile?.city}, ${authService.companyProfile?.country}",
// // "${state.companyProfile.city}, ${state.companyProfile.country}",
// salary: "${jobPost!.salary}/hr",
// jobFlexibility: jobPost!.jobFlexibility,
// playbackId: authService.companyJobPostVideoFeed
//     ?.firstWhere((element) => element.id == jobPost!.jobVideoFeedID)
//     .playbackId,
// isHiring: true,
// tools: jobPost!.tools,
// );
// globalNavKey.currentState?.push(GenericPreviewVideoFeed.previewRoute, extra: videoFeed);
      },
      child: PlaybackTile(
        image: jobPostVideoFeed.playbackId.isNotEmpty
            ? "https://image.mux.com/${authService.companyJobPostVideoFeed!.firstWhere((element) => element.jobVideoFeedId == jobPost!.jobVideoFeedId).playbackId}/thumbnail.jpg?time=0&fit_mode=preserve"
            : MockedImage.mockedCompanyJobPost,
        title: "Hiring: ${jobPost!.position}",
        jobLocation: jobPost!.workType,
        salary: "\$${jobPost!.salary}/hr",
      ),
    );
  }
}
