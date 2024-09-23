import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/candidate/search/search_repository.dart';

import '../../../../../data/models/apis/onboarding/company/company_onboarding.dart';
import 'candidate_search_event.dart';
import 'candidate_search_state.dart';

class CandidateSearchBloc
    extends Bloc<CandidateSearchEvent, CandidateSearchState> {
  CandidateSearchBloc() : super(CandidateSearchState()) {
    on<StartEvent>(_handleStartEvent);
    on<UpdateSearchQuery>(_handleUpdateSearchQuery);
    on<SortByFilter>(_handleSortByFilter);
    on<UpdateSelectedChip>(_handleUpdateSelectedChip) ;
    on<ApplyFilterEvent>(_handleApplyFilter);
    on<ResetFilterEvent>(_handleResetFilter);
  }

  Future<void> _handleStartEvent(
      StartEvent event, Emitter<CandidateSearchState> emit) async {
    final companyOnboardingList =
        await searchService.getOnboardingCandidateFromLocalDatabase();
    final companyJobPostList =
        await searchService.getCompanyJobPostFromLocalDatabase();
    final skills =
        await searchService.getSkillsListFromLocalDatabase();
    final tools = await searchService.getToolsListFromLocalDatabase();
    final location =
        await searchService.getLocationListFromLocalDatabase();
    final jobTitle =
        await searchService.getJobTitleListFromLocalDatabase();
    final salary = await searchService.getSalaryFromLocalDatabase();
    final filteredList = ['Skills', 'Tools', 'Salary', 'Location', 'Job title'];
    final filterItem = {for (var item in filteredList) item: false};
    emit(state.copyWith(
        companyOnboarding: companyOnboardingList,
        companyJobPost: companyJobPostList,
        skills: skills,
        tools: tools,
        jobTitles: jobTitle,
        location: location,
        salary: salary,
        filterItem: filterItem));
  }

  void _handleSortByFilter(
      SortByFilter event, Emitter<CandidateSearchState> emit) async {
    if (state.filterItem.containsKey(event.label)) {
      final updatedFilterItem = Map<String, bool>.from(state.filterItem)
        ..[event.label] = event.selected;
      emit(state.copyWith(filterItem: updatedFilterItem));
    }
  }

  void _handleUpdateSearchQuery(UpdateSearchQuery event, Emitter<CandidateSearchState> emit) {
    if (event.searchQuery.isEmpty) {
      emit(state.copyWith(
        searchQuery: '',
        filteredCompanyJobPost: List.from(state.companyJobPost ?? []),
        filteredCompanyOnboarding: List.from(state.companyOnboarding ?? []),
        mappedFilteredJobPosts: state.companyJobPost?.map((jobPost) {
          final companyOnboarding = state.companyOnboarding?.firstWhere(
                (onboarding) => onboarding.companyId == jobPost.companyId,
            orElse: () => CompanyOnboarding.defaultOnboarding(),
          );
          return {
            'jobPost': jobPost,
            'companyOnboarding': companyOnboarding,
          };
        }).toList(),
      ));
      return;
    }

    // Filter the onboarding companies list
    final filteredOnboarding = state.companyOnboarding?.where((onboarding) {
      return onboarding.companyName.toLowerCase().contains(event.searchQuery.toLowerCase()) ;
    }).toList();

    // Filter the job posts list
    final filteredJobPosts = state.companyJobPost?.where((jobPost) {
      return jobPost.position.toLowerCase().contains(event.searchQuery.toLowerCase()) ||
          jobPost.location.toLowerCase().contains(event.searchQuery.toLowerCase()) ||
          jobPost.salary.toLowerCase().contains(event.searchQuery.toLowerCase()) ||
          jobPost.workType.toLowerCase().contains(event.searchQuery.toLowerCase()) ||
          jobPost.jobDuration.toLowerCase().contains(event.searchQuery.toLowerCase()) ||
          jobPost.skills.any((skill) => skill.toLowerCase().contains(event.searchQuery.toLowerCase()) ||
          jobPost.tools.any((tools) => tools.toLowerCase().contains(event.searchQuery.toLowerCase())));
    }).toList();

    // Map filtered job posts to corresponding onboarding companies
    final mappedFilteredJobPosts = filteredJobPosts?.map((jobPost) {
      final companyOnboarding = state.companyOnboarding?.firstWhere(
            (onboarding) => onboarding.companyId == jobPost.companyId,
        orElse: () => CompanyOnboarding.defaultOnboarding(),
      );
      return {
        'jobPost': jobPost,
        'companyOnboarding': companyOnboarding,
      };
    }).toList();

    emit(state.copyWith(
      searchQuery: event.searchQuery,
      filteredCompanyJobPost: filteredJobPosts,
      filteredCompanyOnboarding: filteredOnboarding,
      mappedFilteredJobPosts: mappedFilteredJobPosts,
    ));
  }

  void _handleApplyFilter(ApplyFilterEvent event, Emitter<CandidateSearchState> emit) async {
    final selectedSkills = state.skills.where((skill) => state.skillController.text.contains(skill))
        .toList() ;

    final selectedTools = state.tools.where((tool) => state.toolController.text.contains(tool))
        .toList() ;

    final selectedSalary = state.salary.where((salary) => state.salaryController.text.contains(salary))
        .toList() ;

    final selectedLocation = state.location.where((location) => state.locationController.text.contains(location))
        .toList() ;

    final selectedJobTitles = state.jobTitles.where((jobTitle) => state.jobTitleController.text.contains(jobTitle))
        .toList() ;

    final filteredJobPosts = state.companyJobPost?.where((jobPost) {
      final matchesSkills = selectedSkills.isEmpty ||
          selectedSkills.any((skill) => jobPost.skills.contains(skill));
      final matchesTools = selectedTools.isEmpty ||
          selectedTools.any((tool) => jobPost.tools.contains(tool));
      final matchesSalary = selectedSalary.isEmpty ||
          selectedSalary.contains(jobPost.salary);
      final matchesLocation = selectedLocation.isEmpty ||
          selectedLocation.contains(jobPost.location);
      final matchesJobTitles = selectedJobTitles.isEmpty ||
          selectedJobTitles.contains(jobPost.position);

      return matchesSkills &&
          matchesTools &&
          matchesSalary &&
          matchesLocation &&
          matchesJobTitles;
    }).toList() ?? [];

    final mappedFilteredJobPosts = filteredJobPosts.map((jobPost) {
      final companyOnboarding = state.companyOnboarding?.firstWhere(
            (onboarding) => onboarding.companyId == jobPost.companyId,
        orElse: () => CompanyOnboarding.defaultOnboarding(),
      );
      return {
        'jobPost': jobPost,
        'companyOnboarding': companyOnboarding,
      };
    }).toList();

    emit(state.copyWith(
      selectedSkills: selectedSkills,
      selectedTools: selectedTools,
      filteredCompanyJobPost: filteredJobPosts,
      filteredCompanyOnboarding: state.companyOnboarding,
      mappedFilteredJobPosts: mappedFilteredJobPosts,
    ));
  }


  void _handleUpdateSelectedChip(
      UpdateSelectedChip event , 
      Emitter<CandidateSearchState> emit
      ) {
    
    String selectedItem  = event.selectedItem ; 
    List<String> updateSelectedItem = List.from(state.selectedFilteredItem)..add(selectedItem) ;

    emit(state.copyWith(selectedFilteredItem: updateSelectedItem)) ;
  }


  void _handleResetFilter(
      ResetFilterEvent event, Emitter<CandidateSearchState> emit) {
    emit(state.copyWith(
      filterItem: {
        'Skills': false,
        'Tools': false,
        'Salary': false,
        'Location': false,
        'Job title': false,
      },
      skillController: TextEditingController(),
      toolController: TextEditingController(),
      salaryController: TextEditingController(),
      locationController: TextEditingController(),
      jobTitleController: TextEditingController(),
      filteredCompanyJobPost: [],
      selectedFilteredItem: [] ,
    ));
  }
}
