import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:study/helpers/services/json_decoder.dart';
import 'package:study/models/identifier_model.dart';

class TeacherListModel extends IdentifierModel {
  final String teacherName, email, phone, courses;
  final int sales;
  final DateTime teachingSince;

  TeacherListModel(super.id, this.teacherName, this.email, this.phone,
      this.courses, this.sales, this.teachingSince);

  static TeacherListModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String teacherName = decoder.getString('teacher_name');
    String email = decoder.getString('email');
    String phone = decoder.getString('phone_number');
    String courses = decoder.getString('courses');
    int sales = decoder.getInt('sales');
    DateTime teachingSince = decoder.getDateTime('teachingSince');

    return TeacherListModel(decoder.getId, teacherName, email, phone, courses,
        sales, teachingSince);
  }

  static List<TeacherListModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => TeacherListModel.fromJSON(e)).toList();
  }

  static List<TeacherListModel>? _dummyList;

  static Future<List<TeacherListModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!.sublist(0, 50);
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/teacher_list.json');
  }
}
