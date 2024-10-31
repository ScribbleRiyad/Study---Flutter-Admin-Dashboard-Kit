import 'package:flutter/material.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/models/course_list_model.dart';
import 'package:study/views/ui/courses/courses_list_screen.dart';

class CoursesListController extends MyController {
  List<CourseListModel> courseData = [];
  DataTableSource? data;

  @override
  void onInit() {
    CourseListModel.dummyList.then((value) {
      courseData = value.sublist(0, 19);
      data = MyData(courseData);
      update();
    });
    super.onInit();
  }

  @override
  void onThemeChanged() {
    data = MyData(courseData);
    update();
  }
}
