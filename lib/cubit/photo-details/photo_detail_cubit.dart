import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/collection_model.dart';

part 'photo_detail_state.dart';

class PhotoDetailCubit extends Cubit<PhotoDetailState> {
  late PreviewPhoto photo;

  bool isImage = true;

  PhotoDetailCubit() : super(PhotoDetailInitial());

  makeBrush() {
    if (isImage) {
      emit(PhotoState());
    } else {
      emit(NotPhotoState());
    }
    isImage = !isImage;
  }
}
