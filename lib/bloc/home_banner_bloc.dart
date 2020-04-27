import 'dart:async';

import 'package:haircut_delivery/bloc/bloc.dart';
import 'package:haircut_delivery/exception/exception.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/home_banner.dart';
import 'package:haircut_delivery/repository/home_banner_repository.dart';

/// Business logic component for home banner.
class HomeBannerBloc extends Bloc {
  HomeBannerRepository _homeBannerRepository;
  StreamController _homeBannerListController;

  /// Returns the sink of the hom banner stream controller.
  StreamSink<ApiResponse<List<HomeBanner>>> get homeBannerListSink => _homeBannerListController.sink;

  /// Returns the stream of the home banner stream controller.
  Stream<ApiResponse<List<HomeBanner>>> get homeBannerListStream => _homeBannerListController.stream;

  HomeBannerBloc() {
    _homeBannerListController = StreamController<ApiResponse<List<HomeBanner>>>();
    _homeBannerRepository = HomeBannerRepository();
    fetchHomeBannerList();
  }

  /// Fetches a home banner list.
  fetchHomeBannerList() async {
    homeBannerListSink.add(ApiResponse.loading());
    try {
      List<HomeBanner> homeBannerList = await _homeBannerRepository.fetchHomeBannerList();
      homeBannerListSink.add(ApiResponse.success(homeBannerList));
    } on AppException catch (e) {
      homeBannerListSink.add(ApiResponse.error(e.code, e.toString()));
    } catch (e) {
      homeBannerListSink.add(ApiResponse.error(0, e.toString()));
    }
  }

  @override
  void dispose() {
    _homeBannerListController?.close();
  }
}
