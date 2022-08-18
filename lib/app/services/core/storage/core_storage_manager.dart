import 'package:get_storage/get_storage.dart';

import '../utilities/logger_service.dart';

class CoreStorageManager {
  ///Keys
  static const _accessToken = '_accessToken';
  static const _refreshToken = '_refreshToken';
  static const _firebaseToken = '_firebaseToken';

  ///
  ///Constructors
  static final CoreStorageManager _instance = CoreStorageManager._internal();

  CoreStorageManager._internal();

  factory CoreStorageManager() {
    return _instance;
  }
  ///
  ///Storage box
  static final storageBox = GetStorage();
  ///
  bool initialized = false;
  ///Initiate Get Storage
  Future<void> initGetStorage() async {
    if (initialized) {
      return;
    }
    initialized = true;
    LoggerService.log.v('Initializing Get Storage...');
    await GetStorage.init();
    LoggerService.log.v('Get Storage initialized!');
  }

  void setToken(String? token) {
    LoggerService.log.i('Setting token: $token');
    final storedToken = ReadWriteValue(_accessToken, '');
    if (token == null) {
      LoggerService.log.e('Token is null, setting empty value');
    }
    storedToken.val = token ?? '';
  }

  String getToken() {
    final token = ReadWriteValue(_accessToken, '').val;
    LoggerService.log.i('Token: $token');
    return token;
  }

  void setRefreshToken(String? token) {
    LoggerService.log.i('Setting refresh token: $token');
    final storedToken = ReadWriteValue(_refreshToken, '');
    if (token == null) {
      LoggerService.log.e('Token is null, setting empty value');
    }
    storedToken.val = token ?? '';
  }

  String getRefreshToken() {
    final token = ReadWriteValue(_refreshToken, '').val;
    LoggerService.log.i('Refresh token: $token');
    return token;
  }

  void setFirebaseToken(String? token) {
    final storedToken = ReadWriteValue(_firebaseToken, '');
    storedToken.val = token ?? '';
  }

  String getFirebaseToken() {
    final token = ReadWriteValue(_firebaseToken, '').val;
    return token;
  }

}