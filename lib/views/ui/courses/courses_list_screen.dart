import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/ui/courses/course_list_controller.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/widgets/my_breadcrumb.dart';
import 'package:study/helpers/widgets/my_breadcrumb_item.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/models/course_list_model.dart';
import 'package:study/views/layouts/layout.dart';

class CoursesListScreen extends StatefulWidget {
  const CoursesListScreen({super.key});

  @override
  State<CoursesListScreen> createState() => _CoursesListScreenState();
}

class _CoursesListScreenState extends State<CoursesListScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late CoursesListController controller;

  @override
  void initState() {
    controller = Get.put(CoursesListController());
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
                      "Courses List",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Courses List', active: true),
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
                              label: MyText.bodyLarge('Courses Name',
                                  fontWeight: 600)),
                          DataColumn(
                              label: MyText.bodyLarge('CourseId',
                                  fontWeight: 600)),
                          DataColumn(
                              label:
                                  MyText.bodyLarge('Price', fontWeight: 600)),
                          DataColumn(
                              label:
                                  MyText.bodyLarge('Rating', fontWeight: 600)),
                          DataColumn(
                              label:
                                  MyText.bodyLarge('Status', fontWeight: 600)),
                          DataColumn(
                              label:
                                  MyText.bodyLarge('Action', fontWeight: 600)),
                        ],
                        columnSpacing: 220,
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
  List<CourseListModel> courseData = [];

  MyData(this.courseData);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => courseData.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    CourseListModel data = courseData[index];

    return DataRow(
      cells: [
        DataCell(MyText.bodyMedium(
          data.courseName,
          fontWeight: 600,
        )),
        DataCell(MyText.bodyMedium(
          "#${data.courseId}",
          fontWeight: 600,
        )),
        DataCell(MyText.bodyMedium("\$ ${data.price}")),
        DataCell(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.star, size: 16, color: contentTheme.warning),
            MySpacing.width(8),
            MyText.bodyMedium(
              "${data.rating}",
              fontWeight: 600,
            ),
          ],
        )),
        DataCell(MyText.bodyMedium(
          data.status,
          color: data.status == 'Releasing'
              ? contentTheme.warning
              : data.status == 'Released'
                  ? contentTheme.success
                  : data.status == 'Deleted'
                      ? contentTheme.danger
                      : null,
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
              onTap: () => gotoCourseListScreen(),
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

  void gotoCourseListScreen() {
    Get.toNamed('/admin/Courses/add');
  }

  void gotoEdit() {
    Get.toNamed('/admin/Courses/edit');
  }

  void gotoDetail() {
    Get.toNamed('/admin/Courses/detail');
  }
}
