import 'dart:async';

import 'package:haircut_delivery/bloc/bloc.dart';
import 'package:haircut_delivery/exception/exception.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/place.dart';
import 'package:haircut_delivery/repository/place_repository.dart';

/// Business logic component for the Edit My Place screen.
class EditMyPlaceBloc extends Bloc {
  PlaceRepository _placeRepository;
  StreamController _updateMyPlaceController;

  /// Returns the sink of the update my place stream controller.
  StreamSink<ApiResponse> get updateMyPlaceSink => _updateMyPlaceController.sink;

  /// Returns the stream of the update my place stream controller.
  Stream<ApiResponse> get updateMyPlaceStream => _updateMyPlaceController.stream;

  EditMyPlaceBloc() {
    _updateMyPlaceController = StreamController<ApiResponse>.broadcast();
    _placeRepository = PlaceRepository();
  }

  /// Updates my place with ID [id] with data in [parameters].
  updateMyPlace(int id, UpdatePlaceParameters parameters) async {
    updateMyPlaceSink.add(ApiResponse.loading());
    try {
      await _placeRepository.updateMyPlace(id, parameters);
      updateMyPlaceSink.add(ApiResponse.success(null));
    } on AppException catch (e) {
      updateMyPlaceSink.add(ApiResponse.error(e.code, e.message));
    } catch (e) {
      updateMyPlaceSink.add(ApiResponse.error(0, e.toString()));
    }
  }

  @override
  void dispose() {
    _updateMyPlaceController?.close();
  }
}
