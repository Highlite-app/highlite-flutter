import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/toast/toast_event.dart';
import 'package:injectable/injectable.dart';

import '../../../core/services/injection_container.dart';
import 'toast_state.dart';

final toaster = sl.get<ToasterBloc>();

class ToasterBloc extends Bloc<ToasterEvent, ToasterState> {
  ToasterBloc() : super(ToasterState()) {
    on<ShowToastEvent>((event, emit) async {
      emit(
        state.copyWith(
          disposed: false,
          displayedTitle: event.title,
          displayedText: event.text,
          icon: event.icon,
          state: event.state,
          link: event.link,
          linkAction: event.linkAction,
        ),
      );
      await Future.delayed(state.animDuration);
      emit(state.copyWith(visible: true));
      await Future.delayed(const Duration(milliseconds: 100));
      await Future.delayed(event.duration);
      emit(state.copyWith(visible: false));
      await Future.delayed(state.animDuration);
      emit(state.copyWith(disposed: true));
    });
  }
}
