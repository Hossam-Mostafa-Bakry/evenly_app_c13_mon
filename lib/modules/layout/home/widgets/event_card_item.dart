import 'package:evently_app_c13_mon_7pm/core/services/firebase_firestore_serivce.dart';
import 'package:evently_app_c13_mon_7pm/models/event_data_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/color_palette.dart';

class EventCardItem extends StatelessWidget {
  final EventDataModel eventDataModel;

  const EventCardItem({
    super.key,
    required this.eventDataModel,
  });

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
        image: DecorationImage(
          image: AssetImage(eventDataModel.eventImage),
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
              DateFormat("dd MMM").format(eventDataModel.eventDate),
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
                    eventDataModel.eventTitle,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.titleSmall?.copyWith(
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    var eventData = EventDataModel(
                      eventId: eventDataModel.eventId,
                      eventTitle: eventDataModel.eventTitle,
                      eventImage: eventDataModel.eventImage,
                      eventDescription: eventDataModel.eventDescription,
                      eventCategory: eventDataModel.eventCategory,
                      eventDate: eventDataModel.eventDate,
                      isFavorite: !eventDataModel.isFavorite,
                    );

                    FirebaseFirestoreService.updateEvent(eventData);
                  },
                  child: Icon(
                    eventDataModel.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: ColorPalette.primaryColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
