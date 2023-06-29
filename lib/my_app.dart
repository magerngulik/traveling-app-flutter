// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:healing_apps/data/healing_services/healing_service.dart';
import 'package:healing_apps/logic/login/login_bloc.dart';
import 'package:healing_apps/logic/package/data_package_bloc.dart';
import 'package:healing_apps/screens/user/home/widget/home_page_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_apps/screens/user/login/view/login_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Dio dio = Dio();
    HealingServices services = HealingServices(dioClient: dio);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DataPackageBloc(data: services),
        ),
        BlocProvider(
          create: (context) => LoginBloc(healing: services),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomePageView()),
    );
  }
}
