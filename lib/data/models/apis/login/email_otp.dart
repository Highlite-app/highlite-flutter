class EmailOtpResponse {
  final bool status ;
  final String? otp;
  final String message;

  EmailOtpResponse({
    required this.status ,
     this.otp="",
    required this.message,
  });

  // Factory constructor for creating a new EmailOtpResponse instance from a map
  factory EmailOtpResponse.fromJson(Map<String, dynamic> json) {
    return EmailOtpResponse(
      status: json['status'],
      otp: json['otp'],
      message: json['message'],
    );
  }

}
