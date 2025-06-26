import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/views/Authuntication/select_role.dart';
import 'package:palette/views/Authuntication/sign_in_page.dart';
import 'package:palette/views/Intro/splash_page.dart';
import 'package:palette/views/res/colors.dart';

void main() {
  runApp(const MyApp());
}

//hello
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your applicati
  // on.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Palette',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.primary,
            centerTitle: true,
          ),
          scaffoldBackgroundColor: AppColors.backgroundWhite,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
        ),
        home: SelectRolePage());
  }
}

//https://chatgpt.com/c/6833ec25-c594-8010-a818-51ee3c5bec59?model=gpt-4o
