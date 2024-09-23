
import '../../../data/models/toast/progress_indicator.dart';

abstract class UploadHandlerEvent {
  const UploadHandlerEvent();
}

class AddUploadIndicationEvent extends UploadHandlerEvent {
  final ProgressIndication indicator;
  const AddUploadIndicationEvent(this.indicator);
}

class UploadProgressEvent extends UploadHandlerEvent {
  final String key;
  final String placeholder;
  final double progress;
  final int millis;
  const UploadProgressEvent(
      this.key, this.placeholder, this.progress, this.millis);
}

class RemoveIndicationEvent extends UploadHandlerEvent {
  final String key;
  const RemoveIndicationEvent(this.key);
}