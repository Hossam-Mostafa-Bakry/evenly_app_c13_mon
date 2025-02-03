import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app_c13_mon_7pm/core/extensions/extensions.dart';
import 'package:evently_app_c13_mon_7pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_mon_7pm/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../../../core/services/firebase_firestore_serivce.dart';
import '../../../models/event_data_model.dart';
import '../home/widgets/event_card_item.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        CustomTextField(
          hint: "Search for Event",
          hintColor: ColorPalette.generalGreyColor,
          prefixIcon: Icon(Icons.search),
        ).setHorizontalPadding(context, 0.03),
        StreamBuilder<QuerySnapshot<EventDataModel>>(
          stream: FirebaseFirestoreService.getStreamFavoriteDataFromFirestore(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text(
                "Something went wrong",
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorPalette.primaryColor,
                ),
              );
            }

            List<EventDataModel> eventsDataList = snapshot.data!.docs.map(
              (e) {
                return e.data();
              },
            ).toList();

            return eventsDataList.isEmpty
                ? const Text("No Events Created Yet")
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => EventCardItem(
                      eventDataModel: eventsDataList[index],
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: eventsDataList.length,
                  ).setHorizontalPadding(context, 0.03);
          },
        ),
        // Expanded(
        //   child: ListView.separated(
        //     itemBuilder: (context, index) => EventCardItem(),
        //     separatorBuilder: (context, index) => SizedBox(
        //       height: 10,
        //     ),
        //     itemCount: 5,
        //   ).setHorizontalPadding(context, 0.03),
        // ),
      ],
    );
  }
}
