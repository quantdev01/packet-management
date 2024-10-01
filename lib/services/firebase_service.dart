import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

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
}
