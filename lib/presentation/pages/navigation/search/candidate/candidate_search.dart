import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/search/candidate/candidate_search_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/search/candidate/candidate_search_event.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/search/candidate/current_search_page.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/search/candidate/selected_filtered_view.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/navigation/base_navigator.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/navigation/navigated_page.dart';
import '../../../../../data/models/apis/dashboard/company/upload/company_job_post.dart';
import '../../../../../data/models/apis/onboarding/company/company_onboarding.dart';
import '../../../../bloc/dashboard/search/candidate/candidate_search_state.dart';
import '../../../../widgets/search/sections/search_card.dart';
import '../../../../widgets/search/sections/skill_search_section.dart';
import '../../profile/company/company_public_profile.dart';
import 'base_search_page.dart';
import 'initial_filter_search.dart';

class CandidateSearchPage extends StatelessWidget {
  const CandidateSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CandidateSearchBloc, CandidateSearchState>(
        builder: (context, state) {
      return BaseSearchPage(
          controller: state.searchController,
          onSearch: (value) {
            context.read<CandidateSearchBloc>().add(UpdateSearchQuery(value));
          },
          onTapFilter: () {
            showFilter(context, onTapFilter: () {
              context.read<CandidateSearchBloc>().add(ApplyFilterEvent());
            }, onResetFilter: () {
              context.read<CandidateSearchBloc>().add(ResetFilterEvent());
            });
          },
          searchQuery: state.searchQuery ,
          initialSearch:  const InitialFilterSearch(),
          currentSearch: const CurrentSearchPage() ,
      );
        });
  }
}


