import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app_c13_mon_7pm/core/extensions/padding_ext.dart';
import 'package:evently_app_c13_mon_7pm/core/services/firebase_firestore_serivce.dart';
import 'package:evently_app_c13_mon_7pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_mon_7pm/models/event_data_model.dart';
import 'package:evently_app_c13_mon_7pm/modules/layout/home/widgets/category_tab_item.dart';
import 'package:evently_app_c13_mon_7pm/modules/layout/home/widgets/event_card_item.dart';
import 'package:flutter/material.dart';

import '../../../models/event_category_model.dart';
import '../../createNewEvent/widgets/tab_item_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedTapIndex = 0;
  List<EventCategoryModel> eventCategoriesList = <EventCategoryModel>[
    EventCategoryModel(
      eventCategoryName: "Book Club",
      eventCategoryIcn: Icons.menu_book_outlined,
      eventCategoryImg: "assets/images/book_club_img.png",
    ),
    EventCategoryModel(
        eventCategoryName: "Sport",
        eventCategoryIcn: Icons.directions_bike,
        eventCategoryImg: "assets/images/sport_img.png"),
    EventCategoryModel(
        eventCategoryName: "BirthDay",
        eventCategoryIcn: Icons.cake_outlined,
        eventCategoryImg: "assets/images/birthday_img.png"),
    EventCategoryModel(
        eventCategoryName: "Meeting",
        eventCategoryIcn: Icons.meeting_room_outlined,
        eventCategoryImg: "assets/images/meeting_img.png"),
    EventCategoryModel(
        eventCategoryName: "Holiday",
        eventCategoryIcn: Icons.holiday_village_outlined,
        eventCategoryImg: "assets/images/holiday_img.png"),
  ];

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
                DefaultTabController(
                  length: eventCategoriesList.length,
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 6.0),
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    indicator: const BoxDecoration(),
                    onTap: (index) {
                      setState(() {
                        selectedTapIndex = index;
                      });
                    },
                    tabs: eventCategoriesList.map(
                      (item) {
                        // selectedTap --> the current selected
                        // each element --> index

                        return CategoryTabItem(
                          isSelected: selectedTapIndex ==
                              eventCategoriesList.indexOf(item),
                          eventCategoryModel: item,
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot<EventDataModel>>(
            stream: FirebaseFirestoreService.getStreamDataFromFirestore(
                eventCategoriesList[selectedTapIndex].eventCategoryName),
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
          // FutureBuilder<List<EventDataModel>>(
          //   future: FirebaseFirestoreService.getDataFromFirestore(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasError) {
          //       return const Text(
          //         "Something went wrong",
          //       );
          //     }
          //
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(
          //         child: CircularProgressIndicator(
          //           color: ColorPalette.primaryColor,
          //         ),
          //       );
          //     }
          //
          //     List<EventDataModel> eventsDataList = snapshot.data ?? [];
          //
          //     return eventsDataList.isEmpty
          //         ? const Text("No Events Created Yet")
          //         : ListView.separated(
          //             shrinkWrap: true,
          //             physics: const NeverScrollableScrollPhysics(),
          //             itemBuilder: (context, index) => EventCardItem(
          //               eventDataModel: eventsDataList[index],
          //             ),
          //             separatorBuilder: (context, index) => const SizedBox(
          //               height: 10,
          //             ),
          //             itemCount: eventsDataList.length,
          //           ).setHorizontalPadding(context, 0.03);
          //   },
          // ),
        ],
      ),
    );
  }
}
