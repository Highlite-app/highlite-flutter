class VerifyEmailOtpResponse {
  bool? status;
  String? message ;
  Data? data;

  VerifyEmailOtpResponse({this.status, this.data});

  VerifyEmailOtpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'] ?? "" ;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? message;
  String? accessToken;
  String? tokenId;
  String? refreshToken;
  String? userType;
  bool? isLoggedIn;

  Data(
      {this.id,
        this.message,
        this.accessToken,
        this.tokenId,
        this.refreshToken,
        this.userType,
        this.isLoggedIn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    accessToken = json['accessToken'];
    tokenId = json['tokenId'];
    refreshToken = json['refreshToken'];
    userType = json['userType'];
    isLoggedIn = json['isLoggedIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['accessToken'] = accessToken;
    data['tokenId'] = tokenId;
    data['refreshToken'] = refreshToken;
    data['userType'] = userType;
    data['isLoggedIn'] = isLoggedIn;
    return data;
  }
}
