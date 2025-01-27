import 'package:evently_app_c13_mon_7pm/core/theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../../../models/event_category_model.dart';

class TabItemWidget extends StatelessWidget {
  final bool isSelected;
  final EventCategoryModel eventCategoryModel;

  const TabItemWidget({
    super.key,
    required this.isSelected,
    required this.eventCategoryModel,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? ColorPalette.primaryColor : ColorPalette.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ColorPalette.primaryColor
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            eventCategoryModel.eventCategoryIcn,
            color: isSelected ? ColorPalette.white : ColorPalette.primaryColor,
          ),
          const SizedBox(width: 10),
          Text(
            eventCategoryModel.eventCategoryName,
            style: theme.textTheme.titleMedium?.copyWith(
              color:
                  isSelected ? ColorPalette.white : ColorPalette.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
