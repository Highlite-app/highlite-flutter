import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';
import 'package:highlite_flutter_mvp/data/models/services/mux/mux_asset.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate_home_feed_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate_home_feed_state.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import '../../../../../../core/resources/asset_constants.dart';
import '../../../../../../core/resources/color_constants.dart';
import '../../../../../../core/services/mux_video_client.dart';
import '../../../../../bloc/center_prompt/center_prompt_builder.dart';
import '../../../../../bloc/center_prompt/center_prompt_event.dart';
import '../../../../../bloc/dashboard/auth/authentication_bloc.dart';
import '../../../../../bloc/dashboard/auth/authentication_state.dart';
import '../../../../../bloc/dashboard/home/candidate/candidate_home_feed_event.dart';
import '../../../../../bloc/toast/toast_bloc.dart';
import '../../../../../bloc/toast/toast_event.dart';
import '../../../../../widgets/empty_feed/empty_feed.dart';
import '../../../../../widgets/overlay/super_message/super_message_sender.dart';
import '../../../../../widgets/toaster/toast_alert.dart';
import '../../../../../widgets/utils/logger.dart';
import '../../../../../widgets/utils/video_player_utils.dart';
import '../../../../../widgets/video_feed/video_feed_item.dart';

class CandidateJobsV2 extends StatefulWidget with WidgetsBindingObserver {
  CandidateJobsV2({super.key}) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  State<CandidateJobsV2> createState() => _CandidateJobsV2State();
}

class _CandidateJobsV2State extends State<CandidateJobsV2> {

  bool isSuperMessaged = false;

  bool isBookmerked = false;

  bool isLiked = false;

  bool isdisliked = false;







  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        print("The authState :: ${authState.candidate}") ;
        if (authState.candidate == null) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              size: 50,
              color: ColorConstant.shade00,
            ),
          );
        }

        return BlocBuilder<CandidateHomeFeedBloc , CandidateHomeFeedState>(
          builder: (context, state) {
            //   debugPrint("The muxAssetIns${state.muxAsset?.data?.first.playbackIds?.first.id}");
            //  debugPrint("The salary is ::${state.jobFeeds.first.salary}");
            debugPrint("The controller is ");
            if (state.videoPlayerController!.isEmpty) {
              return const EmptyFeedPage(
                profile: "",
                emptyDesc: "Finding Best Job For You ",
              );
            }
            if (state.videoPlayerController!.isNotEmpty) {
              return PageView.builder(
                  controller: state.pageController,
                  itemCount: state.jobFeeds.length,
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (page) {
                    context
                        .read<CandidateHomeFeedBloc>().add(NavigateCandidateHomeFeedEvent(pageNumber: page));
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        child: VideoFeedItem(
                            controller: state.videoPlayerController![index],
                            imageProvider: NetworkImage(""),
                            contents: VideoFeedContents(
                                hiringTag: true,
                                title: state.jobFeeds[index].companyJobPost.position,
                                name: state
                                    .jobFeeds[index].companyOnboarding.companyName,
                                location:
                                    "${state.jobFeeds[index].companyOnboarding.city}, ${state.jobFeeds[index].companyOnboarding.country}",
                                salary: "${state.jobFeeds[index].companyJobPost.salary}/hr",
                                jobFlexibility:
                                    state.jobFeeds[index].companyJobPost.workType,
                                skills: state.jobFeeds[index].companyJobPost.skills,
                                profile: ""),
                            state: VideoFeedContentState(
                                isFollowing: false,
                                enabledFollowButton: true,
                                enabledActionButtons: true,
                                isSuperMessaged: isSuperMessaged,
                                isBookmarked: isBookmerked,
                                isLiked: isLiked,
                                isDisliked: isdisliked,
                                isShared: false),
                            onTapProfile: () async {
                              // globalNavKey.currentState!.push(MaterialPageRoute(
                              //     builder: (_) =>
                              //         CompanyProfile(
                              //         isPreview: true,
                              //         companyProfile: state.jobFeeds[index].companyProfile,
                              //         jobPosts: jobPosts)));
                            },
                            onFollowTap: () {},
                            onSuperMessageTap: () {
                              SuperMessageSenderOverlay.showSuperMessage([])
                                  .then((sendResponse) {
                                setState(() {
                                  centerPrompt.add(
                                    const ShowPromptEvent(
                                        asset:
                                            AssetConstant.lightingSelectedIcon),
                                  );
                                  isSuperMessaged = !isSuperMessaged;
                                });

                                toaster.add(
                                  const ShowToastEvent(
                                    text:
                                        "Your super message has been sent successfully.",
                                    icon: AssetConstant.checkCircleIcon,
                                    state: ToastState.normal,
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              });
                            },
                            onBookmarkTap: () {
                              //    TODO: WE ADD MY SELECT BOOKMARK OVERLAY 2
                            },
                            onLike: () {
                              setState(() {
                                centerPrompt.add(
                                  const ShowPromptEvent(
                                      asset: AssetConstant.likeSelectedIcon),
                                );
                                isLiked = !isLiked;
                                isdisliked = false;
                              });
                            },
                            onDislike: () {
                              setState(() {
                                centerPrompt.add(
                                  const ShowPromptEvent(
                                      asset: AssetConstant.dislikeSelectedIcon),
                                );
                                isLiked = false;
                                isdisliked = !isdisliked;
                              });
                            },
                            onShare: () {
                              Share.share("Conner from Highlite",
                                      subject: "highlite.app")
                                  .then((value) {});

                              Future.delayed(const Duration(seconds: 2), () {
                                centerPrompt.add(
                                  const ShowPromptEvent(
                                      asset: AssetConstant.sharedIcon),
                                );
                              });
                            }));
                  });
            }
            return EmptyFeedPage(
              profile: "",
              emptyDesc: "Finding Best Job For You ",
            );
          },
        );
      },
    );
  }
}
