

import 'app/config/env_config.dart';
import 'main_utils.dart';

void main() async {
  await MainUtils().initServices(flavor: Flavor.STAGING);

}
