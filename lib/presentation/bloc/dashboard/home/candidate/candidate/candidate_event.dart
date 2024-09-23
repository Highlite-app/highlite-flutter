abstract class CandidateEvent {}


  class StartCandidateEvent extends CandidateEvent {
}

class PageChangedEvent extends CandidateEvent{
  int pageIndex ;

  PageChangedEvent(this.pageIndex);
}

class UnBookmarkEvent extends CandidateEvent{
  UnBookmarkEvent() ;
}

class RetrieveBookmark extends CandidateEvent{
  RetrieveBookmark() ;
}