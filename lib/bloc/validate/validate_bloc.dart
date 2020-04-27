import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'validate_event.dart';
part 'validate_state.dart';

class ValidateBloc extends Bloc<ValidateEvent, ValidateState> {
  @override
  ValidateState get initialState => ValidateInitialState();

  @override
  Stream<ValidateState> mapEventToState(
    ValidateEvent event,
  ) async* {
    if (event is PhoneNumberFieldEvent) {
      yield ValidateInitialState();
      if (event.value.isEmpty) {
        yield PhoneErrorState(errorText: 'Phone Number can not empty.');
      } else if (event.value.length < 10) {
        yield PhoneErrorState(errorText: 'Phone Number must be then 10 chars.');
      }
    }

    if (event is PasswordFieldEvent) {
      yield ValidateInitialState();
      if (event.value.isEmpty) {
        yield PasswordErrorState(errorText: 'Password can not empty.');
      }
    }

    if (event is FirstnameFieldEvent) {
      yield ValidateInitialState();
      if (event.value.isEmpty) {
        yield FirstErrorState(errorText: 'Firstname can not empty.');
      }
    }

    if (event is LastnameFieldEvent) {
      yield ValidateInitialState();
      if (event.value.isEmpty) {
        yield LastErrorState(errorText: 'Lastname can not empty.');
      }
    }

    if (event is EmailFieldEvent) {
      yield ValidateInitialState();
      if (event.value.isEmpty) {
        yield EmailErrorState(errorText: 'Email can not empty.');
      } else if (!event.value.contains("@") || !event.value.contains(".com")) {
        yield EmailErrorState(errorText: 'Do not type Email.');
      }
    }

    if (event is RepeatPasswordFieldEvent) {
      yield ValidateInitialState();
      if (event.repeat.isEmpty) {
        yield RepeatPasswordErrorState(
            errorText: 'Password(Repeat) can not empty.');
      } else if (event.repeat != event.password) {
        yield RepeatPasswordErrorState(errorText: 'Password does not match.');
      }
    }

    if (event is AddressFieldEvent) {
      yield ValidateInitialState();
      if (event.value.isEmpty) {
        yield AddressErrorState(errorText: 'Address can not empty.');
      }
    }
  }
}
