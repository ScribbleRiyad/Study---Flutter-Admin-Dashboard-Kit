import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/models/organization_list_model.dart';

class OrganizationListController extends MyController {
  List<OrganizationListModel> organizationList = [];
  List<OrganizationListModel> searchOrganizationList = [];
  TextEditingController sController = TextEditingController();

  void searchOrganization(String query) {
    searchOrganizationList = organizationList.where((organization) {
      final schoolName = organization.name.toLowerCase();
      final input = query.toLowerCase();
      return schoolName.contains(input);
    }).toList();
    update();
  }

  void gotoOrganizationAdd() {
    Get.toNamed('/admin/organization/add');
  }

  void gotoOrganizationEdit() {
    Get.toNamed('/admin/organization/edit');
  }

  @override
  void onInit() {
    OrganizationListModel.dummyList.then((value) {
      organizationList = value.sublist(0, 9);
      searchOrganizationList = value;
      update();
    });
    super.onInit();
  }
}
