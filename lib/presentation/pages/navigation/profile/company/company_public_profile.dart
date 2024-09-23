import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post_video_feed.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/company/company_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/profile/appbar/profile_appbar.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/sections/company/sections/company_header_section_V2.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/sections/company/sections/company_tab_section.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/sections/company/subpages/company_info_page.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../../../core/resources/color_constants.dart';

class CompanyPublicProfile extends StatelessWidget {
  final CompanyOnboarding companyOnboarding;


  final VoidCallback? onBack;

  const CompanyPublicProfile(
      {super.key,
      this.onBack,
      required this.companyOnboarding,
   });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ColorConstant.shade00,
        appBar: ProfileAppBar(
          onPop: onBack,
          username: companyOnboarding.userName,
          title: companyOnboarding.companyName,
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
                    CompanyHeaderSectionV2(
                      isPreview: true,
                      companyLogo: companyOnboarding.companyLogo,
                      followingCount: '394',
                      followersCount: '394',
                      likeCount: '394',
                      location: companyOnboarding.location,
                      about: companyOnboarding.about,
                      onTapInfo: () {
                        context.navigator.push(MaterialPageRoute(
                            builder: (_) => CompanyInfoPage(
                                  username: companyOnboarding.userName,
                                  companyName: companyOnboarding.companyName,
                                  companyLogo: companyOnboarding.companyLogo,
                                  about: companyOnboarding.about,
                                  location: companyOnboarding.location,
                                  website: companyOnboarding.website,
                                  ourServices: '',
                                  industry: [companyOnboarding.industry],
                                  language: [],
                                  benefits: companyOnboarding.benefits,
                                )));
                      },
                      onTapFollow: () {},
                      onTapMessage: () {},
                    ),
                  ],
                ),
              )
            ];
          },
          body: BlocProvider<CompanyEditorBloc>(
              create: (_) => CompanyEditorBloc(
                  companyOnboarding: companyOnboarding,
                  companyJobPosts: [],
                  companyJobPostVideoFeed: []),
              child: const CompanyTabSection()),
        ),
      ),
    );
  }
}
