import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/domain/api_client/auth_api_client.dart';
import 'package:themoviedb/domain/api_client/movie_api_client.dart';
import 'package:themoviedb/domain/api_client/network_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/services/auth_service.dart';
import 'package:themoviedb/domain/services/movie_service.dart';
import 'package:themoviedb/library/app_http_client.dart';
import 'package:themoviedb/library/secutiry_storage.dart';
import 'package:themoviedb/main.dart';
import 'package:themoviedb/ui/loader/loader_view_model.dart';
import 'package:themoviedb/ui/loader/loader_widget.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/ui/navigation/main_navigation_actions.dart';
import 'package:themoviedb/ui/widgets/app/my_app.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_model.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_widget.dart';
import 'package:themoviedb/ui/widgets/movie_trailer/movie_trailer_widget.dart';
import 'package:themoviedb/ui/widgets/news/news_widget.dart';
import 'package:themoviedb/ui/widgets/tv_show/tv_show_widget.dart';

AppFactory makeAppFactory() => _AppFactoryDefault();

class _AppFactoryDefault implements AppFactory {
  _AppFactoryDefault();

  final _diContainer = _DIContainer();

  @override
  Widget makeApp() => MyApp(navigation: _diContainer._makeMyAppNavigation());
}

class _DIContainer {
  _DIContainer();

  final _mainNavigationAction = const MainNavigationAction();
  final SecureStorage _secureStorage = const SecureStorageDefault();
  final AppHttpClient _httpClient = AppHttpClientDefault();

  ScreenFactory _makeScreenFactory() => ScreenFactoryDefault(this);

  MyAppNavigation _makeMyAppNavigation() =>
      MainNavigation(_makeScreenFactory());

  SessionDataProvider _makeSessionDataProvider() =>
      SessionDataProviderDefault(_secureStorage);

  NetworkClient _makeNetworkClient() => NetworkClientDefault(_httpClient);

  AuthService _makeAuthService() => AuthService(
        accountApiClient: _makeAccountApiClient(),
        authApiClient: _makeAuthApiClient(),
        sessionDataProvider: _makeSessionDataProvider(),
      );

  MovieApiClient _makeMovieApiClient() => MovieApiClientDefault(
        _makeNetworkClient(),
      );

  AccountApiClient _makeAccountApiClient() => AccountApiClientDefault(
        _makeNetworkClient(),
      );

  AuthApiClient _makeAuthApiClient() => AuthApiClientDefault(
        _makeNetworkClient(),
      );

  AuthViewModel _makeAuthViewModel() => AuthViewModel(
        loginProvider: _makeAuthService(),
        mainNavigationAction: _mainNavigationAction,
      );

  MovieService _makeMovieServise() => MovieService(
        sessionDataProvider: _makeSessionDataProvider(),
        movieApiClient: _makeMovieApiClient(),
        accountApiClient: _makeAccountApiClient(),
      );

  LoaderViewModel _makeLoaderViewModel(BuildContext context) => LoaderViewModel(
        context: context,
        authStatusProvider: _makeAuthService(),
      );

  MovieDetailsModel _makeMovieDetailsModel(int movieId) => MovieDetailsModel(
        movieId,
        movieDetailsMovieProvider: _makeMovieServise(),
        logoutProvider: _makeAuthService(),
        navigationAction: _mainNavigationAction,
      );

  MovieListViewModel _makeMovieListViewModel() => MovieListViewModel(
        _makeMovieServise(),
      );
}

class ScreenFactoryDefault implements ScreenFactory {
  ScreenFactoryDefault(this._diContainer);

  final _DIContainer _diContainer;

  @override
  Widget makeLoader() {
    return Provider(
      create: (context) => _diContainer._makeLoaderViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }

  @override
  Widget makeAuth() {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeAuthViewModel(),
      child: const AuthWidget(),
    );
  }

  @override
  Widget makeMainScreen() {
    return MainScreenWidget(
      screenFactory: this,
    );
  }

  @override
  Widget makeMovieDetails(int movieId) {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeMovieDetailsModel(movieId),
      child: const MovieDetailsWidget(),
    );
  }

  @override
  Widget makeMovieTrailer(String youTubeKey) {
    return MovieTrailerWidget(youTubeKey: youTubeKey);
  }

  @override
  Widget makeNewsList() {
    return const NewsWidget();
  }

  @override
  Widget makeMovieList() {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeMovieListViewModel(),
      child: const MovieListWidget(),
    );
  }

  @override
  Widget makeTvShowList() {
    return const TvShowWidget();
  }
}
