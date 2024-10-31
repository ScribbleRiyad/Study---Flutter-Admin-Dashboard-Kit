import 'package:flutter/material.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/models/teacher_list_model.dart';
import 'package:study/views/ui/teacher/teacher_list_screen.dart';

class TeacherListController extends MyController {
  List<TeacherListModel> teacherData = [];
  DataTableSource? data;

  @override
  void onInit() {
    TeacherListModel.dummyList.then((value) {
      teacherData = value.sublist(10, 40);
      data = MyData(teacherData);
      update();
    });
    super.onInit();
  }

  @override
  void onThemeChanged() {
    data = MyData(teacherData);
    super.onThemeChanged();
  }
}
