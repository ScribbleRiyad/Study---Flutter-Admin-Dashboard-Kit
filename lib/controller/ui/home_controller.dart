import 'package:flutter/material.dart';
import 'package:study/controller/my_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
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

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}

class HomeController extends MyController {
  late DataSource events;

  @override
  void onInit() {
    events = addAppointments();
    super.onInit();
  }

  void dragEnd(AppointmentDragEndDetails appointmentDragEndDetails) {
    Appointment detail = appointmentDragEndDetails.appointment as Appointment;
    Duration duration = detail.endTime.difference(detail.startTime);

    DateTime start = DateTime(
        appointmentDragEndDetails.droppingTime!.year,
        appointmentDragEndDetails.droppingTime!.month,
        appointmentDragEndDetails.droppingTime!.day,
        appointmentDragEndDetails.droppingTime!.hour,
        0,
        0);

    final List<Appointment> appointment = <Appointment>[];
    events.appointments!.remove(appointmentDragEndDetails.appointment);

    events.notifyListeners(CalendarDataSourceAction.remove,
        <dynamic>[appointmentDragEndDetails.appointment]);

    Appointment app = Appointment(
      subject: detail.subject,
      color: detail.color,
      startTime: start,
      endTime: start.add(duration),
    );

    appointment.add(app);

    events.appointments!.add(appointment[0]);

    events.notifyListeners(CalendarDataSourceAction.add, appointment);
  }

  DataSource addAppointments() {
    List<Appointment> appointmentCollection = <Appointment>[];

    final DateTime today = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, DateTime.now().hour);
    appointmentCollection.add(Appointment(
        startTime: today,
        endTime: today.add(const Duration(hours: 1)),
        subject: 'Generative AI for Everyone',
        color: Colors.green));
    appointmentCollection.add(Appointment(
        startTime: today.add(const Duration(days: 1, hours: 2)),
        endTime: today.add(const Duration(days: 1, hours: 3)),
        subject: 'Generative AI Fundamentals Specialization',
        color: Colors.red));
    appointmentCollection.add(Appointment(
        startTime: today.add(const Duration(days: 1, hours: 1)),
        endTime: today.add(const Duration(days: 1, hours: 2)),
        subject: 'ChatGPT Advanced Data Analysis',
        color: Colors.pink));
    appointmentCollection.add(Appointment(
        startTime: today.add(const Duration(days: 2, hours: 5)),
        endTime: today.add(const Duration(days: 2, hours: 6)),
        subject: 'Introduction to Generative AI',
        color: Colors.pink));

    return DataSource(appointmentCollection);
  }

  List<RadialBarSeries<ChartSampleData, String>> getRadialBarSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
          x: '14/45\nVisited Lesson',
          y: 45,
          text: 'Visited Lesson',
          xValue: null,
          pointColor: const Color.fromRGBO(0, 201, 230, 1.0)),
      ChartSampleData(
          x: '12/25\nCompleted',
          y: 25,
          text: 'Completed',
          xValue: null,
          pointColor: const Color.fromRGBO(63, 224, 0, 1.0)),
    ];
    final List<RadialBarSeries<ChartSampleData, String>> list =
        <RadialBarSeries<ChartSampleData, String>>[
      RadialBarSeries<ChartSampleData, String>(
          animationDuration: 0,
          maximumValue: 100,
          radius: '100%',
          gap: '28  %',
          innerRadius: '50%',
          dataSource: chartData,
          cornerStyle: CornerStyle.bothCurve,
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointColorMapper: (ChartSampleData data, _) => data.pointColor,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          dataLabelSettings: const DataLabelSettings(isVisible: true))
    ];
    return list;
  }
}
