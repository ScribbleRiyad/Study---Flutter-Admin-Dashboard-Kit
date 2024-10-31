import 'package:flutter/material.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/models/subscription_model.dart';

import 'package:study/views/ui/subscription/subscription_list_screen.dart';

class SubscriptionListController extends MyController {
  List<SubscriptionModel> subscription = [];

  DataTableSource? data;

  @override
  void onInit() {
    SubscriptionModel.dummyList.then((value) {
      subscription = value.sublist(10, 22);
      data = MyData(subscription);
      update();
    });
    super.onInit();
  }

  @override
  void onThemeChanged() {
    data = MyData(subscription);
    update();
  }
}
