import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'collection_details_state.dart';

class CollectionDetailsCubit extends Cubit<CollectionDetailsState> {
  CollectionDetailsCubit() : super(CollectionDetailsInitial());
}
