import 'package:flutter/material.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/models/courses_model.dart';

class CoursesController extends MyController {
  List<CoursesModel> courses = [];
  List<CoursesModel> searchCourse = [];
  TextEditingController searchController = TextEditingController();

  void searchCourseList(String query) {
    searchCourse = courses.where((course) {
      final courseName = course.courseName.toLowerCase();
      final input = query.toLowerCase();
      return courseName.contains(input);
    }).toList();
    update();
  }

  @override
  void onInit() {
    CoursesModel.dummyList.then((value) {
      courses = value.sublist(0, 8);
      searchCourse = value;
      update();
    });
    super.onInit();
  }
}
