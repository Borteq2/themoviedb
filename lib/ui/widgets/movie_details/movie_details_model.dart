import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/domain/api_client/movie_api_client.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';

class MovieDetailsModel extends ChangeNotifier {
  MovieDetailsModel(this.movieId);

  final _sessionDataProvider = SessionDataProvider();
  final _movieApiClient = MovieApiClient();
  final _accountApiClient = AccountApiClient();

  final int movieId;
  MovieDetails? _movieDetails;
  bool _isFavorite = false;
  String _locale = '';
  late DateFormat _dateFormat;
  Future<void>? Function()? onSessionExpired;

  MovieDetails? get movieDetails => _movieDetails;

  bool get isFavorite => _isFavorite;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMd(locale);
    await loadDetails();
  }

  Future<void> loadDetails() async {
    try {
      _movieDetails = await _movieApiClient.movieDetails(movieId, _locale);
      final sessionId = await _sessionDataProvider.getSessionId();
      if (sessionId != null) {
        _isFavorite = await _movieApiClient.isFavorite(movieId, sessionId);
      }
      notifyListeners();
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  Future<void> toggleFavorite() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();

    if (accountId == null || sessionId == null) return;

    final newFavoriteValue = !_isFavorite;
    _isFavorite = newFavoriteValue;
    notifyListeners();
    try {
      await _accountApiClient.markAsFavorite(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: MediaType.movie,
        mediaId: movieId,
        isFavorite: newFavoriteValue,
      );
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  void _handleApiClientException(ApiClientException exception) {
    switch (exception.type) {
      case ApiClientExceptionType.sessionExpired:
        onSessionExpired?.call();
        break;
      default:
        print(exception);
    }
  }
}
