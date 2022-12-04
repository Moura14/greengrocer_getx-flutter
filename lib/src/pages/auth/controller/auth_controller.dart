import 'package:get/get.dart';
import 'package:greengrocer/src/constants/storange_keys.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/repository/auth_repository.dart';
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/pages_groce/app_pages.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();
    validateToken();
  }

  Future<void> validateToken() async {
    //Recuperar o token que foi salvo localmente
    String? token = await utilsServices.getLocalData(key: StorangeKeys.token);
    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoutes);
      return;
    }
    AuthResult result = await authRepository.validateToken(token);
    result.when(success: (user) {
      this.user = user;
      saveTokenAndProcedToBase();
    }, error: (message) {
      signOut();
    });
  }

  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }

  Future<void> signOut() async {
    //zerar o user
    user = UserModel();
    //remover o token localmente
    await utilsServices.removeLocalData(key: StorangeKeys.token);

    //Ir para o login
    Get.offAllNamed(PagesRoutes.signInRoutes);
  }

  void saveTokenAndProcedToBase() {
    utilsServices.saveLocalData(key: StorangeKeys.token, data: user.token!);
    Get.offAllNamed(PagesRoutes.baseScrenn);
  }

  Future<void> signUp() async {
    isLoading.value = true;
    AuthResult result = await authRepository.signUp(user);
    isLoading.value = false;
    result.when(success: (user) {
      this.user = user;
      saveTokenAndProcedToBase();
    }, error: (message) {
      utilsServices.showToast(message: message, isError: true);
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    AuthResult result =
        await authRepository.signIn(email: email, password: password);
    isLoading.value = false;

    result.when(success: (user) {
      this.user = user;
      saveTokenAndProcedToBase();
    }, error: (message) {
      utilsServices.showToast(message: message, isError: true);
    });
  }
}
