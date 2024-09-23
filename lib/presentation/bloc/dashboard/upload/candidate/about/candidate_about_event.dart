abstract class CandidateUploadAboutEvent{
  CandidateUploadAboutEvent() ;
}

class UploadAboutStartEvent extends CandidateUploadAboutEvent{}



class SubmitAboutFormEvent extends CandidateUploadAboutEvent{
  SubmitAboutFormEvent() ;
}


class LanguagesSelectionEvent  extends CandidateUploadAboutEvent{
  final List<String> selectedLanguage ;
  LanguagesSelectionEvent({required this.selectedLanguage}) ;
}

class SubmitEvent extends CandidateUploadAboutEvent{}

