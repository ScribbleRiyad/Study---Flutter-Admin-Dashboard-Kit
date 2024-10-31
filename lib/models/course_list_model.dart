import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:study/helpers/services/json_decoder.dart';
import 'package:study/models/identifier_model.dart';

class CourseListModel extends IdentifierModel {
  final String courseName, status;
  final double rating;
  final int price, courseId;

  CourseListModel(super.id, this.courseName, this.status, this.courseId,
      this.price, this.rating);

  static CourseListModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String courseName = decoder.getString('courses_name');
    String status = decoder.getString('status');
    int courseId = decoder.getInt('course_id');
    int price = decoder.getInt('price');
    double rating = decoder.getDouble('rating');

    return CourseListModel(
        decoder.getId, courseName, status, courseId, price, rating);
  }

  static List<CourseListModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => CourseListModel.fromJSON(e)).toList();
  }

  static List<CourseListModel>? _dummyList;

  static Future<List<CourseListModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!.sublist(0, 19);
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/course_list.json');
  }
}
