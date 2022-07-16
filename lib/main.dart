import 'package:bryte/core/di/injection.dart';
import 'package:bryte/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'components/utils/bloc_observer.dart';

void main() async {
  await GetStorage.init();
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(const App());
}
