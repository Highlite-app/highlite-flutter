class CheckBoxState {
  final List<bool> selectedValue;

   final bool isSelected ;

  final int currentIndex ;
  final List<String> filteredCheckbox;

  final List<String> selectedChips;

  final Set<String> uniqueSet;

  CheckBoxState({
    this.selectedValue = const [],
    this.isSelected = false ,
    this.currentIndex = 0 ,
    this.filteredCheckbox = const [],
    this.selectedChips = const [],
    this.uniqueSet = const {}
  });


  CheckBoxState copyWith({
    final List<bool>? selectedValue,
   final   bool? isSelected ,
    final int? currentIndex ,
    final List<String>? filteredCheckbox,

    final List<String>? selectedChips,

    final Set<String>? uniqueSet,
  }) =>
      CheckBoxState(
          selectedValue: selectedValue ?? this.selectedValue,
          isSelected: isSelected ?? this.isSelected,
          currentIndex: currentIndex ?? this.currentIndex,
          filteredCheckbox: filteredCheckbox ?? this.filteredCheckbox,
          selectedChips: selectedChips ?? this.selectedChips,
          uniqueSet: uniqueSet ?? this.uniqueSet
      );
}
