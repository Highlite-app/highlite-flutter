import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/company/company_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/company/company_editor_state.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/edit_profile/flows/company/edit_company_profile_benefits.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/edit_profile/flows/company/edit_company_profile_companySize.dart';

import '../../flows/company/edit_company_profile_about.dart';
import '../../flows/company/edit_company_profile_companyname.dart';
import '../../flows/company/edit_company_profile_location.dart';
import '../../flows/company/edit_company_profile_username.dart';
import '../../flows/company/edit_company_profile_website.dart';
import '../../sub_section/edit_profile_list_section.dart';
import '../../sub_section/edit_profile_navigate_tile.dart';

class CompanyInfoSection extends StatelessWidget {
  final String username;
  final String companyName;
  final String industry;
  final String companySize  ;
  final String website;
  final String location;
  final String aboutCompany;
  final String? companyLogo;
  final List<String> benefits ;

  const CompanyInfoSection({
    super.key,
    required this.username,
    required this.companyName,
    required this.industry,
    required this.companySize ,
    required this.website,
    required this.location,
    required this.aboutCompany,
    this.companyLogo,
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyEditorBloc, CompanyEditorState>(
      builder: (ctx, state) => EditProfileListSection(
        navigations: [
          NavigatedEditProfileForm<CompanyOnboarding>(
            title: TranslationKeys.username,
            value: username,
            data: state.companyProfile,
            form: EditProfileByCompanyUsername(
              TextEditingController(text: ""),
            ),
          ),
          NavigatedEditProfileForm<CompanyOnboarding>(
            title: TranslationKeys.companyName,
            value: companyName,
            data: state.companyProfile,
            form: EditCompanyProfileCompanyName(
              TextEditingController(text: ""),
            ),
          ),
          NavigatedEditProfileForm<CompanyOnboarding>(
            title: TranslationKeys.companySize,
            value: companySize,
            data: state.companyProfile,
            form: EditCompanyProfileCompanySize(
              TextEditingController(text: ""),
            ),
          ),
          NavigatedEditProfileForm<CompanyOnboarding>(
            title: TranslationKeys.location,
            value: location,
            data: state.companyProfile,
            form: EditProfileByCompanyLocation(
              TextEditingController(text: ""),
              TextEditingController(text: ""),
            ),
          ),
          NavigatedEditProfileForm<CompanyOnboarding>(
            title: TranslationKeys.about,
            value: aboutCompany,
            data: state.companyProfile,
            form: EditCompanyProfileAbout(
              TextEditingController(text: ""),
            ),
          ),
          NavigatedEditProfileForm<CompanyOnboarding>(
            title: TranslationKeys.website,
            value: website,
            data: state.companyProfile,
            form: EditCompanyProfileWebsite(
              TextEditingController(text: ""),
            ),
          ),
          NavigatedEditProfileForm<CompanyOnboarding>(
            title: TranslationKeys.editCompanyBenefits,
            data: state.companyProfile,
            bordered: false,
            form: EditCompanyProfileBenefits(
                companyBenefits: state.companyProfile.benefits),
          ),
        ],
      ),
    );
  }
}
