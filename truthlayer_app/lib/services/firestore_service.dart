import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetch one autopsy document (demo purpose)
  Future<Map<String, dynamic>?> fetchLatestAutopsy() async {
    try {
      final snapshot = await _db
          .collection('autopsies')
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      return snapshot.docs.first.data();
    } catch (e) {
      print('Firestore error: $e');
      return null;
    }
  }
}
