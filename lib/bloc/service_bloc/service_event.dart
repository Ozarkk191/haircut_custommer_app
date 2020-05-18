part of 'service_bloc.dart';

abstract class ServiceEvent {
  const ServiceEvent();
}

class FetchDataEvent extends ServiceEvent {}
