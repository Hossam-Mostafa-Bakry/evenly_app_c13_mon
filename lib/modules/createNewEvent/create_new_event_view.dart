import 'package:evently_app_c13_mon_7pm/core/extensions/extensions.dart';
import 'package:evently_app_c13_mon_7pm/core/services/firebase_firestore_serivce.dart';
import 'package:evently_app_c13_mon_7pm/core/services/snack_bar_service.dart';
import 'package:evently_app_c13_mon_7pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_mon_7pm/core/widgets/custom_text_field.dart';
import 'package:evently_app_c13_mon_7pm/models/event_category_model.dart';
import 'package:evently_app_c13_mon_7pm/models/event_data_model.dart';
import 'package:evently_app_c13_mon_7pm/modules/createNewEvent/widgets/tab_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class CreateNewEventView extends StatefulWidget {
  const CreateNewEventView({super.key});

  @override
  State<CreateNewEventView> createState() => _CreateNewEventViewState();
}

class _CreateNewEventViewState extends State<CreateNewEventView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? selectedDate;
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
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Event"),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(
                        eventCategoriesList[selectedTapIndex].eventCategoryImg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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

                      return TabItemWidget(
                        isSelected: selectedTapIndex ==
                            eventCategoriesList.indexOf(item),
                        eventCategoryModel: item,
                      );
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Title",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 5),
              CustomTextField(
                controller: _titleController,
                hint: "Event Title",
                hintColor: ColorPalette.generalGreyColor,
                prefixIcon: Icon(
                  Icons.edit_note_outlined,
                  color: ColorPalette.generalGreyColor,
                ),
                onValidate: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "plz enter title";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Text(
                "Description",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 5),
              CustomTextField(
                controller: _descriptionController,
                hint: "Event Description",
                hintColor: ColorPalette.generalGreyColor,
                maxLines: 3,
                onValidate: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "plz enter description";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Event Date",
                    style: theme.textTheme.titleMedium,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      choseEventDate();
                    },
                    child: Text(
                      selectedDate == null
                          ? "Choose Date"
                          : DateFormat("dd MMM yyy").format(selectedDate!),
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: ColorPalette.primaryColor),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Location",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: const BorderSide(
                            color: ColorPalette.primaryColor))),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorPalette.primaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(
                        Icons.my_location_sharp,
                        color: ColorPalette.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Choose Event Location",
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: ColorPalette.primaryColor),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: ColorPalette.primaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (selectedDate != null) {
                      var data = EventDataModel(
                        eventTitle: _titleController.text,
                        eventImage: eventCategoriesList[selectedTapIndex]
                            .eventCategoryImg,
                        eventDescription: _descriptionController.text,
                        eventCategory: eventCategoriesList[selectedTapIndex]
                            .eventCategoryName,
                        eventDate: selectedDate!,
                      );
                      EasyLoading.show();
                      FirebaseFirestoreService.createNewEvent(data).then(
                        (value) {
                          EasyLoading.dismiss();
                          if (value) {
                            SnackBarService.showSuccessMessage(
                                "Event created successfully");
                            Navigator.pop(context);
                          }
                        },
                      );
                    } else {
                      SnackBarService.showErrorMessage("Select Date First");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  elevation: 0,
                  backgroundColor: ColorPalette.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: const BorderSide(
                      color: ColorPalette.primaryColor,
                    ),
                  ),
                ),
                child: Text(
                  "Add Event",
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: ColorPalette.white),
                ),
              ),
            ],
          ).setHorizontalPadding(context, 0.03),
        ),
      ),
    );
  }

  void choseEventDate() async {
    DateTime? currentDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(
          days: 365,
        ),
      ),
    );

    setState(() {
      selectedDate = currentDate;
    });
  }
}
