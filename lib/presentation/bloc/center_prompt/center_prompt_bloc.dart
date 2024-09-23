import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'center_prompt_event.dart';
import 'center_prompt_state.dart';

@injectable
class CenterPromptBloc extends Bloc<CenterPromptEvent, CenterPromptState> {
  CenterPromptBloc() : super(CenterPromptState()) {
    on<ShowPromptEvent>((event, emit) async {
      if (!state.isCurrentlyAnimating) {
        emit(state.copyWith(
          disposed: false,
          asset: event.asset,
          isCurrentlyAnimating: true,
        ));
        await Future.delayed(state.animDuration);
        emit(state.copyWith(
          visible: true,
          visibleOut: false,
        ));
        await Future.delayed(state.animDuration);
        emit(state.copyWith(
          visibleIn: true,
        ));
        await Future.delayed(const Duration(milliseconds: 100));
        await Future.delayed(event.duration);
        emit(state.copyWith(
          visible: false,
          visibleIn: false,
          visibleOut: true,
        ));
        await Future.delayed(state.animDuration);
        emit(state.copyWith(
          disposed: true,
          visibleOut: false,
          isCurrentlyAnimating: false,
        ));
      }
    });
  }
}
