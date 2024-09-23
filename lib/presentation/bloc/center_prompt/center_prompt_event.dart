abstract class CenterPromptEvent {
  const CenterPromptEvent();
}

class ShowPromptEvent extends CenterPromptEvent {
  const ShowPromptEvent({
    required this.asset,
    this.duration = const Duration(milliseconds: 800),
    this.animDuration,
  });
  final String asset;
  final Duration duration;
  final Duration? animDuration;
}
