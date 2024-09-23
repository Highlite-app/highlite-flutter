import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/onboarding/candidate_skills/checkbox_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/onboarding/candidate_skills/checkbox_state.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/buttons/primary_button.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/buttons/selection_search.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chat/chat_responder.dart';

import '../../../core/resources/l10n/translation_key.dart';
import '../../../core/resources/typography_theme.dart';
import '../../bloc/onboarding/candidate_skills/checkbox_event.dart';
import '../constants/text_style.dart';

class CheckBoxButton extends StatelessWidget {
  final List<String> checkbox;

  final MinMax<int> maxSelection;

  final String? hinText ;
  final Function onSubmit;

  final bool isSearchable;

  const CheckBoxButton(
      {required this.checkbox,
      required this.maxSelection,
        this.hinText ,
      this.isSearchable = true,
      required this.onSubmit,
      super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider<CheckBoxBloc>(
      create: (context){
        return CheckBoxBloc()..add(OnCheckBoxStartEvent(checkbox: checkbox));
      },
      child: BlocBuilder<CheckBoxBloc , CheckBoxState>(
        builder: (context, state) {
          return Container(
            color: ColorConstant.neutral50,
            child: Column(
              children: [
                if(isSearchable == true)
                  SelectionSearch(
                      hinText: hinText ??"Search skills",
                      onChange: (query) {
                        context.read<CheckBoxBloc>().add(OnTextChangedEvent(query: query, checkbox: checkbox));
                      }),
                SizedBox(
                  height: size.height * .30,
                  child: SingleChildScrollView(
                    child: Column(
                        children: List.generate(
                            state.filteredCheckbox.length,
                            (index) => InkWell(
                              onTap: (){
                                   context.read<CheckBoxBloc>().add(OnTapCurrentIndexEvent(currentIndex: index));
                              },
                              child: ChipGroup(
                                  title:  state.filteredCheckbox[index] ,
                                  isSelected: state.selectedValue[index]  ,
                                  onSelected: (value) {
                                    context.read<CheckBoxBloc>().add(OnSelectionEvent(
                                      value: value!, index: index, checkbox: checkbox));
                                    debugPrint("Selected chip length in UI ${state.selectedChips.length}");

                                  }),
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PrimaryButton(
                    title: TranslationKeys.continueText,
                    onTap: state.selectedChips.length >= maxSelection.min && state.selectedChips.length <=maxSelection.max
                        ? () {
                            onSubmit(state.selectedChips);
                          }
                        : null,
                  ),
                )
              ],
            ),
          );
        }
      )
    );
  }
}

class ChipGroup extends StatelessWidget {
  final String title;

  final bool isSelected;

  final ValueChanged<bool?> onSelected;

  const ChipGroup(
      {required this.title,
      required this.isSelected,
      required this.onSelected,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p2,
                  color: ColorConstant.neutral800,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              Transform.scale(
                scale: 1.5,
                child: Checkbox(
                    shape: const CircleBorder(),
                    activeColor: ColorConstant.primary500,
                    checkColor: Colors.white,
                    side: BorderSide(color: ColorConstant.neutral300, width: 2),
                    value: isSelected,
                    onChanged: onSelected),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
          color: ColorConstant.neutral100,
        ),
      ],
    );
  }
}


