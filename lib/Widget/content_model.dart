import 'package:flutter/material.dart';

class UnboardingContent {
  String image;
  String title;
  String description;
  UnboardingContent(
      {required this.description, required this.image, required this.title});
}

List<UnboardingContent> contents = [
  UnboardingContent(
      description:"Enjoy your food with us and pick what\n            you need form our menu",
      image: "images/onboard1.webp",
      title: "Fresh and tasty Food"),
  UnboardingContent(
      description:"Food is deliverd in few minutes\n                   at your Door",
      image: "images/onboard2.png",
      title: "Fast and easy Delivery"),
  UnboardingContent(
      description:"You can pay online or when your \n                   food arrive",
      image: "images/onboard3.webp",
      title: "Easy and online Payment"),
];
