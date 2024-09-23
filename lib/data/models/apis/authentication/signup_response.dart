class SignUpResponse {
  bool? status;
  String? message;

  SignUpResponse({this.status, this.message});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  static SignUpResponse getDefault() {
    return SignUpResponse(status: false , message: "No data associated with it") ;
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
