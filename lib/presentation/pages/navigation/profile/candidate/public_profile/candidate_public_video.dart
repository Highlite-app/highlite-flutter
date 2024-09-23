import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/profile/appbar/profile_appbar.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/sections/candidate/public_profile/candidate_resume.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../../../../app.dart';
import '../../../../../../core/resources/color_constants.dart';
import '../../../../../../data/models/apis/dashboard/cadidate/home/candidate_feed.dart';
import '../../../../../widgets/profile/sections/candidate/candidate_tab_section.dart';
import 'candidate_header_public_profile.dart';

class CandidatePublicProfile extends StatelessWidget {
  final CandidateFeed candidateFeed;
  final VoidCallback? onBack;

  const CandidatePublicProfile({
    super.key,
    this.onBack,
    required this.candidateFeed,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ColorConstant.shade00,
        appBar: ProfileAppBar(
          onPop: onBack,
          username: candidateFeed.candidateOnBoarding?.username ?? '',
          title: candidateFeed.candidateOnBoarding?.fullName,
          navigator: context.navigator,
          isPreview: true,
          selectedProfileId: "",
          isProfileBookmark: false,
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CandidatePublicProfileHeader(
                      profileUrl:
                          candidateFeed.candidateOnBoarding?.profilePicture ??
                              '',
                      followingCount: '0',
                      followersCount: '0',
                      likeCount: '0',
                      location:
                          candidateFeed.candidateOnBoarding?.location ?? '',
                      about: candidateFeed.candidateOnBoarding?.about ?? '',
                      onTapResume: () {
                        globalNavKey.currentState!.push(MaterialPageRoute(
                            builder: (_) => CandidateResume(
                                  username: candidateFeed
                                          .candidateOnBoarding?.username ??
                                      '',
                                  candidateName: candidateFeed
                                          .candidateOnBoarding?.fullName ??
                                      '',
                                  profilePicture: candidateFeed
                                          .candidateOnBoarding
                                          ?.profilePicture ??
                                      '',
                                  about: candidateFeed
                                          .candidateOnBoarding?.about ??
                                      '',
                                  location: candidateFeed
                                          .candidateOnBoarding?.location ??
                                      '',
                                  skills: candidateFeed
                                          .candidateOnBoarding?.skills ??
                                      [],
                                  tools: candidateFeed
                                          .candidateOnBoarding?.tools ??
                                      [],
                                  languages:
                                      candidateFeed.aboutCandidate?.languages ??
                                          [],
                                  salary: candidateFeed
                                          .candidateOnBoarding?.salary ??
                                      '',
                                  candidateEducation:
                                      candidateFeed.candidateEducation ?? [],
                                  candidateEmployment:
                                      candidateFeed.candidateEmployment ?? [],
                                  candidateProject:
                                      candidateFeed.candidateProject ?? [],
                                )));
                      },
                      onTapMessage: () {},
                      onTapFollow: () {},
                    )
                  ],
                ),
              )
            ];
          },
          body: BlocProvider<CandidateEditorBloc>(
              create: (_) => CandidateEditorBloc(
                  videoFeed: [], candidate: candidateFeed.candidateOnBoarding),
              child: CandidateTabSection(
                candidateFeed: [],
                candidateOnBoarding: candidateFeed.candidateOnBoarding ??
                    CandidateOnBoarding.defaultOnboarding(),
                bookmarkCollection: [],
              )),
        ),
      ),
    );
  }
}
