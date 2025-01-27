import 'dart:async';

import 'package:evently_app_c13_mon_7pm/core/constants/app_assets.dart';
import 'package:evently_app_c13_mon_7pm/core/routes/page_routes_name.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushNamed(
        context,
        PageRoutesName.signIn,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.eventlyLogo,
              height: mediaQuery.height * 0.24,
            ),
          ],
        ),
      ),
    );
  }
}
