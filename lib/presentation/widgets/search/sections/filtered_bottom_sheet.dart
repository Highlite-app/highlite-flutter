import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/search/candidate/candidate_search_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/sectionable/heading.dart';
import '../../../../core/resources/color_constants.dart';
import '../../../bloc/dashboard/search/candidate/candidate_search_event.dart';
import '../../../bloc/dashboard/search/candidate/candidate_search_state.dart';
import '../../buttons/primary_button.dart';
import '../../chip/autocomplete_filtered_chip.dart';
import '../../chip/filtered_chip.dart';

class FilterBottomSheet extends StatelessWidget {
  final Function() onTapFilter ;
  final Function() onResetFilter ;
  const FilterBottomSheet({
    required this.onTapFilter ,
    required this.onResetFilter ,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: BlocBuilder<CandidateSearchBloc, CandidateSearchState>(
                builder: (context, state) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: ColorConstant.neutral400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'Sort and Filter',
                        style: BaseTextStyle(
                          fontSize: TypographyTheme.paragraph_p2,
                          fontWeight: FontWeight.w500,
                          color: ColorConstant.neutral800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Divider(color: ColorConstant.neutral400),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Heading(
                              title: 'Sort by',
                              textStyle: BaseTextStyle(
                                fontSize: TypographyTheme.paragraph_p3,
                                fontWeight: FontWeight.w500,
                                color: ColorConstant.neutral800,
                              )),
                          Wrap(
                            spacing: 8,
                            children: state.filterItem.entries.map((entry) {
                              return CustomFilterChip(
                                label: entry.key,
                                isSelected: entry.value,
                                onSelected: (selected) {
                                  context.read<CandidateSearchBloc>().add(
                                    SortByFilter(label: entry.key,selected:  selected),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          if (state.filterItem['Skills'] ?? false)
                            AutocompleteFilteredChip(
                              heading: TranslationKeys.sortBySkills,
                              mainList: state.skills ?? [],
                              onSelected: (selectedSkills) {
                                context.read<CandidateSearchBloc>().add(UpdateSelectedChip(selectedSkills));
                              },
                              controller: state.skillController,
                              hintSearch: TranslationKeys.searchSkills,
                            ),
                          if (state.filterItem['Tools'] ?? false)
                            AutocompleteFilteredChip(
                              heading: TranslationKeys.sortByTools,
                              mainList: state.tools ,
                              onSelected: (selectedTool) {
                                context.read<CandidateSearchBloc>().add(UpdateSelectedChip(selectedTool));
                              },
                              controller: state.toolController,
                              hintSearch: TranslationKeys.searchTools,
                            ),
                          if (state.filterItem['Salary'] ?? false)
                            AutocompleteFilteredChip(
                              heading: TranslationKeys.sortBySalary,
                              mainList: state.salary ,
                              onSelected: (selectedSalary) {
                                context.read<CandidateSearchBloc>().add(UpdateSelectedChip(selectedSalary));
                              },
                              controller: state.salaryController,
                              hintSearch: TranslationKeys.searchSalary,
                            ),
                          if (state.filterItem['Location'] ?? false)
                            AutocompleteFilteredChip(
                              heading: TranslationKeys.sortByLocation,
                              mainList: state.location ,
                              onSelected: (selectedLocation) {
                                context.read<CandidateSearchBloc>().add(UpdateSelectedChip(selectedLocation));
                              },
                              controller: state.locationController,
                              hintSearch: TranslationKeys.searchLocation,
                            ),
                          if (state.filterItem['Job title'] ?? false)
                            AutocompleteFilteredChip(
                              heading: TranslationKeys.sortByJobTitle,
                              mainList: state.jobTitles ,
                              onSelected: (selectedJobTitle) {
                                context.read<CandidateSearchBloc>().add(UpdateSelectedChip(selectedJobTitle));
                              },
                              controller: state.jobTitleController,
                              hintSearch: TranslationKeys.jobTitle,
                            ),
                        ],
                      ),
                    ),
                    // if (state.filterItem['Tools']! && _selectedItems['Skills']!)
                    //   Divider(color: ColorConstant.neutral400),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        PrimaryButton(
                          buttonStyle: PrimaryButtonStyle.bordered,
                          borderWidth: 1,
                          autoGrow: true,
                          autoExpand: true,
                          expandType: ExpandButtonType.horizontal,
                          borderColor: ColorConstant.neutral300,
                          state: PrimaryButtonState.normal,
                          size: PrimaryButtonSize.custom,
                          verticalButtonPadding: 1,
                          textColor: ColorConstant.neutral700,
                          title: 'Reset All',
                          onTap: () {
                            onResetFilter() ;
                            Navigator.of(context).pop();
                          },
                          curveStyle: CurveStyle.all,
                        ),
                        const SizedBox(width: 8.0),
                        PrimaryButton(
                          buttonStyle: PrimaryButtonStyle.normal,
                          size: PrimaryButtonSize.custom,
                          verticalButtonPadding: 16,
                          autoGrow: true,
                          autoExpand: true,
                          expandType: ExpandButtonType.horizontal,
                          title: 'Apply',
                          onTap: () {
                            onTapFilter() ;
                            Navigator.of(context).pop();
                          },
                          curveStyle: CurveStyle.all,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
