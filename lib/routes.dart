import 'package:bryte/pages/auth/pages/forgot_password.dart';
import 'package:bryte/pages/auth/pages/new_password.dart';
import 'package:bryte/pages/auth/pages/otp_password.dart';
import 'package:bryte/pages/navigation.dart';

import 'package:get/route_manager.dart';

import 'pages/auth/pages/signin.dart';

// class RouteGenerator {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//         return MaterialPageRoute(builder: (context) => const Splash());
//       case 'Signin':
//         return MaterialPageRoute(
//             builder: (context) => const Signin(
//                   isresetPass: false,
//                 ));
//       case 'Dashboard':
//         return MaterialPageRoute(builder: (context) => const DashboardPage());
//       case 'ForgoPassword':
//         return MaterialPageRoute(builder: (context) => const ForgotPassword());
//       case 'NewPassword':
//         return MaterialPageRoute(
//             builder: (context) => const NewPassword(
//                   username: '',
//                 ));
//       case 'OtpPassword':
//         return MaterialPageRoute(
//             builder: (context) => const OtpPassword(
//                   email: '',
//                   username: '',
//                 ));
//       default:
//         return MaterialPageRoute(builder: (context) => const Splash());
//     }
//   }
// }

class Routes {
  static List<GetPage> page = [
    // GetPage<void>(
    //   name: DashboardPage.route,
    //   page: () => const DashboardPage(),
    //   transition: Transition.cupertino,
    // ),
    GetPage<void>(
      name: Signin.route,
      page: () => const Signin(),
      transition: Transition.cupertino,
    ),
    GetPage<void>(
      name: ForgotPassword.route,
      page: () => const ForgotPassword(),
      transition: Transition.cupertino,
    ),
    GetPage<void>(
      name: Signin.route,
      page: () => OtpPassword(
        email: Get.arguments as String,
        username: Get.arguments as String,
      ),
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
