import 'package:bloc/bloc.dart';
import 'package:themoviedb/domain/blocs/movie_list_bloc.dart';

class MovieListRowData {
  final int id;
  final String title;
  final String releaseDate;
  final String overview;
  final String? posterPath;

  MovieListRowData({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.overview,
    required this.posterPath,
  });
}


class MovieListCubitState {
  final List<MovieListRowData> movies;
  final String localeTag;
  final String searchQuery;

  const MovieListCubitState({
    required this.movies,
    required this.localeTag,
    required this.searchQuery,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieListCubitState &&
          runtimeType == other.runtimeType &&
          movies == other.movies;

  @override
  int get hashCode => movies.hashCode;
}


class MovieListCubit extends Cubit<MovieListCubitState> {
  final MovieListBloc movieListBloc;

  MovieListCubit({required MovieListCubitState initialState,
  required this.movieListBloc}) : super(initialState);


}