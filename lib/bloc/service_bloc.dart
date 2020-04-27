import 'dart:async';

import 'package:haircut_delivery/bloc/bloc.dart';
import 'package:haircut_delivery/exception/exception.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/service.dart';
import 'package:haircut_delivery/repository/service_repository.dart';

/// Business logic component for service.
class ServiceBloc extends Bloc {
  ServiceRepository _serviceRepository;
  StreamController _serviceListController;

  /// Returns the sink of the service stream controller.
  StreamSink<ApiResponse<List<Service>>> get serviceListSink => _serviceListController.sink;

  /// Returns the stream of the service stream controller.
  Stream<ApiResponse<List<Service>>> get serviceListStream => _serviceListController.stream;

  ServiceBloc() {
    _serviceListController = StreamController<ApiResponse<List<Service>>>();
    _serviceRepository = ServiceRepository();
    fetchServiceList();
  }

  /// Fetches a service list.
  fetchServiceList() async {
    serviceListSink.add(ApiResponse.loading());
    try {
      List<Service> serviceList = await _serviceRepository.fetchServiceList();
      serviceListSink.add(ApiResponse.success(serviceList));
    } on AppException catch (e) {
      serviceListSink.add(ApiResponse.error(e.code, e.toString()));
    } catch (e) {
      serviceListSink.add(ApiResponse.error(0, e.toString()));
    }
  }

  @override
  void dispose() {
    _serviceListController?.close();
  }
}
