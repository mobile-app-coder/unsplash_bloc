import 'package:cached_network_image/cached_network_image.dart';
import 'package:exam_demo_unsplash/cubit/collections/collection_cubit.dart';
import 'package:exam_demo_unsplash/models/collection_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  late CollectionCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<CollectionCubit>(context);
    cubit.loadCollection();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionCubit, CollectionState>(
      builder: (context, state) {
        if (state is CollectionLoadingState) {
          return loadingState();
        }
        if (state is CollectionErrorState) {
          return _errorView(state);
        }
        return _lisView();
      },
    );
  }

  Widget _lisView() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "Collections",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
          itemCount: cubit.collections.length,
          itemBuilder: (context, index) {
            return _collectionItem(cubit.collections[index]);
          }),
    );
  }

  Widget _errorView(CollectionErrorState state) {
    return Scaffold(
      body: Center(
        child: Text(state.message),
      ),
    );
  }

  Widget loadingState() {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/animations/loading.json"),
      ),
    );
  }

  Widget _collectionItem(CollectionModel collectionModel) {
    return GestureDetector(
      onTap: () {
        cubit.openCollectionDetails(collectionModel, context);
      },
      child: Container(
        child: Stack(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: CachedNetworkImage(
                memCacheWidth: collectionModel.coverPhoto.width ~/ 10,
                memCacheHeight: collectionModel.coverPhoto.height ~/ 10,
                placeholder: (context, url) {
                  return Container(
                    height: 250,
                    color: Colors.black12,
                  );
                },
                imageUrl: collectionModel.coverPhoto.urls.regular,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              height: 250,
              padding: EdgeInsets.all(10),
              alignment: Alignment.bottomLeft,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment(-0.5, -0.5),
                    colors: <Color>[
                      Colors.black,
                      Colors.transparent,
                    ]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collectionModel.title,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  Text(
                    "${collectionModel.totalPhotos} photos",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
