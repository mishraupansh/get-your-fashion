class AuthModel {
  final String? userId;
  final String? otp;
  final String? status;

  AuthModel({
    this.userId,
    this.otp,
    this.status,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      userId: json['userid'],
      otp: json['otp'],
      status: json['status'],
    );
  }
}
