import 'package:flutter/material.dart';

import '../../../../core/theme/color_palette.dart';

class EventCardItem extends StatelessWidget {
  const EventCardItem({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: 200,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: ColorPalette.primaryColor, width: 1.5),
        image: const DecorationImage(
          image: AssetImage("assets/images/birthday_img.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 45,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: ColorPalette.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              "21 Jan",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge
                  ?.copyWith(height: 1, color: ColorPalette.primaryColor),
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
              color: ColorPalette.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Meeting for Updating The Development Method The Development Method ",
                    textAlign: TextAlign.start,
                    style: theme.textTheme.titleSmall?.copyWith(
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(
                  Icons.favorite_border_outlined,
                  color: ColorPalette.primaryColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
