import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/helpers/widgets/my_form_validator.dart';

class OrganizationEditController extends MyController {
  List<PlatformFile> files = [];
  MyFormValidator basicValidator = MyFormValidator();
  DateTime? selectedDate;

  final String _name = 'Pleo Lari';
  final String _address = '50639 Oriole Center';
  final String _email = 'lhuguet2q@bbb.org';
  final String _detail = 'Why is Early Education Essential';
  final String _contactNumber = '+91 1234567890';
  final String _city = 'Koa';
  final String _numberOfCourses = '80';

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
    basicValidator.addField('name',
        controller: TextEditingController(text: _name));
    basicValidator.addField('address',
        controller: TextEditingController(text: _address));
    basicValidator.addField('email',
        controller: TextEditingController(text: _email));
    basicValidator.addField('detail',
        controller: TextEditingController(text: _detail));
    basicValidator.addField('contact_number',
        controller: TextEditingController(text: _contactNumber));
    basicValidator.addField('city',
        controller: TextEditingController(text: _city));
    basicValidator.addField('number_of_courses',
        controller: TextEditingController(text: _numberOfCourses));

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
