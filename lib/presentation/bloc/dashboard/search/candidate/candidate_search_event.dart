abstract class CandidateSearchEvent {}



class StartEvent extends CandidateSearchEvent{

  StartEvent() ;
}

class UpdateSearchQuery extends CandidateSearchEvent {
  final String searchQuery;

  UpdateSearchQuery(this.searchQuery);
}

class SortByFilter extends CandidateSearchEvent{
  final String label ;
  final bool selected ;
  SortByFilter({required this.label , required this.selected}) ;
}

class ToggleFilterPopup extends CandidateSearchEvent {}

class ApplyFilterEvent extends CandidateSearchEvent{

  ApplyFilterEvent() ;
}

class UpdateSelectedChip extends  CandidateSearchEvent{
  String selectedItem ;

  UpdateSelectedChip(this.selectedItem) ;
}

class ResetFilterEvent extends CandidateSearchEvent {

  ResetFilterEvent() ;
}

