import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/domain/api_client/auth_api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';

class AuthService implements AuthViewModelLoginProvider{
  final _authApiClient = AuthApiClient();
  final _accountApiClient = AccountApiClient();
  final SessionDataProvider sessionDataProvider;

  Future<bool> isAuth() async {
    final sessionId = await sessionDataProvider.getSessionId();
    final isAuth = sessionId != null;
    return isAuth;
  }

  Future<void> login(String login, String password) async {
    final sessionId = await _authApiClient.auth(
      username: login,
      password: password,
    );
    final accountId = await _accountApiClient.getAccountInfo(sessionId);

    await sessionDataProvider.setSessionId(sessionId);
    await sessionDataProvider.setAccountId(accountId);
  }

  Future<void> logout() async{
    await sessionDataProvider.deleteSessionId();
    await sessionDataProvider.deleteAccountId();

  }
}
