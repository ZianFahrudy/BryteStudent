import 'package:bryte/core/di/injection.dart';
import 'package:bryte/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get_storage/get_storage.dart';
import 'components/utils/bloc_observer.dart';

void main() async {
  await GetStorage.init();
  configureDependencies();
  // Plugin must be initialized before using
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
  Bloc.observer = MyBlocObserver();
  runApp(const App());
}
