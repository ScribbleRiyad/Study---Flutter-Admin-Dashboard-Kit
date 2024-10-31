import 'package:flutter/material.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/helpers/widgets/my_text_utils.dart';
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

class StudentDetailController extends MyController {
  List<String> dummyTexts =
      List.generate(12, (index) => MyTextUtils.getDummyText(60));

  final List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: 'Mathematics', y: 45),
    ChartSampleData(x: 'Economics', y: 60),
    ChartSampleData(x: 'Science', y: 25),
    ChartSampleData(x: 'Chemistry', y: 75),
    ChartSampleData(x: 'Physics', y: 85),
    ChartSampleData(x: 'Business', y: 40),
    ChartSampleData(x: 'Archaeology', y: 70),
    ChartSampleData(x: 'Anthropology', y: 60),
    ChartSampleData(x: 'Algebra', y: 80),
  ];
  final TooltipBehavior chart = TooltipBehavior(
      enable: true, format: 'point.x : point.yValue1 : point.yValue2');
}
