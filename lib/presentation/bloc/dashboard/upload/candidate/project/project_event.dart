
abstract class UploadProjectEvent {}

class InitializeForm extends UploadProjectEvent {}

class DisposeForm extends UploadProjectEvent {}

class ProjectTitleChanged extends UploadProjectEvent {
  final String title;

  ProjectTitleChanged(this.title);
}

class SubmitProjectStatusEvent extends UploadProjectEvent {
  final String projectStatus;

  SubmitProjectStatusEvent(this.projectStatus);
}

class AddMorDetailsEvent extends UploadProjectEvent{}

class SaveProjectEvent extends UploadProjectEvent{}

class ClientDetailsChanged extends UploadProjectEvent {
  final String clientDetails;

  ClientDetailsChanged(this.clientDetails);
}

// Define other events for each form field similarly...
