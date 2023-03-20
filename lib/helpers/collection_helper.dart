import 'package:author_firebase/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionHelper {
  static CollectionHelper instence = CollectionHelper();
  CollectionReference register = FirebaseFirestore.instance.collection('register');


  insert() async {
    return register.add({
      "author": Global.author,
      "book": Global.book
    });
  }
}