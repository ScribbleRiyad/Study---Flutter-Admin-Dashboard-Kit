import 'package:flutter/material.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/models/transaction_model.dart';

import 'package:study/views/ui/wallet_screen.dart';

class WalletController extends MyController {
  List<TransactionModel> transactions = [];
  DataTableSource? data;

  @override
  void onInit() {
    TransactionModel.dummyList.then((value) {
      transactions = value.sublist(0, 11);
      data = MyData(transactions);
      update();
    });
    super.onInit();
  }

  @override
  void onThemeChanged() {
    data = MyData(transactions);
    update();
  }
}
