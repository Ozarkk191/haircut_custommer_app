part of 'service_bloc.dart';

abstract class ServiceState {
  const ServiceState();
}

class InitialState extends ServiceState {}

class LoadingState extends ServiceState {}

class LoadedState extends ServiceState {
  final List<Posts> data;
  LoadedState({@required this.data});
}

class ErrorState extends ServiceState {
  final String textError;
  ErrorState({@required this.textError});
}
