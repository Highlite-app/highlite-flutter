

class ApiResponse {
  final int status;
  final String message;

  ApiResponse({
    required this.status,
    required this.message,
  });

  // Factory method to create an ApiResponse instance from JSON
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'] as int,
      message: json['message'] as String,
    );
  }

  // Method to convert ApiResponse instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}
