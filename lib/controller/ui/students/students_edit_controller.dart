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

class StudentEditController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  DateTime? selectedDate;

  final String _firstName = 'James David';
  final String _lastName = 'James David';
  final String _email = 'james@gmail.com';
  final String _rollNumber = '11';
  final String _phoneNumber = '+91 1234567890';


  @override
  void onInit() {
    basicValidator.addField('first_name',
        controller: TextEditingController(text: _firstName));
    basicValidator.addField('last_name',
        controller: TextEditingController(text: _lastName));
    basicValidator.addField('email',
        controller: TextEditingController(text: _email));
    basicValidator.addField('rollNumber',
        controller: TextEditingController(text: _rollNumber));
    basicValidator.addField('phoneNumber',
        controller: TextEditingController(text: _phoneNumber));
    super.onInit();
  }

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
