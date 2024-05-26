part of 'photo_detail_cubit.dart';

sealed class PhotoDetailState extends Equatable {
  const PhotoDetailState();
}

final class PhotoDetailInitial extends PhotoDetailState {
  @override
  List<Object> get props => [];
}

class PhotoState extends PhotoDetailState {
  @override
  List<Object?> get props => [];
}

class NotPhotoState extends PhotoDetailState {
  @override
  List<Object?> get props => [];
}
