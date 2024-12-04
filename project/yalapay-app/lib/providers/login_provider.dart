import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalapay/repositories/app_repository.dart';

class LoginProvider extends AsyncNotifier<String> {
  final AppRepository _appRepository = AppRepository();

  @override
  Future<String> build() async {
    await initializeState();
    return await getUserBySession();
  }

  Future<void> initializeState() async {
    await _appRepository.initUsers();
  }

  Future<String> getUserBySession() async {
    final userName = await _appRepository.getUserBySession();
    state = AsyncValue.data(userName);
    return userName;
  }

  Future<bool> login(String userName, String password) async {
    return await _appRepository.loginUser(userName, password);
  }

  Future<bool> validateSession(String username) {
    return _appRepository.validateSession(username);
  }

  Future<bool> isLoggedIn() {
    return _appRepository.isLoggedIn();
  }

  Future<void> logout() async {
    _appRepository.logout();
    state = const AsyncValue.data('');
  }
}

final loginProviderNotifier =
    AsyncNotifierProvider<LoginProvider, String>(() => LoginProvider());
