import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/Add_Restaurant.dart';
import 'package:vendor/HomeScreen.dart';
import 'package:vendor/controller/language_change_controller.dart';
import 'SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();

  LanguageChangeController languageController = LanguageChangeController();
  await languageController.loadLanguage(); // Load the selected language

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => languageController),
      ],
      child: Consumer<LanguageChangeController>(
        builder: (context, provider, child) {
          return MaterialApp(
            locale: provider.appLocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          );
        },
      ),
    ),
  );
}

