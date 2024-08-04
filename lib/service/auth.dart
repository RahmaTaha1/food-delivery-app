import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  getCurrentUser() async {
    return await auth.currentUser;
  }

  Future<void> SignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> deleteUser() async {
    User? user = await FirebaseAuth.instance.currentUser;

    if (user != null) {
      
      await firestore.collection('users').doc(user.uid).delete();

      
      await user.delete();
    }
  }
}
