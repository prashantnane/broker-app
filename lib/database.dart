import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addProperty(Map<String, dynamic> infoMap) async {
    try {
      await FirebaseFirestore.instance
          .collection("properties")
          .doc()
          .set(infoMap)
          .then((value) => print("Property Added"));

      return true; // Success
    } catch (error) {
      print('Failed to add property: $error');
      return false; // Failure
    }
  }
}
