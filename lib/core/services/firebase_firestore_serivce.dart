import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app_c13_mon_7pm/models/event_data_model.dart';

abstract class FirebaseFirestoreService {
  /// [Function] to get collection reference
  static CollectionReference<EventDataModel> getCollectionReference() {
    /// to add a new event to the firestore
    /// need to get the firestore collection

    return FirebaseFirestore.instance
        .collection(EventDataModel.collectionName)
        .withConverter<EventDataModel>(
          fromFirestore: (snapshot, _) =>
              EventDataModel.fromFirestore(snapshot.data()!),
          toFirestore: (data, _) => data.toFirestore(),
        );
  }

  /// [Function] to add a new event to the firestore
  static Future<bool> createNewEvent(EventDataModel data) async {
    try {
      var collectionRef = getCollectionReference();
      var docRef = collectionRef.doc();
      data.eventId = docRef.id;
      docRef.set(data);
      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }
  }

  static Future<List<EventDataModel>> getDataFromFirestore() async {
    var collectionRef = getCollectionReference();
    QuerySnapshot<EventDataModel> data = await collectionRef.get();
    List<EventDataModel> eventsDataList = data.docs.map(
      (element) {
        return element.data();
      },
    ).toList();
    return eventsDataList;
  }

  static Stream<QuerySnapshot<EventDataModel>>
      getStreamFavoriteDataFromFirestore() {
    var collectionRef = getCollectionReference().where(
      "isFavorite",
      isEqualTo: true,
    );
    return collectionRef.snapshots();
  }

  static Stream<QuerySnapshot<EventDataModel>> getStreamDataFromFirestore(
      String eventCategory) {
    var collectionRef = getCollectionReference().where(
      "eventCategory",
      isEqualTo: eventCategory,
    );
    return collectionRef.snapshots();
  }

  static Future<void> updateEvent(EventDataModel eventData) async {
    var collectionRef = getCollectionReference();
    var docRef = collectionRef.doc(eventData.eventId);
    return docRef.update(eventData.toFirestore());
  }

  static deleteEvent(EventDataModel eventData) async {
    var collectionRef = getCollectionReference();
    var docRef = collectionRef.doc(eventData.eventId);
    return docRef.delete();
  }
}
