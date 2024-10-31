import 'package:flutter/material.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/helpers/widgets/my_form_validator.dart';
import 'package:study/images.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

class TeacherDashboardController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();

  List studentDetail = [
    {
      "image": Images.avatars[3],
      "name": "Katalin",
      "gender": "Female",
      "marks": "65.98%",
      "gpa": "5",
      "attend": "77.88%"
    },
    {
      "image": Images.avatars[4],
      "name": "Jenny",
      "gender": "Female",
      "marks": "70.56%",
      "gpa": "4",
      "attend": "87.58%"
    },
    {
      "image": Images.avatars[5],
      "name": "Dulcia",
      "gender": "Male",
      "marks": "54.98%",
      "gpa": "1",
      "attend": "65.88%"
    },
    {
      "image": Images.avatars[6],
      "name": "Forster",
      "gender": "Female",
      "marks": "78.98%",
      "gpa": "5",
      "attend": "98.88%"
    },
    {
      "image": Images.avatars[7],
      "name": "Roseanne",
      "gender": "Male",
      "marks": "87.98%",
      "gpa": "8",
      "attend": "95.88%"
    },
  ];
  final List<ChartSampleData> columnChartData = <ChartSampleData>[
    ChartSampleData(x: 'Maths', y: 41, yValue: 60),
    ChartSampleData(x: 'English', y: 18, yValue: 40),
    ChartSampleData(x: 'Science', y: 60, yValue: 20),
    ChartSampleData(x: 'Art', y: 50, yValue: 45),
    ChartSampleData(x: 'Gujarati', y: 83, yValue: 80),
    ChartSampleData(x: 'Exercise', y: 17, yValue: 70),
  ];

  final TooltipBehavior tooltipBehavior = TooltipBehavior(
      enable: true,
      textAlignment: ChartAlignment.center,
      header: '',
      canShowMarker: false,
      format: 'point.x');

  final List<ChartSampleData> barChartData = <ChartSampleData>[
    ChartSampleData(
      x: 'Grade 1',
      y: 60,
      secondSeriesYValue: 54,
    ),
    ChartSampleData(
      x: 'Grade 2',
      y: 50,
      secondSeriesYValue: 43,
    ),
    ChartSampleData(
      x: 'Grade 3',
      y: 40,
      secondSeriesYValue: 35,
    ),
    ChartSampleData(
      x: 'Grade 4',
      y: 30,
      secondSeriesYValue: 33,
    ),
    ChartSampleData(
      x: 'Grade 5',
      y: 20,
      secondSeriesYValue: 35,
    ),
    ChartSampleData(
      x: 'Grade 6',
      y: 10,
      secondSeriesYValue: 15,
    ),
  ];
}
