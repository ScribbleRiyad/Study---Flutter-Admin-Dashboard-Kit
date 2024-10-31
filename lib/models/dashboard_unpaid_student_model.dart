import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:study/helpers/services/json_decoder.dart';
import 'package:study/images.dart';
import 'package:study/models/identifier_model.dart';

class DashboardUnpaidStudentModel extends IdentifierModel {
  final String name, studentClass, rank, image;
  final int studentId, fees;

  DashboardUnpaidStudentModel(super.id, this.name, this.studentClass, this.rank,
      this.studentId, this.fees, this.image);

  static DashboardUnpaidStudentModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String name = decoder.getString('name');
    int studentId = decoder.getInt('student_id');
    String studentClass = decoder.getString('student_class');
    String rank = decoder.getString('rank');
    int fees = decoder.getInt('fees');
    String image = Images.randomImage(Images.courses);

    return DashboardUnpaidStudentModel(
      decoder.getId,
      name,
      studentClass,
      rank,
      studentId,
      fees,
      image,
    );
  }

  static List<DashboardUnpaidStudentModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => DashboardUnpaidStudentModel.fromJSON(e)).toList();
  }

  static List<DashboardUnpaidStudentModel>? _dummyList;

  static Future<List<DashboardUnpaidStudentModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!.sublist(0, 20);
  }

  static Future<String> getData() async {
    return await rootBundle
        .loadString('assets/data/dashboard_unpaid_student.json');
  }
}
