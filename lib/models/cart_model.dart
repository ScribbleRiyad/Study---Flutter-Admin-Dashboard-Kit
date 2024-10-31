import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:study/helpers/services/json_decoder.dart';
import 'package:study/models/identifier_model.dart';

class CartModel extends IdentifierModel {
  final String courseName, teacherName;
  final int fees;
  final DateTime validTill;

  CartModel(
      super.id, this.courseName, this.teacherName, this.fees, this.validTill);

  static CartModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String courseName = decoder.getString('course_name');
    String teacherName = decoder.getString('teacher_name');
    int fees = decoder.getInt('fees');
    DateTime validTill = decoder.getDateTime('valid_till');

    return CartModel(decoder.getId, courseName, teacherName, fees, validTill);
  }

  static List<CartModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => CartModel.fromJSON(e)).toList();
  }

  static List<CartModel>? _dummyList;

  static Future<List<CartModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!.sublist(0, 19);
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/cart_data.json');
  }
}
