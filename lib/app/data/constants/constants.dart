import '../../config/env_config.dart';

class AppConstants {
  static Flavor currentFlavor = Flavor.DEVELOPMENT;
  static final REGEX_CONVERT_VN_TO_ENG_WORD = RegExp(r'(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)|(ê|ề|ế|ệ|ể|ễ|è|é|ẹ|ẻ|ẽ)|(ì|í|ị|ỉ|ĩ)|(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)|(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)|(ỳ|ý|ỵ|ỷ|ỹ)|(đ)');


}