import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:study/helpers/services/json_decoder.dart';
import 'package:study/models/identifier_model.dart';

class TransactionModel extends IdentifierModel {
  final String transactionType, status;
  final int transactionId, amount;
  final DateTime dateTime;

  TransactionModel(
    super.id,
    this.transactionType,
    this.transactionId,
    this.amount,
    this.status,
    this.dateTime,
  );

  static TransactionModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String transactionType = decoder.getString('transaction_type');

    int transactionId = decoder.getInt('transaction_id');
    int amount = decoder.getInt('amount');
    String status = decoder.getString('status');
    DateTime dateTime = decoder.getDateTime('date_time');

    return TransactionModel(decoder.getId, transactionType, transactionId,
        amount, status, dateTime);
  }

  static List<TransactionModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => TransactionModel.fromJSON(e)).toList();
  }

  static List<TransactionModel>? _dummyList;

  static Future<List<TransactionModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!.sublist(0, 60);
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/transaction.json');
  }
}
