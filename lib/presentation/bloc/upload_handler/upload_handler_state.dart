import '../../../data/models/toast/progress_indicator.dart';

class UploadHandlerState {
  UploadHandlerState({
    this.progressIndications = const [],
    this.disposed = true,
    this.visible = false,
  });
  final bool disposed;
  final bool visible;
  final List<ProgressIndication> progressIndications;

  UploadHandlerState copyWith({
    List<ProgressIndication>? progressIndications,
    bool? disposed,
    bool? visible,
  }) =>
      UploadHandlerState(
        progressIndications: progressIndications ?? this.progressIndications,
        disposed: disposed ?? this.disposed,
        visible: visible ?? this.visible,
      );
}