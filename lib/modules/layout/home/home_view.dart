import 'package:evently_app_c13_mon_7pm/core/extensions/padding_ext.dart';
import 'package:evently_app_c13_mon_7pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_mon_7pm/modules/layout/home/widgets/event_card_item.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: mediaQuery.size.height * 0.25,
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            decoration: const BoxDecoration(
              color: ColorPalette.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back ✨",
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: ColorPalette.white,
                          ),
                        ),
                        Text(
                          "John Safwat",
                          style: theme.textTheme.headlineSmall?.copyWith(
                              color: ColorPalette.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: ColorPalette.white,
                              size: 22,
                            ),
                            Text(
                              "Welcome Back ✨",
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: ColorPalette.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.wb_sunny_outlined,
                          size: 24,
                          color: ColorPalette.white,
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 35,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorPalette.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            "EN",
                            style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ).setHorizontalPadding(context, 0.03),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => EventCardItem(),
            separatorBuilder: (context, index) => SizedBox(height: 10,),
            itemCount: 5,
          ).setHorizontalPadding(context, 0.03),
        ],
      ),
    );
  }
}
