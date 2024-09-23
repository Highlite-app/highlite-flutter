import 'package:flutter/material.dart';

import '../../../../../data/models/apis/dashboard/company/upload/company_job_post.dart';
import '../../../../../data/models/apis/onboarding/company/company_onboarding.dart';

class CandidateSearchState {
  final List<CompanyOnboarding>? companyOnboarding;
  final List<CompanyJobPost>? companyJobPost;
  final List<CompanyJobPost>? filteredCompanyJobPost;
  final List<CompanyOnboarding>? filteredCompanyOnboarding;
  final List<Map<String, dynamic>>? mappedFilteredJobPosts;

  final String searchQuery;
  final Map<String, bool> filterItem;
  final List<String> skills;
  final List<String> tools;
  final List<String> salary;
  final List<String> location;
  final List<String> jobTitles;
  final List<String> selectedSkills;
  final List<String> selectedTools;
  final List<String> selectedFilteredItem ;

  final TextEditingController skillController;
  final TextEditingController toolController;
  final TextEditingController salaryController;
  final TextEditingController locationController;
  final TextEditingController jobTitleController;
  final TextEditingController searchController;

  CandidateSearchState({
    this.companyOnboarding,
    this.companyJobPost,
    this.filteredCompanyJobPost,
    this.filteredCompanyOnboarding,
    this.mappedFilteredJobPosts ,
    this.searchQuery = '',
    this.filterItem = const {},
    this.selectedFilteredItem = const [] ,
    this.skills =const [],
    this.tools=const [],
    this.salary=const [],
    this.location=const [],
    this.jobTitles=const [],
    this.selectedSkills = const [],
    this.selectedTools = const [],
    TextEditingController? skillController,
    TextEditingController? toolController,
    TextEditingController? salaryController,
    TextEditingController? locationController,
    TextEditingController? jobTitleController,
    TextEditingController? searchController,
  })  : skillController = skillController ?? TextEditingController(),
        toolController = toolController ?? TextEditingController(),
        salaryController = salaryController ?? TextEditingController(),
        locationController = locationController ?? TextEditingController(),
        jobTitleController = jobTitleController ?? TextEditingController(),
        searchController = searchController ?? TextEditingController();

  CandidateSearchState copyWith({
    List<CompanyOnboarding>? companyOnboarding,
    List<CompanyJobPost>? companyJobPost,
    List<CompanyJobPost>? filteredCompanyJobPost,
    List<CompanyOnboarding>? filteredCompanyOnboarding,
    List<Map<String, dynamic>>? mappedFilteredJobPosts,
    String? searchQuery,
    List<String>? selectedFilteredItem ,
    Map<String, bool>? filterItem,
    List<String>? skills,
    List<String>? tools,
    List<String>? salary,
    List<String>? location,
    List<String>? jobTitles,
    List<String>? selectedSkills,
    List<String>? selectedTools,
    TextEditingController? skillController,
    TextEditingController? toolController,
    TextEditingController? salaryController,
    TextEditingController? locationController,
    TextEditingController? jobTitleController,
    TextEditingController? searchController,
  }) {
    return CandidateSearchState(
      companyOnboarding: companyOnboarding ?? this.companyOnboarding,
      companyJobPost: companyJobPost ?? this.companyJobPost,
      filteredCompanyJobPost: filteredCompanyJobPost ?? this.filteredCompanyJobPost,
      filteredCompanyOnboarding: filteredCompanyOnboarding ?? this.filteredCompanyOnboarding,
      mappedFilteredJobPosts: mappedFilteredJobPosts ?? this.mappedFilteredJobPosts,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilteredItem : selectedFilteredItem ?? this.selectedFilteredItem ,
      filterItem: filterItem ?? this.filterItem,
      skills: skills ?? this.skills,
      tools: tools ?? this.tools,
      salary: salary ?? this.salary,
      location: location ?? this.location,
      jobTitles: jobTitles ?? this.jobTitles,
      selectedSkills: selectedSkills ?? this.selectedSkills,
      selectedTools: selectedTools ?? this.selectedTools,
      skillController: skillController ?? this.skillController,
      toolController: toolController ?? this.toolController,
      salaryController: salaryController ?? this.salaryController,
      locationController: locationController ?? this.locationController,
      jobTitleController: jobTitleController ?? this.jobTitleController,
      searchController: searchController ?? this.searchController,
    );
  }
}
