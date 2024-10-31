import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/helpers/widgets/my_form_validator.dart';

enum Gender {
  male,
  female;

  const Gender();
}

enum Religion {
  hindu,
  christian,
  other;

  const Religion();
}

enum Section {
  a,
  b,
  c,
  d;

  const Section();
}

enum BloodGroup {
  B,
  A,
  O;

  const BloodGroup();
}

class StudentAddController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  DateTime? selectedDate;

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      update();
    }
  }
}
