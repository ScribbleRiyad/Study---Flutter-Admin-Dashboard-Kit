import 'package:flutter/material.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/models/student_list_model.dart';
import 'package:study/views/ui/students/student_list_screen.dart';

class StudentListController extends MyController {
  List<StudentListModel> studentData = [];

  DataTableSource? data;

  @override
  void onInit() {
    StudentListModel.dummyList.then((value) {
      studentData = value.sublist(0, 12);
      data = MyData(studentData);
      update();
    });
    super.onInit();
  }

  @override
  void onThemeChanged() {
    data = MyData(studentData);
    update();
  }
}
