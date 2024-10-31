import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:study/helpers/services/json_decoder.dart';
import 'package:study/images.dart';
import 'package:study/models/identifier_model.dart';

class CoursesModel extends IdentifierModel {
  final int students, lessons;
  final String courseName, name, image;
  final double rating, price;

  CoursesModel(
    super.id,
    this.students,
    this.lessons,
    this.courseName,
    this.name,
    this.image,
    this.rating,
    this.price,
  );

  static CoursesModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    int students = decoder.getInt('students');
    int lessons = decoder.getInt('lessons');
    String courseName = decoder.getString('course_name');
    String name = decoder.getString('name');
    String image = Images.randomImage(Images.courses);
    double rating = decoder.getDouble('rating');
    double price = decoder.getDouble('price');

    return CoursesModel(decoder.getId, students, lessons, courseName, name,
        image, rating, price);
  }

  static List<CoursesModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => CoursesModel.fromJSON(e)).toList();
  }

  static List<CoursesModel>? _dummyList;

  static Future<List<CoursesModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!.sublist(0, 8);
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/courses_data.json');
  }
}
