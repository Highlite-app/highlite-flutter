import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/company/company_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/company/company_editor_state.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/profile/candidate/edit_profile/profile_editor_page.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/edit_profile/sections/company/company_info_section.dart';
class EditCompanyProfile extends StatelessWidget {
  const EditCompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyEditorBloc , CompanyEditorState>(
      builder: (context , state) {

        final companyProfile = state.companyProfile ;
        return ProfileEditorPage(children: [

          CompanyInfoSection(
              username: companyProfile.userName,
              companyName: companyProfile.companyName,
              industry: companyProfile.industry,
              companySize:companyProfile.companySize ,
              website: companyProfile.website,
              location: companyProfile.location,
              aboutCompany: companyProfile.about,
              benefits: companyProfile.benefits,
          )

        ]);
      }
    );
  }
}
