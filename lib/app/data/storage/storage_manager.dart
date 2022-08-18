
import 'dart:convert';

import 'package:get_storage/get_storage.dart';


import '../../utils/logger/logger_service.dart';

class StorageManager {
  ///Keys
  static const _baseUrl = '_baseUrl';
  static const _configData = '_appConfig';
  ///User data
  static const _userData = '_userData';
  ///Is logged in
  static const _isLoggedIn = '_isLoggedIn';
  ///App Device
  static const _appDevice = '_appDevice';
  ///

  /// theme
  static const _isDarkMode = '_isDarkMode';


  static const _pauseOverlayVisible = '_pauseOverlayVisible';

  static const _oldGoogleMapsKey = '_vietCreditOldGoogleMapsKey';
  static const _googleMapsKey = '_vietCreditGoogleMapsKey';

  ///
  ///Constructors
  static final StorageManager _instance = StorageManager._internal();

  StorageManager._internal();

  factory StorageManager() {
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
    LoggerService.log.v('Initializing App Storage...');
    await GetStorage.init();
    LoggerService.log.v('App Storage initialized!');
  }

  /// Theme mode
  bool getThemeMode() {
    final themMode = ReadWriteValue(_isDarkMode, false).val;
    return themMode;
  }

  void setThemeMode(bool isDarkMode) {
    final storeThemeMode = ReadWriteValue(_isDarkMode, false);
    storeThemeMode.val = isDarkMode;
  }

  void setBaseUrl(String? url) {
    final storedBaseUrl = ReadWriteValue(_baseUrl, '');
    storedBaseUrl.val = url ?? '';
  }

  String getBaseUrl() {
    final baseUrl = ReadWriteValue(_baseUrl, '').val;
    return baseUrl;
  }



  ///
  ///Is logged in
  void setIsLoggedIn({required bool isLoggedIn}) {
    final storedIsLoggedIn = ReadWriteValue(_isLoggedIn, false);
    storedIsLoggedIn.val = isLoggedIn;
  }

  bool getIsLoggedIn() {
    return ReadWriteValue(_isLoggedIn, false).val;
  }
  ///


  void setPauseOverlayVisible({required bool visible}) {
    final storedVisible = ReadWriteValue(_pauseOverlayVisible, false);
    storedVisible.val = visible;
  }

  bool getPauseOverlayVisible() {
    return ReadWriteValue(_pauseOverlayVisible, false).val;
  }

  void setOldGoogleMapsKey(String? key) {
    final storedKey = ReadWriteValue(_oldGoogleMapsKey, '');
    storedKey.val = key ?? '';
  }

  String getOldGoogleMapsKey() {
    return ReadWriteValue(_oldGoogleMapsKey, '').val;
  }

  void setGoogleMapsKey(String? key) {
    final storedKey = ReadWriteValue(_googleMapsKey, '');
    storedKey.val = key ?? '';
  }

  String getGoogleMapsKey() {
    return ReadWriteValue(_googleMapsKey, '').val;
  }
}
