import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_state.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/company/company_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/company/company_editor_state.dart';

import 'company_profile.dart';

class SelfCompanyProfile extends StatelessWidget {
  const SelfCompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authState) {
      return BlocProvider<CompanyEditorBloc>(
        create: (_) => CompanyEditorBloc(
          companyOnboarding: authState.companyProfile ?? CompanyOnboarding.getDefault(),
          companyJobPosts: [],
          companyJobPostVideoFeed: [],
        ),
        child: BlocBuilder<CompanyEditorBloc, CompanyEditorState>(
            builder: (context, state) {
          return CompanyProfile(
              companyProfile: state.companyProfile, jobPosts: []);
        }),
      );
    });
  }
}
