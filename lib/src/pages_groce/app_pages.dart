import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/view/sign_in_screen.dart';
import 'package:greengrocer/src/pages/auth/view/sign_up_screen.dart';
import 'package:greengrocer/src/pages/base/base_screen.dart';
import 'package:greengrocer/src/pages/base/binding/navigation_biding.dart';
import 'package:greengrocer/src/pages/cart/binding/cart_binding.dart';
import 'package:greengrocer/src/pages/home/bilding/home_blinding.dart';
import 'package:greengrocer/src/pages/product/product_screen.dart';
import 'package:greengrocer/src/pages/splash/splash_screen.dart';

import '../pages/orders/binding/order_binding.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(name: PagesRoutes.productRoutes, page: () => ProductScreen()),
    GetPage(name: PagesRoutes.splashScreen, page: () => const SplashScreen()),
    GetPage(name: PagesRoutes.signInRoutes, page: () => SignInScreen()),
    GetPage(name: PagesRoutes.signUp, page: () => SignUpScreen()),
    GetPage(
      name: PagesRoutes.baseScrenn,
      bindings: [
        NavigationBiding(),
        HomeBinding(),
        CartBinding(),
        OrderBinding()
      ],
      page: (() => const BaseScreen()),
    )
  ];
}

abstract class PagesRoutes {
  static const String signInRoutes = '/signIn';
  static const String productRoutes = '/products';
  static const String signUp = '/signup';
  static const String splashScreen = '/splash';
  static const String baseScrenn = '/';
}
