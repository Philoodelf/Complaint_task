import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:report_task/core/api/api_consumer.dart';
import 'package:report_task/core/api/dio_consumer.dart';
import 'complaint/screens/description.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/usercubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/lang',
    fallbackLocale: const Locale('en'),
    child: BlocProvider(
      create: (context) => UserCubit(DioConsumer(dio: Dio()) as ApiConsumer),
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 232, 232, 232),
            foregroundColor: Colors.white //here you can give the text color
            ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Description(
        title: '',
      ),
    );
  }
}
