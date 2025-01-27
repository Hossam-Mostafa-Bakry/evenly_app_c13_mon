import 'package:evently_app_c13_mon_7pm/core/routes/page_routes_name.dart';
import 'package:evently_app_c13_mon_7pm/modules/createNewEvent/create_new_event_view.dart';
import 'package:evently_app_c13_mon_7pm/modules/layout/layout_view.dart';
import 'package:evently_app_c13_mon_7pm/modules/onBoarding/on_boarding_view.dart';
import 'package:evently_app_c13_mon_7pm/modules/signIn/sign_in_view.dart';
import 'package:evently_app_c13_mon_7pm/modules/signUp/sign_up_view.dart';
import 'package:evently_app_c13_mon_7pm/modules/splash/splash_view.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static Route<dynamic> onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRoutesName.initial:
        {
          return MaterialPageRoute(
            builder: (context) => const LayoutView(),
            // builder: (context) => const SplashView(),
            settings: settings,
          );
        }

      case PageRoutesName.onBoarding:
        {
          return MaterialPageRoute(
            builder: (context) => const OnBoardingView(),
            settings: settings,
          );
        }

      case PageRoutesName.signIn:
        {
          return MaterialPageRoute(
            builder: (context) => const SignInView(),
            settings: settings,
          );
        }

      case PageRoutesName.signUp:
        {
          return MaterialPageRoute(
            builder: (context) => const SignUpView(),
            settings: settings,
          );
        }
      case PageRoutesName.layout:
        {
          return MaterialPageRoute(
            builder: (context) => const LayoutView(),
            settings: settings,
          );
        }

      case PageRoutesName.createNewEvent:
        {
          return MaterialPageRoute(
            builder: (context) => const CreateNewEventView(),
            settings: settings,
          );
        }

      default:
        {
          return MaterialPageRoute(
            builder: (context) => const SplashView(),
            settings: settings,
          );
        }
    }
  }
}
