import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';

import '../component/ModelClass.dart';
class Helper {
  static Helper instance = Helper();
  CollectionReference author = FirebaseFirestore.instance.collection('Authors');

  insertData(AuthorModel authorModel) async {
    return author
        .add(authorModel.toMap())
        .then((value) => print("Note Added.."))
        .catchError((error) => print("Failed to add Note: $error"));
  }
  deleteData({required int index}) async {
    var docSnap = await author.get();
    var doc_id = docSnap.docs;
    return author
        .doc(doc_id[index].id)
        .delete()
        .then((value) => print("note Deleted.."))
        .catchError((error) => print("Failed to delete note: $error"));
  }
}