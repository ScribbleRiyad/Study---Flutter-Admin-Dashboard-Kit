import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/models/cart_model.dart';

class CartController extends MyController {
  List<CartModel> carts = [];
  TextEditingController searchController = TextEditingController();

  List<String> countryList = [
    "Afghanistan",
    "Australia",
    "Bangladesh",
    "Brazil",
    "Canada",
    "China",
    "Colombia",
    "France",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Japan"
  ];

  void gotoExplore() {
    Get.toNamed('/client/courses');
  }

  void removeData(index) {
    carts.remove(index);
    update();
  }

  @override
  void onInit() {
    CartModel.dummyList.then((value) {
      carts = value.sublist(0, 5);
      update();
    });
    super.onInit();
  }
}
