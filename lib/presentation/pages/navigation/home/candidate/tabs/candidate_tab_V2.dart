import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate/candidate_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate/candidate_state.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/profile/candidate/public_profile/candidate_public_video.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/overlay/bookmark/select_bookmark_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../app.dart';
import '../../../../../../core/resources/asset_constants.dart';
import '../../../../../../core/resources/color_constants.dart';
import '../../../../../bloc/center_prompt/center_prompt_builder.dart';
import '../../../../../bloc/center_prompt/center_prompt_event.dart';
import '../../../../../bloc/dashboard/auth/authentication_bloc.dart';
import '../../../../../bloc/dashboard/auth/authentication_state.dart';
import '../../../../../bloc/dashboard/home/candidate/candidate/candidate_event.dart';
import '../../../../../bloc/toast/toast_bloc.dart';
import '../../../../../bloc/toast/toast_event.dart';
import '../../../../../widgets/empty_feed/empty_feed.dart';
import '../../../../../widgets/overlay/super_message/super_message_sender.dart';
import '../../../../../widgets/toaster/toast_alert.dart';
import '../../../../../widgets/video_feed/video_feed_item.dart';

class CandidateTabsV2 extends StatefulWidget with WidgetsBindingObserver {
  CandidateTabsV2({super.key}) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  State<CandidateTabsV2> createState() => _CandidateTabsV2State();
}

class _CandidateTabsV2State extends State<CandidateTabsV2> {
  bool isSuperMessaged = false;

  bool isLiked = false;

  bool isdisliked = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        if (authState.candidate == null) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              size: 50,
              color: ColorConstant.shade00,
            ),
          );
        }

        return BlocBuilder<CandidateBloc, CandidateState>(
          builder: (context, state) {
            if (state.controller.isEmpty) {
              return const EmptyFeedPage(
                profile: "",
                emptyDesc: "Finding Best Job For You ",
              );
            }
            if (state.controller.isNotEmpty) {
              return PageView.builder(
                  itemCount: state.candidateFeed.length,
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (page) {
                    context.read<CandidateBloc>().add(PageChangedEvent(page));
                  },
                  itemBuilder: (context, index) {
                    print(
                        "The controller in Candidate Tab :: ${state.controller[state.candidateFeed[index].playbackId]}");
                    return GestureDetector(
                        child: VideoFeedItem(
                            controller: state.controller[
                                state.candidateFeed[index].playbackId]!,
                            imageProvider: state.thumbnail[
                                state.candidateFeed[index].playbackId]!,
                            contents: VideoFeedContents(
                                title: state.candidateFeed[index].candidateOnBoarding?.position ??
                                    '',
                                name: state.candidateFeed[index]
                                    .candidateOnBoarding?.fullName ?? '',
                                location: state.candidateFeed[index]
                                    .candidateOnBoarding?.location ?? '',
                                salary:
                                    "${state.candidateFeed[index].candidateOnBoarding?.salary}/hr",
                                jobFlexibility:
                                    state.candidateFeed[index].candidateOnBoarding?.workType ??
                                        '',
                                skills: state.candidateFeed[index].candidateOnBoarding?.skills ??
                                    [],
                                profile: state.candidateFeed[index].candidateOnBoarding?.profilePicture ??
                                    ''),
                            state: VideoFeedContentState(
                                isFollowing: false,
                                enabledFollowButton: true,
                                enabledActionButtons: true,
                                isSuperMessaged: isSuperMessaged,
                                isBookmarked: state.bookmarkInfo.where((element) => element.referenceId == state.candidateFeed[index].candidateVideoFeedId).isNotEmpty,
                                isLiked: isLiked,
                                isDisliked: isdisliked,
                                isShared: false),
                            onTapProfile: () async {
                              if (state
                                  .controller[
                                      state.candidateFeed[index].playbackId]!
                                  .value
                                  .isPlaying) {
                                state.controller[
                                        state.candidateFeed[index].playbackId]!
                                    .pause();
                              }
                              globalNavKey.currentState!.push(MaterialPageRoute(
                                  builder: (_) => CandidatePublicProfile(
                                        onBack: () {
                                          state.controller[state
                                                  .candidateFeed[index]
                                                  .playbackId]!
                                              .play();
                                        },
                                        candidateFeed:
                                            state.candidateFeed[index],
                                      )));
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
                            onBookmarkTap: () async {
                              if (state.bookmarkInfo
                                  .where((element) =>
                              element.referenceId ==
                                  state.candidateFeed[index]
                                      .candidateVideoFeedId)
                                  .isNotEmpty) {} else {
                                await SelectBookmarkOverlay
                                    .showBookmarkSelectionByUserId(
                                    candidateId: state
                                        .candidateFeed[index].candidateId,
                                    videoFeedId: state.candidateFeed[index]
                                        .candidateVideoFeedId,
                                    context: context).then((value) {
                                  context.read<CandidateBloc>().add(
                                      RetrieveBookmark());
                                  if(value == true){
                                    centerPrompt.add(
                                       ShowPromptEvent(
                                          asset: AssetConstant.bookmarkIconSelectedV2),
                                    );
                                  }
                                });
                              }
                            } ,
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
            return const EmptyFeedPage(
              profile: "",
              emptyDesc: "Finding Best Job For You ",
            );
          },
        );
      },
    );
  }
}
