import 'dart:async';

import 'package:haircut_delivery/bloc/bloc.dart';
import 'package:haircut_delivery/exception/exception.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/place.dart';
import 'package:haircut_delivery/repository/place_repository.dart';

/// Business logic component for the Add My Place screen.
class CreateMyPlaceBloc extends Bloc {
  PlaceRepository _placeRepository;
  StreamController _createMyPlaceController;

  /// Returns the sink of the create my place stream controller.
  StreamSink<ApiResponse> get createMyPlaceSink => _createMyPlaceController.sink;

  /// Returns the stream of the create my place stream controller.
  Stream<ApiResponse> get createMyPlaceStream => _createMyPlaceController.stream;

  CreateMyPlaceBloc() {
    _createMyPlaceController = StreamController<ApiResponse>.broadcast();
    _placeRepository = PlaceRepository();
  }

  /// Creates a new my place with [parameters].
  createMyPlace(CreatePlaceParameters parameters) async {
    createMyPlaceSink.add(ApiResponse.loading());
    try {
      await _placeRepository.createMyPlace(parameters);
      createMyPlaceSink.add(ApiResponse.success(null));
    } on AppException catch (e) {
      createMyPlaceSink.add(ApiResponse.error(e.code, e.message));
    } catch (e) {
      createMyPlaceSink.add(ApiResponse.error(0, e.toString()));
    }
  }

  @override
  void dispose() {
    _createMyPlaceController?.close();
  }
}
