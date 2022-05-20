import 'package:bryte/components/routes/routes.dart';
import 'package:bryte/components/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../components/utils/constant.dart';
import 'auth/pages/signin.dart';
import 'navigation/navigation.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = box.hasData(KeyConstant.token);
    final routeObserver = Get.put<RouteObserver>(RouteObserver<PageRoute>());

    String initialRoute() {
      if (isLogin) {
        return Navigation.route;
      } else {
        return Signin.route;
      }
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      title: 'Bryte',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              color: Palette.headerSpecial,
              iconTheme: IconThemeData(color: Palette.darkPurple)),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.purple,
          primaryColor: Palette.darkPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: initialRoute(),
      navigatorObservers: [routeObserver],
      getPages: Routes.page.map((page) => page).toList(),
    );
  }
}
