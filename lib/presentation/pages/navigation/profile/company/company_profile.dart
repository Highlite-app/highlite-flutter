import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_state.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/company/company_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/profile/company/edit_profile/edit_company_profile.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/sections/company/sections/company_tab_section.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../../../core/constants/mocked_image.dart';
import '../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../domain/repositories/dashboard/common/feed_service/home_feed_state_repository.dart';
import '../../../../bloc/dashboard/profile/company/company_editor_event.dart';
import '../../../../bloc/dashboard/profile/company/public_profile/public_company_profile_bloc.dart';
import '../../../../bloc/dashboard/profile/company/public_profile/public_company_profile_builder.dart';
import '../../../../bloc/dashboard/profile/company/public_profile/public_company_profile_event.dart';
import '../../../../widgets/gallery/generic_grid.dart';
import '../../../../widgets/modal/multiple_selection_modal.dart';
import '../../../../widgets/navigation/base_navigator.dart';
import '../../../../widgets/overlay/super_message/super_message_sender.dart';
import '../../../../widgets/profile/job_post_tile.dart';
import '../../../../widgets/profile/profile_section_spacer.dart';
import '../../../../widgets/profile/sections/company/sections/company_about_section.dart';
import '../../../../widgets/profile/sections/company/sections/company_general_section.dart';
import '../../../../widgets/profile/sections/company/sections/company_header_section.dart';
import '../../../../widgets/profile/sections/company/sections/company_header_section_V2.dart';
import '../appbar/profile_appbar.dart';
import '../default/profile_hero_section.dart';

class CompanyProfile extends StatelessWidget {
  final CompanyOnboarding companyProfile;
  final List<CompanyJobPost> jobPosts;

  const CompanyProfile({
    super.key,
    required this.companyProfile,
    required this.jobPosts,
  });

  @override
  Widget build(BuildContext context) {
    return BaseNavigator(
      builder: (navKey) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: ProfileAppBar(
            title: companyProfile.companyName,
            username: companyProfile.userName,
            navigator: context.navigator,
            isPreview: false,
            selectedProfileId: companyProfile.companyId,
          ),
          backgroundColor: ColorConstant.shade00,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: CompanyHeaderSectionV2(
                    onChangeProfilePicture: (){
                      context.read<CompanyEditorBloc>().add(ChangeCompanyProfilePictureEvent()) ;
                    },
                    companyLogo: companyProfile.companyLogo,
                    about: companyProfile.about,
                    followingCount: "0",
                    onTapEditProfile: () {
                      navKey.currentState?.push(MaterialPageRoute(builder: (_)=> EditCompanyProfile())) ;
                    },
                    followersCount: '0',
                    likeCount: '0',
                    location:
                        "${companyProfile.city} ${companyProfile.country}",
                  ),
                ),
              ];
            },
            body: const CompanyTabSection(),
          ),
        ),
      ),
    );
  }
}
