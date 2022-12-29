import 'dart:developer';

import 'package:bryte/presentation/app.dart';
import 'package:fl_downloader/fl_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'components/utils/bloc_observer.dart';
import 'core/di/injection.dart';
import 'flavors.dart';

void main() async {
  F.appFlavor = Flavor.staging;
  await GetStorage.init();
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();

  FlDownloader.initialize();
  Bloc.observer = MyBlocObserver();
  log(F.name, name: 'FLAVOR NAME');
  log(F.apiUrl, name: 'API URL');

  runApp(const App());
}
