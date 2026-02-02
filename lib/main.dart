import 'package:flutter/material.dart';
import 'package:recorder_app/core/constant/app_constant.dart';
import 'package:recorder_app/core/theme/app_theme.dart';
import 'package:recorder_app/feature/menu/presentation/menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo',theme: appTheme, home: HomePage(), debugShowCheckedModeBanner: false,);
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppConstant.appPadding),
        child: Column(mainAxisAlignment: .center, children: [MenuPage()]),
      ),
    );
  }
}
