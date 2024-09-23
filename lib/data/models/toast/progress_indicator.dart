class ProgressIndication {
  final String id;
  final String placeholder;
  final double progress;
  final int millis;
  const ProgressIndication({
    required this.id,
    required this.placeholder,
    required this.progress,
    required this.millis,
  });
  ProgressIndication copyWith({
    String? placeholder,
    double? progress,
    int? millis,
  }) =>
      ProgressIndication(
        id: id,
        placeholder: placeholder ?? this.placeholder,
        progress: progress ?? this.progress,
        millis: millis ?? this.millis,
      );
}