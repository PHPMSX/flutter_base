class CoreRemoteConstants {
  static String baseUrl = '';
  static String imagePath = '';

  static String mqttServerUrl = '';

  static String errorMessageFieldKey = 'errorMessage';
  static String connectionErrorMessage = 'Không thể kết nối tới server!';
  static String sessionExpiredErrorMessage = 'Access Forbidden - Token invalid!';

  ///Refresh token end point
  static String refreshTokenEndPoint = 'access/refresh-token';

  ///Params for refresh token API
  static String accessTokenParamKey = 'accessToken';
  static String refreshTokenParamKey = 'refreshToken';
  static String deviceTokenParamKey = 'deviceToken';
  ///Access token key in API header
  static const String accessTokenHeaderKey = 'x-access-token';

  static int timeOutDurationInMilliseconds = 30000;

  static const String acceptLanguageHeaderKey = 'Accept-Language';
  static const String acceptVersionHeaderKey = 'Accepts-Version';
  static const String acceptAppVersionHeaderKey = 'Accepts-App-Version';
  static const String acceptPlatformHeaderKey = 'Accepts-Platform';
  static const String acceptDatetimeHeaderKey = 'Accept-Datetime';
}

class RequestConstants {
  static int pageLimit = 20;
}

class CoreHTTPMethod {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
  static const String patch = 'PATCH';
}

class CoreHttpCode {
  static int OK = 200;
  static int TOKEN_INVALID = 401;
  static int TOKEN_EXPIRED = 423;
}
