import 'package:haircut_delivery/model/request_body_parameters.dart';

class RequestPasswordResetOtpByEmailParameters extends RequestBodyParameters {
  final String email;

  RequestPasswordResetOtpByEmailParameters(this.email);

  Map<String, dynamic> toJson() => {'email': email};
}

class RequestPasswordResetOtpByPhoneParameters extends RequestBodyParameters {
  final String phone;

  RequestPasswordResetOtpByPhoneParameters(this.phone);

  Map<String, dynamic> toJson() => {'phone': phone};
}

class SubmitPasswordResetOtpByEmailParameters extends RequestBodyParameters {
  final String email;
  final String otp;

  SubmitPasswordResetOtpByEmailParameters(this.email, this.otp);

  Map<String, dynamic> toJson() => {'email': email, 'otp': otp};
}

class SubmitPasswordResetOtpByPhoneParameters extends RequestBodyParameters {
  final String phone;
  final String otp;

  SubmitPasswordResetOtpByPhoneParameters(this.phone, this.otp);

  Map<String, dynamic> toJson() => {'phone': phone, 'otp': otp};
}

class PasswordResetToken {
  final String resetToken;

  PasswordResetToken.fromJson(Map json) : resetToken = json['resetToken'];
}

class ResetPasswordParameters extends RequestBodyParameters {
  final String resetToken;
  final String password;

  ResetPasswordParameters(this.resetToken, this.password);

  Map<String, dynamic> toJson() => {'resetToken': resetToken, 'password': password};
}
