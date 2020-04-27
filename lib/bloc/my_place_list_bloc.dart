import 'dart:async';

import 'package:haircut_delivery/bloc/bloc.dart';
import 'package:haircut_delivery/exception/exception.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/place.dart';
import 'package:haircut_delivery/repository/place_repository.dart';

/// Business logic component for my place list.
class MyPlaceListBloc extends Bloc {
  PlaceRepository _placeRepository;
  StreamController _myPlaceListController;
  StreamController _deleteMyPlaceController;

  /// Returns the sink of the my place list stream controller.
  StreamSink<ApiResponse<List<Place>>> get myPlaceListSink => _myPlaceListController.sink;

  /// Returns the stream of the my place list stream controller.
  Stream<ApiResponse<List<Place>>> get myPlaceListStream => _myPlaceListController.stream;

  /// Returns the sink of the delete my place stream controller.
  StreamSink<ApiResponse> get deleteMyPlaceSink => _deleteMyPlaceController.sink;

  /// Returns the stream of the delete my place stream controller.
  Stream<ApiResponse> get deleteMyPlaceStream => _deleteMyPlaceController.stream;

  MyPlaceListBloc() {
    _myPlaceListController = StreamController<ApiResponse<List<Place>>>();
    _deleteMyPlaceController = StreamController<ApiResponse>();
    _placeRepository = PlaceRepository();
    fetchMyPlaceList();
  }

  /// Fetches my place list.
  fetchMyPlaceList() async {
    myPlaceListSink.add(ApiResponse.loading());
    try {
      List<Place> myPlaceList = await _placeRepository.fetchMyPlaceList();
      myPlaceListSink.add(ApiResponse.success(myPlaceList));
    } on AppException catch (e) {
      myPlaceListSink.add(ApiResponse.error(e.code, e.toString()));
    } catch (e) {
      myPlaceListSink.add(ApiResponse.error(0, e.toString()));
    }
  }

  /// Deletes my place with ID [id].
  deleteMyPlace(int id) async {
    deleteMyPlaceSink.add(ApiResponse.loading());
    try {
      await _placeRepository.deleteMyPlace(id);
      deleteMyPlaceSink.add(ApiResponse.success(null));
    } on AppException catch (e) {
      deleteMyPlaceSink.add(ApiResponse.error(e.code, e.toString()));
    } catch (e) {
      deleteMyPlaceSink.add(ApiResponse.error(0, e.toString()));
    }
  }

  @override
  void dispose() {
    _myPlaceListController?.close();
    _deleteMyPlaceController?.close();
  }
}
