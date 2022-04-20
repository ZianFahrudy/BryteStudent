import 'package:bryte/core/di/injection.dart';
import 'package:bryte/pages/auth/pages/signin.dart';
import 'package:bryte/pages/navigation.dart';
import 'package:bryte/routes.dart';
import 'package:bryte/theme.dart';
import 'package:bryte/utils/bloc_observer.dart';
import 'package:bryte/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/auth/auth_bloc.dart';
import 'core/repo/auth/auth_repository.dart';

void main() async {
  await GetStorage.init();
  configureDependencies();
  // FlutterNativeSplash.remove();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final box = GetStorage();
  // final dio = Dio();
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
    AuthRepository apiRepository = AuthRepository();

    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(apiRepository),
          ),
        ],
        child: GetMaterialApp(
          title: 'Bryte',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                  color: bryteDarkPurple,
                  iconTheme: IconThemeData(color: bryteDarkPurple)),
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.green,
              primaryColor: bryteDarkPurple,
              visualDensity: VisualDensity.adaptivePlatformDensity),
          initialRoute: initialRoute(),
          navigatorObservers: [routeObserver],
          getPages: Routes.page.map((page) => page).toList(),
        ));
  }
}
