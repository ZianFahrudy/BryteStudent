import 'package:bryte/presentation/auth/pages/login_page.dart';
import 'package:bryte/presentation/navigation/navigation.dart';
import 'package:bryte/presentation/auth/pages/forgot_password.dart';
import 'package:bryte/presentation/auth/pages/new_password.dart';

import 'package:get/route_manager.dart';

class Routes {
  static List<GetPage> page = [
    GetPage<void>(
      name: LoginPage.route,
      page: () => const LoginPage(),
      transition: Transition.cupertino,
    ),
    GetPage<void>(
      name: ForgotPassword.route,
      page: () => const ForgotPassword(),
      transition: Transition.cupertino,
    ),
    GetPage<void>(
      name: NewPassword.route,
      page: () => NewPassword(
        username: Get.arguments as String,
      ),
      transition: Transition.cupertino,
    ),
    GetPage<void>(
      name: Navigation.route,
      page: () => const Navigation(),
      transition: Transition.cupertino,
    ),
  ];
}
