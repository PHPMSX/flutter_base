import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/logger/logger_service.dart';
import 'app/utils/translated_string.dart';

class MainApp extends StatelessWidget with WidgetsBindingObserver {
  const MainApp({Key? key}) : super(key: key);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        LoggerService.log.i('App resume');
        break;
      case AppLifecycleState.inactive:
        LoggerService.log.i('App in inactive');
        break;
      case AppLifecycleState.paused:
        LoggerService.log.i('App in paused');
        break;
      case AppLifecycleState.detached:
        LoggerService.log.i('App in detached');
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);
    return GetMaterialApp(
      title: "Base GetX",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('vi', 'VN'),
      ],
      ///Set up for localization
      translations: TranslatedString(),
      locale: const Locale('vi', 'VN'),
      fallbackLocale: const Locale('vi', 'VN'),
      debugShowCheckedModeBanner: true,
    );
  }
}

