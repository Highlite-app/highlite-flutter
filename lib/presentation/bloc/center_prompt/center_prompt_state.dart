class CenterPromptState {
  CenterPromptState({
    this.asset = "",
    this.disposed = true,
    this.visible = false,
    this.visibleIn = false,
    this.visibleOut = false,
    this.animDuration = const Duration(milliseconds: 200),
    this.isCurrentlyAnimating = false,
  });
  final String asset;
  final bool disposed;
  final bool visible;
  final bool visibleIn;
  final bool visibleOut;
  final bool isCurrentlyAnimating;
  final Duration animDuration;
  CenterPromptState copyWith({
    String? asset,
    bool? disposed,
    bool? visible,
    bool? visibleIn,
    bool? visibleOut,
    bool? isCurrentlyAnimating,
    Duration? animDuration,
  }) =>
      CenterPromptState(
        asset: asset ?? this.asset,
        disposed: disposed ?? this.disposed,
        visible: visible ?? this.visible,
        visibleIn: visibleIn ?? this.visibleIn,
        visibleOut: visibleOut ?? this.visibleOut,
        isCurrentlyAnimating: isCurrentlyAnimating ?? this.isCurrentlyAnimating,
        animDuration: animDuration ?? this.animDuration,
      );
}
