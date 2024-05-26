part of 'collection_details_cubit.dart';

sealed class CollectionDetailsState extends Equatable {
  const CollectionDetailsState();
}

final class CollectionDetailsInitial extends CollectionDetailsState {
  @override
  List<Object> get props => [];
}
