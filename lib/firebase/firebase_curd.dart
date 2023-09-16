import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/response_model.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
final CollectionReference _collection =
    _fireStore.collection('flutter-students');

class FirebaseCrud {
  /// To add user detail in fire store database
  static Future<Response> addUser({
    required Map<String, dynamic> req,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc(req["contact_no"]);

    Map<String, dynamic> data = req;

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Successfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  /// To get user detail in fire store database
  static Stream<QuerySnapshot> readUser() {
    CollectionReference notesItemCollection = _collection;

    return notesItemCollection.snapshots();
  }

  /// To delete user detail in fire store database
  static Future<Response> deleteUser({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Successfully Deleted User";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
