class MuxResponse {
  final String uploadId;
  final String assertId;
  final String playbackId;

  MuxResponse({
    required this.uploadId,
   required this.assertId,
   required  this.playbackId,
  });

  // copyWith method
   MuxResponse copyWith({
    String uploadId ='',
    String assertId = '',
    String playbackId = '',
  }) {
    return MuxResponse(
      uploadId: uploadId ?? this.uploadId,
      assertId: assertId ?? this.assertId,
      playbackId: playbackId ?? this.playbackId,
    );
  }
}



