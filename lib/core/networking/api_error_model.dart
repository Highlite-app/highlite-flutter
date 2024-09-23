class ApiErrorModel {
  final String message;

  final int httpStatusCode;

  final bool? status;

  final tag;

  ApiErrorModel(
    this.message,
    this.httpStatusCode, {
    this.status = false,
    this.tag = "",
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> parsedJson) =>
      ApiErrorModel(
          parsedJson['message'] ?? '', parsedJson['httpStatusCode'] ?? '',
          status: parsedJson['status'], tag: parsedJson['tag']);
}
