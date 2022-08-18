
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../bases/base_controller.dart';


class HomeController extends BaseController {
  late BuildContext context;
  final counter = 1.obs;

  void incrementCounter(){
    counter.value++;
  }


}
