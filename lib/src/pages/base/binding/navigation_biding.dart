import 'package:get/get.dart';
import 'package:greengrocer/src/pages/base/controller/navigation_controller.dart';

class NavigationBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
  }
}
