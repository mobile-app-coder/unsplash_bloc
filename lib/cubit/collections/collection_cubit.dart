import 'package:equatable/equatable.dart';
import 'package:exam_demo_unsplash/cubit/collection-details/collection_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/collection_model.dart';
import '../../pages/collection_details_page.dart';
import '../../services/http_service.dart';

part 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit() : super(CollectionInitial());

  List<CollectionModel> collections = [];

  loadCollection() async {
    emit(CollectionLoadingState());
    var response = await Network.GET(
        Network.COLLECTIONS_API, Network.paramsGetCollection());
    if (response != null) {
      collections = collectionModelFromMap(response);
      emit(CollectionLoadedState(collections));
    } else {
      emit(const CollectionErrorState("No data"));
    }
  }

  openCollectionDetails(CollectionModel collectionModel, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => CollectionDetailsCubit(),
        child: CollectionDetailsPage(model: collectionModel),
      );
    }));
  }
}
