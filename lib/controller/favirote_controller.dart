// ignore_for_file: invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FaviroteController extends GetxController {
  RxSet<String> favoriteIds = <String>{}.obs;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  RxList<Map<String, dynamic>> favoriteProducts = <Map<String, dynamic>>[].obs;

  String get userId => _auth.currentUser!.uid;

  // get fav data

  void loadeFavoriteData() {
    _firestore
        .collection('favorites')
        .doc(userId)
        .collection('items')
        .snapshots()
        .listen((snap) {
      favoriteIds.value = snap.docs.map((doc) => doc.id).toSet();
      favoriteProducts.value = snap.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  // add fav item  to firebase
  Future<void> addFavorite(
      String productId, Map<String, dynamic> productData) async {
    await _firestore
        .collection('favorites')
        .doc(userId)
        .collection('items')
        .doc(productId)
        .set(productData);
    Get.snackbar("Favorite", "${productData['title']} added to favorites");
  }

  Future<void> removeFavorite(String productId) async {
    await _firestore
        .collection('favorites')
        .doc(userId)
        .collection('items')
        .doc(productId)
        .delete();
    Get.snackbar("Favorite", "Removed from favorites");
  }

  void toggleFavorite(String productId, Map<String, dynamic> productData) {
    if (favoriteIds.contains(productId)) {
      removeFavorite(productId);
    } else {
      addFavorite(productId, productData);
    }
  }
}
