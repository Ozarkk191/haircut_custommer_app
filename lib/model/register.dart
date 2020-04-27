import 'package:haircut_delivery/model/request_body_parameters.dart';
import 'package:haircut_delivery/model/user.dart';

class RegisterParameters extends RequestBodyParameters {
  final String email;
  final String phone;
  final String password;
  final String firstName;
  final String lastName;
  final Gender gender;
  final String role = 'customer';

  RegisterParameters(this.email, this.phone, this.password, this.firstName, this.lastName, this.gender);

  Map<String, dynamic> toJson() => {
        'email': email,
        'phone': phone,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'gender': User.getGenderString(gender),
        'role': 'customer',
      };
}
