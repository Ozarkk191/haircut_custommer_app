class ClientAppUser {
  final int userId;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String avatarUrl;
  final UserGender gender;

  ClientAppUser(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.avatarUrl,
      this.gender})
      : assert(userId != null),
        assert(firstName != null),
        assert(lastName != null),
        assert(phone != null);

  /// Returns the full name of the user.
  String get fullName => firstName + ' ' + lastName;
}

/// Enumeration for gender.
enum UserGender { MALE, FEMALE }
