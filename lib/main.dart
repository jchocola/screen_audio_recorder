import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:recorder_app/core/constant/app_constant.dart';
import 'package:recorder_app/core/theme/app_theme.dart';
import 'package:recorder_app/feature/main/presentation/main_page.dart';
import 'package:recorder_app/feature/recorder/bloc/recorder_bloc.dart';

final logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ru'), Locale('vi')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      assetLoader: JsonAssetLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => RecorderBloc())],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Simple Recoder',
        theme: appTheme,
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppConstant.appPadding),
        child: Column(mainAxisAlignment: .center, children: [MainPage()]),
      ),
    );
  }
}
