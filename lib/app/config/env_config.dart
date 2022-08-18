enum Flavor {
  DEVELOPMENT,
  STAGING,
  PRODUCTION,
}

class EnvConfig {
  final Flavor appFlavor;
  String baseUrl = '';

  EnvConfig(this.appFlavor): super() {
    _setUpEnvironmentData();
  }

  void _setUpEnvironmentData() {
    baseUrl = appFlavor == Flavor.STAGING ? ConfigData.STAGING_BASE_URL
        : ConfigData.PRODUCTION_BASE_URL;
  }
}

class ConfigData {
  //TODO - Place-holder - change this to your api url!
  static const STAGING_BASE_URL = 'https://STAGING_BASE_URL.com.vn/';
  static const PRODUCTION_BASE_URL = 'https://PRODUCTION_BASE_URL.xyz.com.vn/';

}