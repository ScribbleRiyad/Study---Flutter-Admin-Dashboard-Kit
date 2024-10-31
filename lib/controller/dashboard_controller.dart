import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/images.dart';
import 'package:study/models/dashboard_unpaid_student_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:study/views/dashboard.dart';

class ChartSampleData {
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  final dynamic x;
  final num? y;
  final dynamic xValue;
  final num? yValue;
  final num? secondSeriesYValue;
  final num? thirdSeriesYValue;
  final Color? pointColor;
  final num? size;
  final String? text;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
  final num? volume;
}

class DashboardController extends MyController {
  List<DashboardUnpaidStudentModel> unpaidStudents = [];

  DataTableSource? data;

  @override
  void onInit() {
    DashboardUnpaidStudentModel.dummyList.then((value) {
      unpaidStudents = value.sublist(0, 12);
      data = MyData(unpaidStudents);
      update();
    });
    super.onInit();
  }

  @override
  void onThemeChanged() {
    data = MyData(unpaidStudents);
    update();
  }

  void gotoStudentAddScreen() {
    Get.toNamed('/admin/students/add');
  }

  void gotoStudentDetailScreen() {
    Get.toNamed('/admin/students/detail');
  }

  final List<ChartSampleData> schoolPerformance1 = <ChartSampleData>[
    ChartSampleData(x: 'Mon', y: 0),
    ChartSampleData(x: 'Tue', y: 30),
    ChartSampleData(x: 'Wed', y: 35),
    ChartSampleData(x: 'The', y: 30),
    ChartSampleData(x: 'Fri', y: 45),
    ChartSampleData(x: 'Sat', y: 40),
    ChartSampleData(x: 'Sun', y: 55)
  ];
  final List<ChartSampleData> schoolPerformance2 = <ChartSampleData>[
    ChartSampleData(x: 'Mon', y: 10),
    ChartSampleData(x: 'Tue', y: 50),
    ChartSampleData(x: 'Wed', y: 30),
    ChartSampleData(x: 'The', y: 20),
    ChartSampleData(x: 'Fri', y: 35),
    ChartSampleData(x: 'Sat', y: 30),
    ChartSampleData(x: 'Sun', y: 45)
  ];

  final TooltipBehavior schoolPerformance = TooltipBehavior(
    enable: true,
    tooltipPosition: TooltipPosition.pointer,
    format: 'point.x : point.y',
  );

  final List<ChartSampleData> chartData = [
    ChartSampleData(x: 'Jan', y: 10, yValue: 1000),
    ChartSampleData(x: 'Fab', y: 20, yValue: 2000),
    ChartSampleData(x: 'Mar', y: 15, yValue: 1500),
    ChartSampleData(x: 'Jun', y: 5, yValue: 500),
    ChartSampleData(x: 'Jul', y: 30, yValue: 3000),
    ChartSampleData(x: 'Aug', y: 20, yValue: 2000),
    ChartSampleData(x: 'Sep', y: 40, yValue: 4000),
    ChartSampleData(x: 'Oct', y: 60, yValue: 6000),
    ChartSampleData(x: 'Nov', y: 55, yValue: 5500),
    ChartSampleData(x: 'Dec', y: 38, yValue: 3000),
  ];
  final TooltipBehavior chart = TooltipBehavior(
    enable: true,
    format: 'point.x : point.yValue1 : point.yValue2',
  );

  List todaySchedule = [
    {"name": "Physic", "chapterName": "Chapter 3 - Lab 3"},
    {"name": "History", "chapterName": "Chapter 4 class"},
    {"name": "Computer", "chapterName": "Chapter 1 - Lab 2"},
    {"name": "Geography", "chapterName": "Chapter 5 Class"},
    {"name": "Maths", "chapterName": "Chapter 2 Class"},
    {"name": "Biology", "chapterName": "Chapter 2 - Lab 4"},
    {"name": "Gujarati", "chapterName": "Chapter 8 Class"},
  ];
  List examSchedule = [
    {"name": "Physic", "chapterName": "Lab 3", "day": "Mon", "time": "8.30 AM"},
    {
      "name": "History",
      "chapterName": "class 9",
      "day": "Tue",
      "time": "8.30 AM"
    },
    {
      "name": "Computer",
      "chapterName": "Lab 2",
      "day": "Wed",
      "time": "8.30 AM"
    }
  ];

  List recentStudent = [
    {
      "name": "Dulcia",
      "class": "Class II A",
      "image": Images.avatars[2],
    },
    {
      "name": "Forster",
      "class": "Class VII B",
      "image": Images.avatars[3],
    },
    {
      "name": "Roseanne",
      "class": "Class A",
      "image": Images.avatars[4],
    },
    {
      "name": "Gregg",
      "class": "Class VI A",
      "image": Images.avatars[5],
    },
    {
      "name": "Kendal",
      "class": "Class II B",
      "image": Images.avatars[6],
    },
    {
      "name": "Egan",
      "class": "Class A",
      "image": Images.avatars[7],
    },
    {
      "name": "Forster",
      "class": "Class C",
      "image": Images.avatars[8],
    },
  ];
}
