import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/bookmark/bookmark_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/bookmark/bookmark_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/bookmark/bookmark_state.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_state.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/navigation/base_navigator.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/sections/candidate/candidate_tab_section.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../widgets/profile/sections/candidate/candidate_header_section_v2.dart';
import '../../upload /candidate/resume /upload _resume.dart';
import '../appbar/profile_appbar.dart';
import 'edit_profile/edit_candidate_profile.dart';

class CandidateProfileV2 extends StatelessWidget {
  final CandidateOnBoarding candidateOnBoarding ;
   CandidateProfileV2({super.key, required this.candidateOnBoarding})   ;

  String message = "Checking Firebase Storage...";

  String profileUrl = '';

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        //   var persitent =  await persistenceService.get() ;
        //
        // authentication.add(AuthenticateOnboardingEvent(persitent?.id ??'', persitent?.userType ?? '')) ;
      },
      child:
      BaseNavigator(builder: (navKey) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: ColorConstant.shade00,
              appBar: ProfileAppBar(
                username: candidateOnBoarding.username ?? '',
                title: candidateOnBoarding.fullName,
                navigator: context.navigator,
                isPreview: false,
                selectedProfileId: "",
              ),
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          CandidateHeaderSectionV2(
                            followingCount: '0',
                            profileUrl:
                                candidateOnBoarding.profilePicture ??
                                    '',
                            followersCount: '0',
                            onChangeProfilePicture: () async {
                              context
                                  .read<CandidateEditorBloc>()
                                  .add(const ChangeProfilePictureEvent());
                            },
                            likeCount: '0',
                            location:
                                candidateOnBoarding.location ?? '',
                            about: candidateOnBoarding.about ?? '',
                            onTapEditProfile: () {
                              navKey.currentState!.push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const EditCandidateProfile(),
                                ),
                              );
                            },
                            onTapShareProfile: () {
                              Share.share("Conner from Highlite",
                                      subject: "highlite.app")
                                  .then((value) {});
                            },
                            onTapProfile: () {
                              navKey.currentState?.push(MaterialPageRoute(
                                  builder: (_) => const UploadResume()));
                            },
                          ),
                        ],
                      ),
                    )
                  ];
                },
                body: BlocProvider<BookmarkBloc>(
                  create: (context)=> BookmarkBloc()..add(GetBookmarkEvent()),
                  child: BlocBuilder<BookmarkBloc ,BookmarkState>(
                    builder: (context , bookmarkState ) {
                      return BlocBuilder<CandidateEditorBloc , CandidateEditorState>(
                        builder: (context , profileState) {
                          return CandidateTabSection(
                              candidateFeed: profileState.candidateVideFeed ,
                              candidateOnBoarding: candidateOnBoarding ??
                                  CandidateOnBoarding.defaultOnboarding(),
                                bookmarkCollection: bookmarkState.bookmarkCollection,);
                        }
                      );
                    }
                  ),
                ),
              ),
            ),
          );
      }),
    );
  }
}
