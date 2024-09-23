class VerifyEmailOtp {
  String? otp;
  String? email;
  String? userType;

  VerifyEmailOtp({this.otp, this.email, this.userType});

  VerifyEmailOtp.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    email = json['email'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otp'] = otp;
    data['email'] = email;
    data['userType'] = userType;
    return data;
  }
}
