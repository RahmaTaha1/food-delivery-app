import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextFeildStyle() {
    return const TextStyle(
        fontSize: 21,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins");
  }

  static TextStyle headTextFeildStyle() {
    return const TextStyle(
        fontSize: 24,
        color:Color.fromARGB(255, 146, 18, 28),
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins");
  }

  static TextStyle lightTextFeildStyle() {
    return const TextStyle(
        fontSize: 13,
        color:Color.fromARGB(255, 216, 139, 146),
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins");
  }

  static TextStyle semiBoldTextFeildStyle() {
    return const TextStyle(
        fontSize:18,
        color:Colors.black,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins");
  }
  static TextStyle lightgreyTextFeildStyle() {
    return const TextStyle(
        fontSize: 15,
        color:Color.fromARGB(255, 107, 107, 107),
        fontWeight: FontWeight.w100,
        fontFamily: "Poppins");
  }

}
