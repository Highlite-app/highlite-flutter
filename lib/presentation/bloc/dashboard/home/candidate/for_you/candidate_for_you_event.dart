abstract  class CandidateForYouEvent{}

class StartCandidateForYouEvent extends CandidateForYouEvent {
}

class PageChangedEvent extends CandidateForYouEvent{
  int pageIndex ;

  PageChangedEvent(this.pageIndex);
}