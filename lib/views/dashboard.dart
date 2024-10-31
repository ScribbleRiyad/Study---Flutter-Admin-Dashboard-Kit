import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/dashboard_controller.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/widgets/my_breadcrumb.dart';
import 'package:study/helpers/widgets/my_breadcrumb_item.dart';
import 'package:study/helpers/widgets/my_container.dart';
import 'package:study/helpers/widgets/my_flex.dart';
import 'package:study/helpers/widgets/my_flex_item.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/models/dashboard_unpaid_student_model.dart';
import 'package:study/views/layouts/layout.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin, UIMixin {
  late DashboardController controller;

  @override
  void initState() {
    controller = Get.put(DashboardController());
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
                      "Dashboard",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Dashboard', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(child: buildOverView()),
                    MyFlexItem(sizes: 'lg-6', child: buildSchoolPerformance()),
                    MyFlexItem(sizes: 'lg-6', child: buildSchoolOverView()),
                    MyFlexItem(sizes: 'lg-4', child: buildResentStudent()),
                    MyFlexItem(sizes: 'lg-8', child: buildUnPaidStudent()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildResentStudent() {
    return MyContainer(
      borderRadiusAll: 8,
      child: Column(
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodyLarge("Recent Student", fontWeight: 600),
                  MyText.bodyLarge("You have 126 Students",
                      fontWeight: 600, xMuted: true),
                ],
              ),
              Spacer(),
              MyContainer.rounded(
                onTap: () => controller.gotoStudentAddScreen(),
                paddingAll: 12,
                color: contentTheme.primary,
                child: Icon(
                  LucideIcons.plus,
                  size: 20,
                  color: contentTheme.onPrimary,
                ),
              )
            ],
          ),
          MySpacing.height(20),
          ListView.separated(
            shrinkWrap: true,
            itemCount: controller.recentStudent.length,
            itemBuilder: (context, index) {
              var student = controller.recentStudent[index];
              return Row(
                children: [
                  MyContainer.rounded(
                    paddingAll: 0,
                    height: 50,
                    child: Image.asset(
                      student['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  MySpacing.width(12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.bodyMedium(student['name'], fontWeight: 600),
                      MySpacing.height(4),
                      MyText.bodyMedium(student['class'],
                          fontWeight: 600, muted: true),
                    ],
                  ),
                  Spacer(),
                  MyContainer.rounded(
                    onTap: () => controller.gotoStudentDetailScreen(),
                    paddingAll: 12,
                    color: contentTheme.primary.withAlpha(36),
                    child: Icon(LucideIcons.moveRight,
                        size: 20, color: contentTheme.primary),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 16,
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildUnPaidStudent() {
    return MyContainer(
      borderRadiusAll: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyLarge("Unpaid Student Intuition", fontWeight: 600),
          if (controller.data != null)
            PaginatedDataTable(
              headingRowColor: WidgetStatePropertyAll(Colors.transparent),
              source: controller.data!,
              columns: [
                DataColumn(
                    label: MyText.bodyMedium('Student Name', fontWeight: 600)),
                DataColumn(label: MyText.bodyMedium('ID', fontWeight: 600)),
                DataColumn(label: MyText.bodyMedium('Class', fontWeight: 600)),
                DataColumn(label: MyText.bodyMedium('Fees', fontWeight: 600)),
                DataColumn(label: MyText.bodyMedium('Rank', fontWeight: 600)),
                DataColumn(label: MyText.bodyMedium('Action', fontWeight: 600)),
              ],
              columnSpacing: 109,
              horizontalMargin: 50,
              rowsPerPage: 6,
              dataRowMaxHeight: 60,
            ),
        ],
      ),
    );
  }

  Widget buildSchoolOverView() {
    return MyContainer(
      borderRadiusAll: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyLarge("School OverView", fontWeight: 600),
          MySpacing.height(4),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            tooltipBehavior: controller.chart,
            axes: <ChartAxis>[
              NumericAxis(
                  numberFormat: NumberFormat.compact(),
                  majorGridLines: const MajorGridLines(width: 0),
                  opposedPosition: true,
                  name: 'yAxis1',
                  interval: 1000,
                  minimum: 0,
                  maximum: 7000)
            ],
            series:[
              ColumnSeries<ChartSampleData, String>(
                  animationDuration: 2000,
                  width: 0.5,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4)),
                  color: contentTheme.primary,
                  dataSource: controller.chartData,
                  xValueMapper: (ChartSampleData data, _) => data.x,
                  yValueMapper: (ChartSampleData data, _) => data.y,
                  name: 'Unit Sold'),
              LineSeries<ChartSampleData, String>(
                  animationDuration: 4500,
                  animationDelay: 2000,
                  dataSource: controller.chartData,
                  xValueMapper: (ChartSampleData data, _) => data.x,
                  yValueMapper: (ChartSampleData data, _) => data.yValue,
                  yAxisName: 'yAxis1',
                  markerSettings: const MarkerSettings(isVisible: true),
                  name: 'Total Transaction')
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSchoolPerformance() {
    return MyContainer(
      borderRadiusAll: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyLarge("School Performance", fontWeight: 600),
          MySpacing.height(4),
          SfCartesianChart(
            plotAreaBorderWidth: 0,
            tooltipBehavior: controller.schoolPerformance,
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
            ),
            series: [
              SplineSeries<ChartSampleData, String>(
                color: const Color(0xff727cf5),
                dataLabelSettings: const DataLabelSettings(
                  borderWidth: 100,
                  showZeroValue: true,
                ),
                dataSource: controller.schoolPerformance1,
                xValueMapper: (ChartSampleData data, _) => data.x,
                yValueMapper: (ChartSampleData data, _) => data.y,
              ),
              SplineSeries<ChartSampleData, String>(
                color: const Color(0xff0acf97),
                dataSource: controller.schoolPerformance2,
                xValueMapper: (ChartSampleData data, _) => data.x,
                yValueMapper: (ChartSampleData data, _) => data.y,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOverView() {
    Widget buildDetail(
        IconData icon, Color color, String title, String description) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyContainer.rounded(
            paddingAll: 24,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: color.withAlpha(40),
            child: Icon(icon, color: color),
          ),
          MySpacing.width(20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyLarge(title, fontWeight: 600, fontSize: 20),
              MySpacing.height(4),
              MyText.bodyLarge(description,
                  fontWeight: 600, fontSize: 24, muted: true)
            ],
          )
        ],
      );
    }

    return MyFlex(contentPadding: false, children: [
      MyFlexItem(
          sizes: 'lg-3',
          child: MyContainer(
            borderRadiusAll: 8,
            child: buildDetail(
                LucideIcons.user, contentTheme.primary, "Students", "1500"),
          )),
      MyFlexItem(
          sizes: 'lg-3',
          child: MyContainer(
            borderRadiusAll: 8,
            child: buildDetail(
                LucideIcons.users2, contentTheme.warning, "Teachers", "450"),
          )),
      MyFlexItem(
          sizes: 'lg-3',
          child: MyContainer(
            borderRadiusAll: 8,
            child: buildDetail(LucideIcons.calendarCheck, contentTheme.success,
                "Events", "32"),
          )),
      MyFlexItem(
          sizes: 'lg-3',
          child: MyContainer(
            borderRadiusAll: 8,
            child: buildDetail(LucideIcons.userPlus2, contentTheme.info,
                "Subscribers", "450154"),
          )),
    ]);
  }
}

class MyData extends DataTableSource with UIMixin {
  List<DashboardUnpaidStudentModel> studentData = [];

  MyData(this.studentData);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => studentData.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    DashboardUnpaidStudentModel data = studentData[index];

    return DataRow(
      cells: [
        DataCell(Row(
          children: [
            MyContainer.rounded(
              paddingAll: 0,
              height: 50,
              width: 50,
              child: Image.asset(
                data.image,
                fit: BoxFit.cover,
              ),
            ),
            MySpacing.width(12),
            MyText.bodyLarge(data.name, fontWeight: 600),
          ],
        )),
        DataCell(MyText.bodyLarge("ID ${data.studentId}", fontWeight: 600)),
        DataCell(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.bodyLarge('Class', fontWeight: 600, muted: true),
            MyText.bodyLarge(data.studentClass, fontWeight: 600),
          ],
        )),
        DataCell(MyText.bodyLarge('\$ ${data.fees}')),
        DataCell(MyText.bodyLarge(data.rank)),
        DataCell(MyContainer.none(
          paddingAll: 8,
          borderRadiusAll: 5,
          color: contentTheme.primary.withOpacity(0.05),
          child: PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                  padding: MySpacing.xy(16, 8),
                  height: 10,
                  child: MyText.bodySmall("Option 1")),
              PopupMenuItem(
                  padding: MySpacing.xy(16, 8),
                  height: 10,
                  child: MyText.bodySmall("Option 2")),
              PopupMenuItem(
                  padding: MySpacing.xy(16, 8),
                  height: 10,
                  child: MyText.bodySmall("Option 3")),
            ],
            child: Icon(
              LucideIcons.moreHorizontal,
              size: 18,
            ),
          ),
        )),
      ],
    );
  }

  void gotoEdit() {
    Get.toNamed('/admin/students/edit');
  }

  void gotoDetail() {
    Get.toNamed('/admin/students/detail');
  }
}
