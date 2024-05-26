import 'package:cached_network_image/cached_network_image.dart';
import 'package:exam_demo_unsplash/cubit/photo-details/photo_detail_cubit.dart';
import 'package:exam_demo_unsplash/models/collection_model.dart';
import 'package:exam_demo_unsplash/pages/photo_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CollectionDetailsPage extends StatefulWidget {
  final CollectionModel? model;

  const CollectionDetailsPage({super.key, this.model});

  @override
  State<CollectionDetailsPage> createState() => _CollectionDetailsPageState();
}

class _CollectionDetailsPageState extends State<CollectionDetailsPage> {
  late CollectionModel model;

  @override
  void initState() {
    super.initState();
    model = widget.model!;
  }

  openPhotoDetails(PreviewPhoto photo) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          model.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: GridView.custom(
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          repeatPattern: QuiltedGridRepeatPattern.inverted,
          pattern: [
            QuiltedGridTile(2, 2),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 2),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          childCount: model.previewPhotos.length,
          (context, index) => Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: index < model.previewPhotos.length - 1
                  ? _photoItem(model.previewPhotos[index])
                  : Container()),
        ),
      ),
    );
  }

  Widget _photoItem(PreviewPhoto photo) {
    return GestureDetector(
      onTap: () {
        openPhotoDetails(photo);
      },
      child: Container(
        width: double.infinity,
        child: CachedNetworkImage(
          imageUrl: photo.urls.regular,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
