import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:study/helpers/services/json_decoder.dart';
import 'package:study/models/identifier_model.dart';

class SubscriptionModel extends IdentifierModel {
  final int courseId;
  final String teacherName, status;
  final double rate;
  final DateTime subscribedAt, subscribedEndsAt;

  SubscriptionModel(
    super.id,
    this.courseId,
    this.teacherName,
    this.status,
    this.rate,
    this.subscribedAt,
    this.subscribedEndsAt,
  );

  static SubscriptionModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    int courseId = decoder.getInt('course_id');
    String teacherName = decoder.getString('teacher_name');
    String status = decoder.getString('status');
    double rate = decoder.getDouble('rate');
    DateTime subscribedAt = decoder.getDateTime('subscribed_at');
    DateTime subscribedEndsAt = decoder.getDateTime('subscribed_ends_at');

    return SubscriptionModel(decoder.getId, courseId, teacherName, status, rate,
        subscribedAt, subscribedEndsAt);
  }

  static List<SubscriptionModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => SubscriptionModel.fromJSON(e)).toList();
  }

  static List<SubscriptionModel>? _dummyList;

  static Future<List<SubscriptionModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!.sublist(0, 50);
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/subscription.json');
  }
}
