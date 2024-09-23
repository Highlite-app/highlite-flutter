class GeneralFlowModel {
  final String userType;

  const GeneralFlowModel({
    required this.userType,
  });

  // Factory constructor to create an instance from a map
  factory GeneralFlowModel.fromJson(Map<String, dynamic> json) {
    return GeneralFlowModel(
      userType: json['userType'],
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toJson() {
    return {
      'userType': userType,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeneralFlowModel &&
        other.userType == userType;
  }

  @override
  int get hashCode => userType.hashCode;

  @override
  String toString() => 'GeneralFlowModel(userType: $userType)';
}
