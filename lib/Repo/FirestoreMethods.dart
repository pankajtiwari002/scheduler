import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMethods {
  Future<void> uploadData(String collection, Map<String, dynamic> body,
      [String? docId]) async {
    try {
      if (docId != null) {
        await FirebaseFirestore.instance
            .collection(collection)
            .doc(docId)
            .set(body);
      } else {
        await FirebaseFirestore.instance.collection(collection).doc().set(body);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateData(
      String collection, Map<String, dynamic> body, String? docId) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(docId)
          .update(body);
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> getData(String collection, String docId) async {
    try {
      final snap = await FirebaseFirestore.instance
          .collection(collection)
          .doc(docId)
          .get();
      return snap.data()!;
    } catch (e) {
      log(e.toString());
      return {};
    }
  }
}
