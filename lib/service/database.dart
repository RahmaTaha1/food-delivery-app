import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future addFoodToCart(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id).collection("cart")
        .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodCart(String id) async {
    return await FirebaseFirestore.instance
        .collection("users").doc(id)
        .collection("cart").snapshots();
  }

  Future<void> removeItemFromCart(String userId, String itemId) async {
    try {
      
      CollectionReference cartCollection = FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("cart");

      
      await cartCollection.doc(itemId).delete();
    } catch (e) {
      print("Error removing item from cart: $e");
      
    }
  }
}
