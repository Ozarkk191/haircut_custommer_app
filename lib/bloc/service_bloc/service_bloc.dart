import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/model/post_model.dart';
import 'package:haircut_delivery/repository/post_repository.dart';
part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final PostRepository repository;

  ServiceBloc({@required this.repository});

  @override
  ServiceState get initialState => InitialState();

  @override
  Stream<ServiceState> mapEventToState(
    ServiceEvent event,
  ) async* {
    if (event is FetchDataEvent) {
      yield InitialState();
      try {
        List<Posts> jsonModel = await repository.fetchMyPostList();
        yield LoadedState(data: jsonModel);
      } catch (e) {
        yield ErrorState(textError: e.toString());
      }
    }
  }
}
