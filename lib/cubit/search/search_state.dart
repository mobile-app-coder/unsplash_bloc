part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();
}

final class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadingState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoadedState extends SearchState {
  final List<Result> photos;

  const SearchLoadedState(this.photos);

  @override
  List<Object?> get props => [photos];
}

class SearchErrorState extends SearchState {
  final String errorMessage;

  const SearchErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
