import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:evently_app_c13_mon_7pm/core/extensions/padding_ext.dart';
import 'package:evently_app_c13_mon_7pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_mon_7pm/modules/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);

    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    return Column(
      children: [
        Container(
          height: mediaQuery.size.height * 0.22,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: ColorPalette.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(84.0),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 125,
                width: 125,
                decoration: const BoxDecoration(
                    color: ColorPalette.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(100.0),
                      bottomLeft: Radius.circular(100.0),
                      topRight: Radius.circular(100.0),
                      topLeft: Radius.circular(4.0),
                    ),
                    image: DecorationImage(
                        image: AssetImage("assets/icons/route_logo.png"))),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hossam Bakry",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "hossam.mostafa.bakry@gmail.com",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Language",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            CustomDropdown<String>(
              hintText: provider.currentLanguage == "en" ? "English" : "عربي",
              items: provider.languages,
              onChanged: (value) {
                if (value == "English") provider.setNewLanguage("en");
                if (value != "English") provider.setNewLanguage("ar");
              },
              decoration: CustomDropdownDecoration(
                  closedSuffixIcon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 28,
                    color: ColorPalette.primaryColor,
                  ),
                  closedBorderRadius: BorderRadius.circular(18.0),
                  closedBorder: Border.all(
                    color: ColorPalette.primaryColor,
                    width: 1.8,
                  )),
            ),
            const SizedBox(height: 20),
            Text(
              "Theme Mode",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            CustomDropdown<String>(
              hintText: provider.isDark() ? "Dark" : "Light",
              items: provider.themes,
              onChanged: (value) {
                if (value == "Dark") provider.setNewTheme(ThemeMode.dark);
                if (value == "Light") provider.setNewTheme(ThemeMode.light);
              },
              decoration: CustomDropdownDecoration(
                  closedSuffixIcon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 28,
                    color: ColorPalette.primaryColor,
                  ),
                  closedBorderRadius: BorderRadius.circular(18.0),
                  closedBorder: Border.all(
                    color: ColorPalette.primaryColor,
                    width: 1.8,
                  )),
            )
          ],
        ).setHorizontalPadding(context, 0.045),
      ],
    );
  }
}
