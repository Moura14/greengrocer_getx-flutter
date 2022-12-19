import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/cart/repository/cart_repository.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();

    getCartitems();
  }

  Future<void> getCartitems() async {
    await cartRepository.getCartitems(
        token: authController.user.token!, userId: authController.user.id!);
  }
}
