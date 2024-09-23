import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/onboarding/candidate_skills/checkbox_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/onboarding/candidate_skills/checkbox_state.dart';

class CheckBoxBloc extends Bloc<CheckBoxEvent , CheckBoxState>{
  CheckBoxBloc():super(CheckBoxState()){
    on<OnCheckBoxStartEvent>(_handleCheckBoxStartEvent);
    on<OnTapCurrentIndexEvent>(_handleOnTapCurrentIndexEvent);
    on<OnSelectionEvent>(_handleOnSelectionEvent) ;
   // on<OnChangeSelectionEvent>(_handleOnSelectionEvent) ;
    on<OnSearchedEvent>(_handleCheckBoxSearchEvent);
    on<OnTextChangedEvent>(_handleOnTextChangedEvent);
  }

  Future<void> _handleCheckBoxStartEvent(
      OnCheckBoxStartEvent event ,
      Emitter<CheckBoxState> emit,
      ) async{
    emit(state.copyWith(selectedValue: List.generate(event.checkbox.length, (index) => false) ,
    filteredCheckbox: List.from(event.checkbox) ,
    ));
  }

  Future<void> _handleOnTapCurrentIndexEvent(
      OnTapCurrentIndexEvent event ,
      Emitter<CheckBoxState> emit ,
      ) async{
    emit(state.copyWith(currentIndex: event.currentIndex));
    debugPrint("The currentIndex :: ${event.currentIndex}");
  }

  Future<void> _handleCheckBoxSearchEvent(
      OnSearchedEvent event ,
      Emitter<CheckBoxState> emit ,
      ) async{

  }

  Future<void> _handleOnTextChangedEvent(
      OnTextChangedEvent event ,
      Emitter<CheckBoxState> emit
      ) async{
    if(event.query ==""){
      emit(state.copyWith(filteredCheckbox:event.checkbox ));
    }else {
      emit(state.copyWith(filteredCheckbox:  event.checkbox.where((value) => value.toLowerCase().contains(event.query.toLowerCase())).toList()));
    }
  }

  Future<void> _handleOnSelectionEvent(
      OnSelectionEvent event ,
      Emitter<CheckBoxState> emit ,
      ) async{
    final List<String> selectedChips = List.from(state.selectedChips)  ;
    final List<bool> selectedValue = List.from(state.selectedValue);
    selectedValue[event.index] = event.value ;
    emit(state.copyWith(selectedValue: selectedValue));
      if (!selectedChips.contains(event.checkbox[event.index])) {
        selectedChips.add(event.checkbox[event.index]);
      }
      else {
        if (selectedChips.contains(event.checkbox[event.index])) {
          selectedChips.remove(event.checkbox[event.index]);
        }
      }
        debugPrint("The length of selectedChips :: ${selectedChips.length}");
        emit(state.copyWith(selectedChips: selectedChips));

  }

}

