class UploadResponse {
  final String fileName;
  final List<String> urlFragments;
  const UploadResponse({
    required this.fileName,
    required this.urlFragments,
  });
}