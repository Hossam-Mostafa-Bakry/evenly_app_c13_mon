import 'package:flutter/material.dart';

import '../../../../core/theme/color_palette.dart';
import '../../../../models/event_category_model.dart';

class CategoryTabItem extends StatelessWidget {
  final bool isSelected;
  final EventCategoryModel eventCategoryModel;

  const CategoryTabItem({
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
          color: isSelected ? ColorPalette.white : ColorPalette.primaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorPalette.white)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            eventCategoryModel.eventCategoryIcn,
            color: !isSelected ? ColorPalette.white : ColorPalette.primaryColor,
          ),
          const SizedBox(width: 10),
          Text(
            eventCategoryModel.eventCategoryName,
            style: theme.textTheme.titleMedium?.copyWith(
              color:
                  !isSelected ? ColorPalette.white : ColorPalette.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
