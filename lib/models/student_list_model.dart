import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:study/helpers/services/json_decoder.dart';
import 'package:study/models/identifier_model.dart';

class StudentListModel extends IdentifierModel {
  final String studentName, email, phone;
  final int purchasedCourses, enrollmentNumber;
  final DateTime admissionDate;

  StudentListModel(
    super.id,
    this.studentName,
    this.email,
    this.phone,
    this.purchasedCourses,
    this.enrollmentNumber,
    this.admissionDate,
  );

  static StudentListModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String studentName = decoder.getString('student_name');
    String email = decoder.getString('email');
    String phone = decoder.getString('phone_number');
    int purchasedCourses = decoder.getInt('purchased_courses');
    int enrollmentNumber = decoder.getInt('enrollment_number');
    DateTime admissionDate = decoder.getDateTime('admission_date');

    return StudentListModel(
      decoder.getId,
      studentName,
      email,
      phone,
      purchasedCourses,
      enrollmentNumber,
      admissionDate,
    );
  }

  static List<StudentListModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => StudentListModel.fromJSON(e)).toList();
  }

  static List<StudentListModel>? _dummyList;

  static Future<List<StudentListModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!.sublist(0, 50);
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/student_list.json');
  }
}
