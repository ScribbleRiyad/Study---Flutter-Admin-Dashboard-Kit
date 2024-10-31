import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/helpers/widgets/my_form_validator.dart';

enum Gender {
  male,
  female;

  const Gender();
}

class TeacherEditController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  DateTime? selectedDate;
  DateTime? joinSelectDate;

  final String _firstName = 'James David';
  final String _lastName = 'James David';
  final String _email = 'james@gmail.com';
  final String _address = '40 Beach Street Egg Lagoon';
  final String _mobileNumber = '+91 1234567890';
  final String _education = 'M.COM, B.COM, B.A';

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

  @override
  void onInit() {
    basicValidator.addField('first_name',
        controller: TextEditingController(text: _firstName));
    basicValidator.addField('last_name',
        controller: TextEditingController(text: _lastName));
    basicValidator.addField('email',
        controller: TextEditingController(text: _email));
    basicValidator.addField('address',
        controller: TextEditingController(text: _address));
    basicValidator.addField('mobileNumber',
        controller: TextEditingController(text: _mobileNumber));
    basicValidator.addField('education',
        controller: TextEditingController(text: _education));
    super.onInit();
  }

  Future<void> joiningDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: joinSelectDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != joinSelectDate) {
      joinSelectDate = picked;
      update();
    }
  }
}
