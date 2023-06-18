import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/domain/api_client/auth_api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/ui/loader/loader_view_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';

class AuthService
    implements
        AuthViewModelLoginProvider,
        LoaderViewModelAuthStatusProvider,
        MovieDetailsMovieLogoutProvider {
  final AuthApiClient authApiClient;
  final AccountApiClient accountApiClient;
  final SessionDataProvider sessionDataProvider;

  const AuthService({
    required this.authApiClient,
    required this.accountApiClient,
    required this.sessionDataProvider,
  });

  @override
  Future<bool> isAuth() async {
    final sessionId = await sessionDataProvider.getSessionId();
    final isAuth = sessionId != null;
    return isAuth;
  }

  @override
  Future<void> login(String login, String password) async {
    final sessionId = await authApiClient.auth(
      username: login,
      password: password,
    );
    final accountId = await accountApiClient.getAccountInfo(sessionId);

    await sessionDataProvider.setSessionId(sessionId);
    await sessionDataProvider.setAccountId(accountId);
  }

  @override
  Future<void> logout() async {
    await sessionDataProvider.deleteSessionId();
    await sessionDataProvider.deleteAccountId();
  }
}
