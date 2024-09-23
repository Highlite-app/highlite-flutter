import 'dart:io';

abstract class UploadCompanyEvent {}

class PickVideoEvent extends UploadCompanyEvent {
  final File video;

  PickVideoEvent({required this.video});
}

class UpdateThumbnailEvent extends UploadCompanyEvent {
  final String thumbnailUrl;

  UpdateThumbnailEvent(this.thumbnailUrl);
}

class UploadCompanyJobPostEvent extends UploadCompanyEvent {
  UploadCompanyJobPostEvent();
}

class UploadCompanyVideoEvent extends UploadCompanyEvent {
  UploadCompanyVideoEvent();
}
