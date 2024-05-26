part of 'collection_cubit.dart';

sealed class CollectionState extends Equatable {
  const CollectionState();
}

final class CollectionInitial extends CollectionState {
  @override
  List<Object> get props => [];
}

class CollectionLoadingState extends CollectionState {
  @override
  List<Object?> get props => [];
}

class CollectionLoadedState extends CollectionState {
  final List<CollectionModel> collections;

  const CollectionLoadedState(this.collections);

  @override
  List<Object?> get props => [collections];
}

class CollectionErrorState extends CollectionState {
  final String message;

  const CollectionErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
