class UploadProgress {
  final int transferredBytes;
  final int totalBytes;
  final double progress;
  const UploadProgress(
      {required this.transferredBytes,
        required this.totalBytes,
        required this.progress});
}