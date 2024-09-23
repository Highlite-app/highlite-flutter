abstract class CheckBoxEvent{
  const CheckBoxEvent();
}

class OnCheckBoxStartEvent extends CheckBoxEvent{
  final List<String> checkbox ;
  OnCheckBoxStartEvent({required this.checkbox});
}


class OnTapCurrentIndexEvent extends CheckBoxEvent{
  final int currentIndex ;
  OnTapCurrentIndexEvent({required this.currentIndex});
}
class OnTextChangedEvent extends CheckBoxEvent{
  final String query ;
  final List<String> checkbox ;
  OnTextChangedEvent({required this.query , required this.checkbox});
}

class OnSelectionEvent extends CheckBoxEvent{
  final List<String> checkbox;
  final bool value ;
  final int index ;

  OnSelectionEvent({ required this.value , required this.index , required this.checkbox});
}

class OnSearchedEvent extends CheckBoxEvent{

}