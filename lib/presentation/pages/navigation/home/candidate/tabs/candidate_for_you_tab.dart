import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/data/models/services/mux/mux_asset.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/for_you/candidate_for_you_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/for_you/candidate_for_you_state.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/profile/company/company_public_profile.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../app.dart';
import '../../../../../../core/resources/asset_constants.dart';
import '../../../../../../core/resources/color_constants.dart';
import '../../../../../bloc/center_prompt/center_prompt_builder.dart';
import '../../../../../bloc/center_prompt/center_prompt_event.dart';
import '../../../../../bloc/dashboard/auth/authentication_bloc.dart';
import '../../../../../bloc/dashboard/auth/authentication_state.dart';
import '../../../../../bloc/dashboard/home/candidate/for_you/candidate_for_you_event.dart';
import '../../../../../bloc/toast/toast_bloc.dart';
import '../../../../../bloc/toast/toast_event.dart';
import '../../../../../widgets/empty_feed/empty_feed.dart';
import '../../../../../widgets/overlay/super_message/super_message_sender.dart';
import '../../../../../widgets/toaster/toast_alert.dart';
import '../../../../../widgets/video_feed/video_feed_item.dart';

class CandidateForYou extends StatefulWidget  {
  const CandidateForYou({super.key});


  @override
  State<CandidateForYou> createState() => _CandidateForYouState();
}

class _CandidateForYouState extends State<CandidateForYou> {

  bool isSuperMessaged = false;

  bool isBookmerked = false;

  bool isLiked = false;

  bool isdisliked = false;

  MuxAsset? muxResponse;


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

        return BlocBuilder<CandidateForYouBloc, CandidateForYouState>(
          builder: (context, state) {
            if (state.controller.isEmpty) {
              return EmptyFeedPage(
                profile: authState.candidate?.profilePicture ?? '',
                emptyDesc: "Finding Best Job For You ",
              );
            }
            if (state.controller.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                state.pageController.jumpToPage(state.lastPlayedForYouIndex);
              });
              return PageView.builder(
                  controller: state.pageController,
                  itemCount: state.forYouFeed.length,
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (page) {
                    context
                        .read<CandidateForYouBloc>()
                        .add(PageChangedEvent( page));
                  },
                  itemBuilder: (context, index) {

                    print("The controller in for You :: ${state.controller[index]}");
                      return GestureDetector(
                        child: VideoFeedItem(
                            controller: state.controller[index]!,
                            imageProvider: state.thumbnail[index]!,
                            contents: VideoFeedContents(
                                hiringTag: true,
                                title: state
                                    .forYouFeed[index].companyJobPost.position,
                                name: state.forYouFeed[index].companyOnboarding
                                    .companyName,
                                location:
                                    "${state.forYouFeed[index].companyOnboarding.city}, ${state.forYouFeed[index].companyOnboarding.country}",
                                salary:
                                    "${state.forYouFeed[index].companyJobPost.salary}/hr",
                                jobFlexibility: state
                                    .forYouFeed[index].companyJobPost.workType,
                                skills: state
                                    .forYouFeed[index].companyJobPost.skills,
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
                              if (state.controller[index]!.value.isPlaying) {
                                state.controller[index]!.pause();
                              }
                              globalNavKey.currentState!.push(MaterialPageRoute(
                                  builder: (context) => CompanyPublicProfile(
                                    onBack: (){
                                      state.controller[state.lastPlayedForYouIndex]!.play() ;
                                    },

                                    companyOnboarding: state.forYouFeed[index].companyOnboarding,)));


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
              profile: authState.candidate?.profilePicture ?? '',
              emptyDesc: "Finding Best Job For You ",
            );
          },
        );
      },
    );
  }
}
