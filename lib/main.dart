import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'core/services/loading_service.dart';
import 'firebase_options.dart';

import '/core/routes/app_routes.dart';
import '/core/theme/app_theme_manager.dart';

/// 1- Localization
/// 2- Theme Mode
/// 3- State Management [ Provider ] --> Change Notifier [ observer pattern, singleton patterns]

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());

  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeManager.lightThemeData,
      darkTheme: AppThemeManager.darkThemeData,
      themeMode: ThemeMode.light,
      onGenerateRoute: AppRoutes.onGeneratedRoute,
      builder: EasyLoading.init(builder: BotToastInit()),
    );
  }
}
