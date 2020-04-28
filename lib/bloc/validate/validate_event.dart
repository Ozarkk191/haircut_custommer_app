part of 'validate_bloc.dart';

abstract class ValidateEvent {
  const ValidateEvent();
}

class FirstnameFieldEvent extends ValidateEvent {
  final String value;
  FirstnameFieldEvent({@required this.value});
}

class LastnameFieldEvent extends ValidateEvent {
  final String value;
  LastnameFieldEvent({@required this.value});
}

class EmailFieldEvent extends ValidateEvent {
  final String value;
  EmailFieldEvent({@required this.value});
}

class PhoneNumberFieldEvent extends ValidateEvent {
  final String value;
  PhoneNumberFieldEvent({@required this.value});
}

class PasswordFieldEvent extends ValidateEvent {
  final String value;
  PasswordFieldEvent({@required this.value});
}

class RepeatPasswordFieldEvent extends ValidateEvent {
  final String password, repeat;
  RepeatPasswordFieldEvent({
    @required this.password,
    @required this.repeat,
  });
}

class AddressFieldEvent extends ValidateEvent {
  final String value;
  AddressFieldEvent({@required this.value});
}

class TitleAddressFieldEvent extends ValidateEvent {
  final String value;
  TitleAddressFieldEvent({@required this.value});
}
