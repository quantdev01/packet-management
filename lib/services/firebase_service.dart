import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final db = FirebaseFirestore.instance;

  Future<void> registerClient({
    required String clientName,
    required String ltaNumber,
    required String totalToPay,
  }) async {
    try {
      await db.collection('clients').doc(clientName).set(
        {
          'name': clientName,
          'lta_number': ltaNumber,
          'total_to_pay': totalToPay,
          'created_at': Timestamp.now(),
          'modified_at': Timestamp.now(),
        },
      );
    } on FirebaseException catch (e) {
      log('This happened');
      log(e.toString());
    }
  }

  Future<void> updateWeight({
    required String newWeight,
    required String clientName,
  }) async {
    try {
      await db.collection('clients').doc(clientName).update(
        {
          'total_to_pay': newWeight,
        },
      );
    } on FirebaseException catch (e) {
      log('This happened');
      log(e.toString());
    }
  }

  Future<void> addProductToClient(
    Map<String, dynamic> productData,
    String clientName,
  ) async {
    try {
      DocumentReference clientDocRef = db.collection('clients').doc(clientName);
      CollectionReference productSubCollection =
          clientDocRef.collection('products');
      await productSubCollection.add(productData);

      log('Products added');
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  Future<double?> getTotal(String clientName) async {
    try {
      // Reference the document for the given clientName in the 'clients' collection
      DocumentReference<Map<String, dynamic>> clientData =
          FirebaseFirestore.instance.collection('clients').doc(clientName);

      // Get the document snapshot
      DocumentSnapshot<Map<String, dynamic>> snapshot = await clientData.get();

      // Check if the document exists and extract the 'total' field
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data();
        if (data != null && data.containsKey('total_to_pay')) {
          return data['total_to_pay']?.toDouble();
        }
      }
      return null; // Return null if total is not found
    } catch (e) {
      log('Error getting total for client $clientName: $e');
      return null;
    }
  }
}
