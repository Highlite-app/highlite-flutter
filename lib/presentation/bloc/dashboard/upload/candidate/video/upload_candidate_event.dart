import 'dart:io';

import '../../../../../../data/models/onboarding/file_model.dart';

abstract class UploadCandidateEvent {}

class ToggleVideoEvent extends UploadCandidateEvent {}

class PickVideoEvent extends UploadCandidateEvent {
  final File video;

  PickVideoEvent({required this.video});
}

class StartUploadCandidate extends UploadCandidateEvent {
  StartUploadCandidate() ;
}

class ResetIsVideoStateEvent extends UploadCandidateEvent{
  ResetIsVideoStateEvent() ;
}


class UpdateThumbnailEvent extends UploadCandidateEvent {
  final String thumbnailUrl;

  UpdateThumbnailEvent(this.thumbnailUrl);
}

class UpdateDescriptionEvent extends UploadCandidateEvent {
  final String description;

  UpdateDescriptionEvent(this.description);
}


class OnBackButtonEvent extends UploadCandidateEvent{

  OnBackButtonEvent() ;
}


class UploadVideoEvent extends UploadCandidateEvent{
  final bool isVideo ;
  UploadVideoEvent({required this.isVideo});
}

class UpdateTagsEvent extends UploadCandidateEvent{
  final List<String> selectedTags ;
  UpdateTagsEvent({required this.selectedTags}) ;
}

class UpdateCategoryEvent extends UploadCandidateEvent {
  final List<String> category ;

  UpdateCategoryEvent({required this.category}) ;

}

class UploadCandidateVideoFeedEvent extends UploadCandidateEvent {
  UploadCandidateVideoFeedEvent() ;
}
