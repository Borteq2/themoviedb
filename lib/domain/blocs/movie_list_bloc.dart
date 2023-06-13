import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:themoviedb/domain/api_client/movie_api_client.dart';
import 'package:themoviedb/domain/entity/movie.dart';

abstract class MovieListEvent {}

class MovieListEventLoadNextPage extends MovieListEvent {}

class MovieListEventLoadReset extends MovieListEvent {}

class MovieListEventLoadSearchMovie extends MovieListEvent {
  final String query;

  MovieListEventLoadSearchMovie(this.query);
}

class MovieListContainer {
  final List<Movie> movies;
  final int currentPage;
  final int totalPage;

  bool get isComplete => currentPage >= totalPage;

  const MovieListContainer.initial()
      : movies = const <Movie>[],
        currentPage = 0,
        totalPage = 1;

  MovieListContainer({
    required this.movies,
    required this.currentPage,
    required this.totalPage,
  });
}

class MovieListState {
  final MovieListContainer popularMovieContainer;
  final MovieListContainer searchMovieContainer;
  final String searchQuery;

  bool get isSearchMode => searchQuery.isNotEmpty;

  const MovieListState.initial()
      : popularMovieContainer = const MovieListContainer.initial(),
        searchMovieContainer = const MovieListContainer.initial(),
        searchQuery = '';

  MovieListState({
    required this.popularMovieContainer,
    required this.searchMovieContainer,
    required this.searchQuery,
  });
}

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final _movieApiClient = MovieApiClient();

  // 99 20:20
  MovieListBloc(super.initialState) {
    on<MovieListEvent>(
      (event, emit) async {
        if (event is MovieListEventLoadNextPage) {
          // await onAuthCheckStatusEvent(event, emit);
        } else if (event is MovieListEventLoadReset) {
          // await onAuthLoginEvent(event, emit);
        } else if (event is MovieListEventLoadSearchMovie) {
          // await onAuthLogoutEvent(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  Future<void> onMovieListEventLoadNextPage(
    MovieListEventLoadNextPage event,
    Emitter<MovieListState> emit,
  ) async {
    if (state.isSearchMode) {
      // await _searchMoviePaginator.loadNextPage();
    } else {
      if (state.popularMovieContainer.isComplete) return;
      final nextPage = state.popularMovieContainer.currentPage + 1;
       final result = await
    }
  }

  Future<void> onMovieListEventLoadReset(
    MovieListEventLoadReset event,
    Emitter<MovieListState> emit,
  ) async {
    emit(const MovieListState.initial());
    add(MovieListEventLoadNextPage());
  }

  Future<void> onMovieListEventLoadSearchMovie(
    MovieListEventLoadSearchMovie event,
    Emitter<MovieListState> emit,
  ) async {}
}
