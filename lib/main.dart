import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cardeal/app_cache.dart';
import 'package:flutter_cardeal/constants.dart';
import 'package:flutter_cardeal/cubit/app_cubit.dart';
import 'package:flutter_cardeal/dio_helper.dart';
import 'package:flutter_cardeal/search_screen.dart';

import 'components/components.dart';
import 'login_screen.dart';
import 'main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getCategories()
        ..getCars()
        ..getMyCars()
        ..getBuyRequest(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: snackbarKey,
        theme: ThemeData(
          primarySwatch: getMaterialColor(Colors.black),
        ),
        home: LoginScreen(),
      ),
    );
  }
}
