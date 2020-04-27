class User {
  static const GENDER_MALE = 'm';
  static const GENDER_FEMALE = 'f';

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String language;
  final String avatarUrl;
  final String role;
  final Gender gender;

  /// Returns the full name of the user.
  String get fullName => firstName + ' ' + lastName;

  User.fromJson(Map json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        phone = json['phone'],
        language = json['language'],
        avatarUrl = json['avatar'],
        role = json['role'],
        gender = getGender(json['gender']);

  /// Returns a Gender enumeration item representing the [gender].
  static Gender getGender(String gender) {
    switch (gender) {
      case 'm':
        return Gender.MALE;
      case 'f':
        return Gender.FEMALE;
      default:
        return null;
    }
  }

  /// Returns a string representing the [gender] enumeration item.
  static String getGenderString(Gender gender) {
    switch (gender) {
      case Gender.MALE:
        return 'm';
      case Gender.FEMALE:
        return 'f';
      default:
        return null;
    }
  }
}

/// Enumeration for gender.
enum Gender { MALE, FEMALE, OTHER }
