import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/ui/students/students_list_controller.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/utils/utils.dart';
import 'package:study/helpers/widgets/my_breadcrumb.dart';
import 'package:study/helpers/widgets/my_breadcrumb_item.dart';
import 'package:study/helpers/widgets/my_container.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/images.dart';
import 'package:study/models/student_list_model.dart';
import 'package:study/views/layouts/layout.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late StudentListController controller;

  @override
  void initState() {
    controller = Get.put(StudentListController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Student List",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Student List', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Column(
                  children: [
                    if (controller.data != null)
                      PaginatedDataTable(
                        source: controller.data!,
                        columns: [
                          DataColumn(
                              label: MyText.bodyMedium('Student Name',
                                  fontWeight: 600)),
                          DataColumn(
                              label: MyText.bodyMedium('Email ID',
                                  fontWeight: 600)),
                          DataColumn(
                              label: MyText.bodyMedium('Phone No.',
                                  fontWeight: 600)),
                          DataColumn(
                              label: MyText.bodyMedium('Purchased Courses',
                                  fontWeight: 600)),
                          DataColumn(
                              label: MyText.bodyMedium('Enrollment Number',
                                  fontWeight: 600)),
                          DataColumn(
                              label: MyText.bodyMedium('Admission Date',
                                  fontWeight: 600)),
                          DataColumn(
                              label:
                                  MyText.bodyMedium('Action', fontWeight: 600)),
                        ],
                        columnSpacing: 110,
                        horizontalMargin: 50,
                        rowsPerPage: 10,
                        dataRowMaxHeight: 60,
                      ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class MyData extends DataTableSource with UIMixin {
  List<StudentListModel> studentData = [];

  MyData(this.studentData);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => studentData.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    StudentListModel data = studentData[index];

    return DataRow(
      cells: [
        DataCell(Row(
          children: [
            MyContainer.rounded(
              paddingAll: 0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                Images.avatars[index % Images.avatars.length],
                height: 40,
              ),
            ),
            MySpacing.width(12),
            MyText.bodyMedium(
              data.studentName,
              fontWeight: 600,
            ),
          ],
        )),
        DataCell(MyText.bodyMedium(
          data.email,
          fontWeight: 600,
        )),
        DataCell(MyText.bodyMedium("+91 ${data.phone}")),
        DataCell(MyText.bodyMedium(
          "#${data.purchasedCourses}",
          fontWeight: 600,
        )),
        DataCell(MyText.bodyMedium(data.enrollmentNumber.toString())),
        DataCell(MyText.bodyMedium(
          Utils.getDateStringFromDateTime(data.admissionDate),
          fontWeight: 600,
        )),
        DataCell(Row(
          children: [
            InkWell(
              onTap: () => gotoEdit(),
              child: Icon(
                LucideIcons.edit,
                size: 20,
              ),
            ),
            MySpacing.width(8),
            InkWell(
              onTap: () => gotoDetail(),
              child: Icon(
                LucideIcons.eye,
                size: 20,
              ),
            ),
            MySpacing.width(8),
            InkWell(
              onTap: () => gotoStudentAdd(),
              child: Icon(
                LucideIcons.plusCircle,
                size: 20,
              ),
            ),
          ],
        ))
      ],
    );
  }

  void gotoStudentAdd() {
    Get.toNamed('/admin/students/add');
  }

  void gotoEdit() {
    Get.toNamed('/admin/students/edit');
  }

  void gotoDetail() {
    Get.toNamed('/admin/students/detail');
  }
}
