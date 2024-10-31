import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/helpers/widgets/my_form_validator.dart';

class CoursesEditController extends MyController {
  List<PlatformFile> files = [];
  MyFormValidator basicValidator = MyFormValidator();
  DateTime? selectedDate;

  final String _courseName = 'Programing';
  final String _courseCode = 'Pro#87Avs';
  final String _courseDetail = 'Why is Early Education Essential';
  final String _courseDuration = '3 Year';
  final String _coursePrise = '\$ 599';
  final String _professorName = 'Jimmy Morris';
  final String _maximumStudent = '150';
  final String _contactNumber = '+91 1234567890';

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
    basicValidator.addField('course_name',
        controller: TextEditingController(text: _courseName));
    basicValidator.addField('course_code',
        controller: TextEditingController(text: _courseCode));
    basicValidator.addField('course_detail',
        controller: TextEditingController(text: _courseDetail));
    basicValidator.addField('course_duration',
        controller: TextEditingController(text: _courseDuration));
    basicValidator.addField('course_prise',
        controller: TextEditingController(text: _coursePrise));
    basicValidator.addField('professor_name',
        controller: TextEditingController(text: _professorName));
    basicValidator.addField('maximum_student',
        controller: TextEditingController(text: _maximumStudent));
    basicValidator.addField('contact_number',
        controller: TextEditingController(text: _contactNumber));
    super.onInit();
  }

  Future<void> pickFile() async {
    var result = await FilePicker.platform.pickFiles();
    if (result?.files[0] != null) {
      files.add(result!.files[0]);
    }
    update();
  }

  void removeFile(PlatformFile file) {
    files.remove(file);

    update();
  }
}
