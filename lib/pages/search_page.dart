import 'package:cached_network_image/cached_network_image.dart';
import 'package:exam_demo_unsplash/cubit/search/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';

import '../models/search_response_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<SearchCubit>(context);
    cubit.loadPhotos();
    cubit.initPagination();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
        builder: (BuildContext context, SearchState state) {
      if (state is SearchErrorState) {
        return errorView(state);
      }
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.black,
          title: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(),
            ),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: "Search photos, collections, users",
                  labelStyle: TextStyle(color: Colors.white),
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
              onSubmitted: (text) {
                cubit.query = text;
                cubit.searchPhotos(text);
              },
            ),
          ),
        ),
        body: state is SearchLoadedState
            ? GridView.custom(
                controller: cubit.controller,
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  repeatPattern: QuiltedGridRepeatPattern.inverted,
                  pattern: [
                    const QuiltedGridTile(2, 2),
                    const QuiltedGridTile(1, 1),
                    const QuiltedGridTile(1, 1),
                    const QuiltedGridTile(1, 2),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  childCount: state.photos.length,
                  (context, index) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: index < state.photos.length - 1
                          ? _resultItem(state.photos[index])
                          : Container()),
                ),
              )
            : Center(child: Lottie.asset("assets/animations/loading.json")),
      );
    });
  }

  Widget errorView(SearchErrorState state) {
    return Scaffold(
      body: Center(
        child: Text(state.errorMessage),
      ),
    );
  }

  Widget _resultItem(Result result) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          cubit.openPhotoDetails(getPreviewPhoto(result), context);
        },
        child: Stack(fit: StackFit.expand, children: [
          CachedNetworkImage(
            memCacheHeight: result.height ~/ 10,
            memCacheWidth: result.width ~/ 10,
            imageUrl: result.urls.regular,
            fit: BoxFit.cover,
          ),
          Container(
            margin: const EdgeInsets.all(5),
            alignment: Alignment.bottomLeft,
            child: Text(
              result.user.name,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
