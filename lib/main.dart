import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app_c13_mon_7pm/modules/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'core/services/loading_service.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/core/routes/app_routes.dart';
import '/core/theme/app_theme_manager.dart';

/// 1- Localization
/// 2- Theme Mode
/// 3- State Management [ Provider ] --> Change Notifier [ observer pattern, singleton patterns]

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // disableOfflinePersistence();

  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const MyApp(),
    ),
  );

  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeManager.lightThemeData,
      darkTheme: AppThemeManager.darkThemeData,
      themeMode: provider.currentThemeMode,
      locale: Locale(provider.currentLanguage),
      navigatorKey: navigatorKey,
      onGenerateRoute: AppRoutes.onGeneratedRoute,
      builder: EasyLoading.init(builder: BotToastInit()),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

void disableOfflinePersistence() async {
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: false,
  );
}
