import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:game_box/app_home.dart';
import 'package:game_box/core/presentation/entities/locale.entity.dart';
import 'package:game_box/features/tetris/presentation/tetris.widget.dart';
import 'package:game_box/generated/codegen_loader.g.dart';
import 'package:game_box/generated/locale_keys.g.dart';
import 'package:game_box/routing/routing.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale(LocaleEnum.eng.value), Locale(LocaleEnum.ru.value)],
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
      fallbackLocale: Locale(sharedPreferences.getString('locale') ?? LocaleEnum.eng.value),
      child: const MyApp(),
    ),
  );
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: routes,
    );
  }
}
