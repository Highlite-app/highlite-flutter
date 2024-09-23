
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/search/candidate/candidate_search_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/search/candidate/candidate_search_state.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/search/candidate/selected_filtered_view.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../../../data/models/apis/dashboard/company/upload/company_job_post.dart';
import '../../../../../data/models/apis/onboarding/company/company_onboarding.dart';
import '../../../../widgets/search/sections/search_card.dart';
import '../../profile/company/company_public_profile.dart';
class CurrentSearchPage extends StatelessWidget {
  const CurrentSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return   BlocBuilder<CandidateSearchBloc , CandidateSearchState>(
      builder: (context , state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              if (state.selectedFilteredItem.isNotEmpty)
                SelectedFiltered(selectedFilters: state.selectedFilteredItem),
              Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.filteredCompanyJobPost?.length ?? 0,
                      itemBuilder: (context, index) {
                        var jobPostMap = state.mappedFilteredJobPosts?[index];
                        var companyJobPost =
                        jobPostMap?['jobPost'] as CompanyJobPost?;
                        var companyOnboarding =
                        jobPostMap?['companyOnboarding']
                        as CompanyOnboarding?;

                        return GestureDetector(
                          onTap: (){
                            context.navigator.push(MaterialPageRoute(builder: (_)=> CompanyPublicProfile(
                              companyOnboarding: companyOnboarding!)));
                          },
                          child: SearchCard(
                            title: companyOnboarding?.companyName ?? '',
                            jobRole: companyJobPost?.position ?? '',
                            location: state.companyOnboarding?[index].location ?? '',
                            skills: companyJobPost?.skills ?? [],
                            tools: companyJobPost?.tools ?? [],
                            jobDuration: companyJobPost?.jobDuration ?? '',
                            workType: companyJobPost?.workType ?? '',
                            salary: companyJobPost?.salary ?? '',
                            imageUrl: '',
                            selectedTools: state.selectedFilteredItem.isNotEmpty
                                ? state.selectedTools
                                : [],
                            selectedSkills:
                            state.selectedFilteredItem.isNotEmpty
                                ? state.selectedSkills
                                : [],
                            onTapBookmark: () {},
                          ),
                        );
                      })),
            ],
          ),
        );
      }
    ) ;
  }
}
