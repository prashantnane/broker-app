import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebroker/data/model/property_model.dart';

Future<void> fetchData() async {
  // Reference to the collection
  CollectionReference users = FirebaseFirestore.instance.collection('all_properties');

  try {
    // Get documents from the collection
    QuerySnapshot querySnapshot = await users.get();

    // Iterate over the documents and access data
    querySnapshot.docs.forEach((doc) {
      // print('User ID: ${doc.id}, Title: ${doc['title']}, Email: ${doc['email']}');
    });
  } catch (e) {
    print('Error fetching data: $e');
  }
}

Future addSampleProperty(PropertyModel property) async {
  try {
    // Reference to the collection
    CollectionReference properties = FirebaseFirestore.instance.collection('all_properties');

    // Convert Property object to a map
    Map<String, dynamic> propertyData = property.toMap();

    // Add the data to Firestore
    await properties.add(propertyData);

    print("Property Added");

    return true; // Success
  } catch (error) {
    print('Failed to add property: $error');
    return false; // Failure
  }
}
