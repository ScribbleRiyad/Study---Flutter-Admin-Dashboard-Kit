import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/ui/teacher/teacher_list_controller.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/utils/utils.dart';
import 'package:study/helpers/widgets/my_breadcrumb.dart';
import 'package:study/helpers/widgets/my_breadcrumb_item.dart';
import 'package:study/helpers/widgets/my_container.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/images.dart';
import 'package:study/models/teacher_list_model.dart';
import 'package:study/views/layouts/layout.dart';

class TeacherListScreen extends StatefulWidget {
  const TeacherListScreen({super.key});

  @override
  State<TeacherListScreen> createState() => _TeacherListScreenState();
}

class _TeacherListScreenState extends State<TeacherListScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late TeacherListController controller;

  @override
  void initState() {
    controller = Get.put(TeacherListController());
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
                      "Teacher List",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Teacher List', active: true),
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
                              label: MyText.bodyMedium('Teacher Name',
                                  fontWeight: 600)),
                          DataColumn(
                              label: MyText.bodyMedium('Email ID',
                                  fontWeight: 600)),
                          DataColumn(
                              label: MyText.bodyMedium('Phone No.',
                                  fontWeight: 600)),
                          DataColumn(
                              label: MyText.bodyMedium('Courses',
                                  fontWeight: 600)),
                          DataColumn(
                              label:
                                  MyText.bodyMedium('Sales', fontWeight: 600)),
                          DataColumn(
                              label: MyText.bodyMedium('Teaching Since',
                                  fontWeight: 600)),
                          DataColumn(
                              label:
                                  MyText.bodyMedium('Action', fontWeight: 600)),
                        ],
                        columnSpacing: 130,
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
  List<TeacherListModel> teacherData = [];

  MyData(this.teacherData);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => teacherData.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    TeacherListModel data = teacherData[index];

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
              data.teacherName,
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
          "#${data.courses}",
          fontWeight: 600,
        )),
        DataCell(MyText.bodyMedium(data.sales.toString())),
        DataCell(MyText.bodyMedium(
          Utils.getDateStringFromDateTime(data.teachingSince),
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
              onTap: () => gotoTeacherAddScreen(),
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

  void gotoTeacherAddScreen() {
    Get.toNamed('/admin/teacher/add');
  }

  void gotoEdit() {
    Get.toNamed('/admin/teacher/edit');
  }

  void gotoDetail() {
    Get.toNamed('/admin/teacher/detail');
  }
}
