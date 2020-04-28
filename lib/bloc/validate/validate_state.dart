part of 'validate_bloc.dart';

abstract class ValidateState extends Equatable {
  const ValidateState();
}

class ValidateInitialState extends ValidateState {
  @override
  List<Object> get props => null;
}

class FirstErrorState extends ValidateState {
  final String errorText;
  FirstErrorState({@required this.errorText});
  @override
  List<Object> get props => null;
}

class LastErrorState extends ValidateState {
  final String errorText;
  LastErrorState({@required this.errorText});
  @override
  List<Object> get props => null;
}

class EmailErrorState extends ValidateState {
  final String errorText;
  EmailErrorState({@required this.errorText});
  @override
  List<Object> get props => null;
}

class PhoneErrorState extends ValidateState {
  final String errorText;
  PhoneErrorState({@required this.errorText});
  @override
  List<Object> get props => null;
}

class PasswordErrorState extends ValidateState {
  final String errorText;
  PasswordErrorState({@required this.errorText});
  @override
  List<Object> get props => null;
}

class RepeatPasswordErrorState extends ValidateState {
  final String errorText;
  RepeatPasswordErrorState({@required this.errorText});
  @override
  List<Object> get props => null;
}

class AddressErrorState extends ValidateState {
  final String errorText;
  AddressErrorState({@required this.errorText});
  @override
  List<Object> get props => null;
}

class TitleAddressErrorState extends ValidateState {
  final String errorText;
  TitleAddressErrorState({@required this.errorText});
  @override
  List<Object> get props => null;
}
