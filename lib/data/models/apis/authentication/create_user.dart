class CreateUser {
  String? firstName;
  String? email;
  String? provider;
  String? providerId;
  String? userType;

  CreateUser(
      {this.firstName,
        this.email,
        this.provider,
        this.providerId,
        this.userType});

  CreateUser.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    email = json['email'];
    provider = json['provider'];
    providerId = json['providerId'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['email'] = email;
    data['provider'] = provider;
    data['providerId'] = providerId;
    data['userType'] = userType;
    return data;
  }
}
