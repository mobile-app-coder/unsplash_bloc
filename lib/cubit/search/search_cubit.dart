import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:exam_demo_unsplash/cubit/photo-details/photo_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/collection_model.dart';
import '../../models/search_response_model.dart';
import '../../pages/photo_detail_page.dart';
import '../../services/http_service.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  int _currentPage = 1;
  int _currentSPage = 1;
  String query = "";
  List<Result> results = [];
  ScrollController controller = ScrollController();

  SearchCubit() : super(SearchInitial());

  searchPhotos(String text) async {
    emit(SearchLoadingState());
    var response = await Network.GET(
        Network.SEARCH_API, Network.paramsSearch(text, _currentSPage));
    if (response != null) {
      if (_currentSPage == 1) {
        results = searchPhotosModelFromJson(response).results;
      } else {
        results.addAll(searchPhotosModelFromJson(response).results);
      }
    }

    emit(SearchLoadedState(results));
  }

  loadPhotos() async {
    emit(SearchLoadingState());
    var response = await Network.GET(
        Network.PHOTOS_API, Network.paramsEmpty(_currentPage));
    if (response != null) {
      var list = List<Result>.from(
          jsonDecode(response).map((x) => Result.fromJson(x)));
      results.addAll(list);
    }
    emit(SearchLoadedState(results));
  }

  openPhotoDetails(PreviewPhoto photo, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => PhotoDetailCubit(),
        child: PhotoDetailPage(
          photo: photo,
        ),
      );
    }));
  }

  initPagination() {
    controller.addListener(() {
      if (controller.position.maxScrollExtent <= controller.offset) {
        if (query.isEmpty) {
          _currentPage++;
          loadPhotos();
        } else {
          searchPhotos(query);
          _currentSPage++;
        }
      }
    });
  }
}
