import 'package:themoviedb/configuration/configuration.dart';
import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/domain/api_client/movie_api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';
import 'package:themoviedb/domain/local_entity/movie_details_local.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_model.dart';

class MovieService
    implements MovieDetailsMovieProvider, MovieListViewModelMoviesProvider {
  final SessionDataProvider sessionDataProvider;
  final MovieApiClient movieApiClient;
  final AccountApiClient accountApiClient;

  const MovieService({
    required this.sessionDataProvider,
    required this.movieApiClient,
    required this.accountApiClient,
  });

  @override
  Future<PopularMovieResponse> popularMovie(
    int page,
    String locale,
  ) async =>
      movieApiClient.popularMovie(page, locale, Configuration.apiKey);

  @override
  Future<PopularMovieResponse> searchMovie(
    int page,
    String locale,
    String query,
  ) async =>
      movieApiClient.searchMovie(page, locale, query, Configuration.apiKey);

  @override
  Future<MovieDetailsLocal> loadDetails({
    required int movieId,
    required String locale,
  }) async {
    final movieDetails = await movieApiClient.movieDetails(movieId, locale);
    final sessionId = await sessionDataProvider.getSessionId();
    var isFavorite = false;
    if (sessionId != null) {
      isFavorite = await movieApiClient.isFavorite(movieId, sessionId);
    }
    return MovieDetailsLocal(details: movieDetails, isFavorite: isFavorite);
  }

  @override
  Future<void> updateFavorite({
    required bool isFavorite,
    required int movieId,
  }) async {
    final sessionId = await sessionDataProvider.getSessionId();
    final accountId = await sessionDataProvider.getAccountId();

    if (accountId == null || sessionId == null) return;

    await accountApiClient.markAsFavorite(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: MediaType.movie,
      mediaId: movieId,
      isFavorite: isFavorite,
    );
  }
}
