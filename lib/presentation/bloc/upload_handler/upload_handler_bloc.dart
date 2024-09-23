import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/list.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/toast/progress_indicator.dart';
import 'upload_handler_event.dart';
import 'upload_handler_state.dart';


@Injectable()
class UploadHandlerBloc extends Bloc<UploadHandlerEvent, UploadHandlerState> {
  UploadHandlerBloc() : super(UploadHandlerState()) {
    on<AddUploadIndicationEvent>(_handleAddUpload);
    on<UploadProgressEvent>(_handleUploadProgress);
    on<RemoveIndicationEvent>(_handleRemoveIndication);
  }
  Future<void> _handleAddUpload(
      AddUploadIndicationEvent event,
      Emitter<UploadHandlerState> emit,
      ) async {
    List<ProgressIndication> indicators = [];
    state.progressIndications.mapTo(indicators, (_) => true);
    indicators.add(event.indicator);
    if (indicators.isNotEmpty) {
      emit(state.copyWith(disposed: false));
      await Future.delayed(const Duration(milliseconds: 300));
      emit(state.copyWith(visible: true, progressIndications: indicators));
    }
  }

  Future<void> _handleUploadProgress(
      UploadProgressEvent event,
      Emitter<UploadHandlerState> emit,
      ) async {
    List<ProgressIndication> indicators = [];
    state.progressIndications.mapWithModify(
      indicators,
          (data) {
        if (data.id == event.key) {
          return data.copyWith(
            placeholder: event.placeholder,
            progress: event.progress,
            millis: event.millis,
          );
        }
        return data;
      },
          (_) => true,
    );
    emit(state.copyWith(progressIndications: indicators));
  }

  Future<void> _handleRemoveIndication(
      RemoveIndicationEvent event,
      Emitter<UploadHandlerState> emit,
      ) async {
    List<ProgressIndication> indicators = [];
    state.progressIndications.mapTo(
      indicators,
          (indicator) => indicator.id != event.key,
    );
    if (indicators.isEmpty) {
      emit(state.copyWith(visible: false));
      await Future.delayed(const Duration(milliseconds: 300));
    }
    emit(state.copyWith(
      progressIndications: indicators,
    ));
    if (indicators.isEmpty) {
      emit(state.copyWith(disposed: true));
    }
  }
}
