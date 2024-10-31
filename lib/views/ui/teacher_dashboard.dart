import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/ui/teacher_dashboard_controller.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/widgets/my_breadcrumb.dart';
import 'package:study/helpers/widgets/my_breadcrumb_item.dart';
import 'package:study/helpers/widgets/my_container.dart';
import 'package:study/helpers/widgets/my_flex.dart';
import 'package:study/helpers/widgets/my_flex_item.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/images.dart';
import 'package:study/views/layouts/layout.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late TeacherDashboardController controller;

  @override
  void initState() {
    controller = Get.put(TeacherDashboardController());
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
                      "Teacher Dashboard",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(
                            name: 'Teacher Dashboard', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(children: [
                  MyFlexItem(
                    sizes: 'lg-8',
                    child: MyFlex(
                      contentPadding: false,
                      children: [
                        MyFlexItem(
                          sizes: 'lg-4',
                          child: MyContainer(
                            borderRadiusAll: 8,
                            child: buildDetail(
                              LucideIcons.users2,
                              contentTheme.secondary,
                              '5,5478',
                              'Student Count',
                            ),
                          ),
                        ),
                        MyFlexItem(
                          sizes: 'lg-4',
                          child: MyContainer(
                            borderRadiusAll: 8,
                            child: buildDetail(
                              LucideIcons.listTodo,
                              contentTheme.success,
                              '81%',
                              'Student Attendance',
                            ),
                          ),
                        ),
                        MyFlexItem(
                          sizes: 'lg-4',
                          child: MyContainer(
                            borderRadiusAll: 8,
                            child: buildDetail(
                              LucideIcons.trendingUp,
                              contentTheme.primary,
                              '68%',
                              'Exam Average',
                            ),
                          ),
                        ),
                        MyFlexItem(
                            child: MyContainer(
                                borderRadiusAll: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.bodyLarge(
                                      "Student Count",
                                      fontWeight: 600,
                                    ),
                                    MySpacing.height(12),
                                    _buildDefaultBarChart(),
                                  ],
                                ))),
                        MyFlexItem(
                            child: MyContainer(
                                borderRadiusAll: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.bodyLarge(
                                      "Examination Result",
                                      fontWeight: 600,
                                    ),
                                    MySpacing.height(12),
                                    _buildDefaultColumnChart(),
                                  ],
                                )))
                      ],
                    ),
                  ),
                  MyFlexItem(
                    sizes: 'lg-4',
                    child: MyFlex(
                      contentPadding: false,
                      children: [
                        MyFlexItem(child: buildStudentOverView()),
                        MyFlexItem(child: buildStudentDetail()),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  SfCartesianChart _buildDefaultColumnChart() {
    List<ColumnSeries<ChartSampleData, String>> getDefaultColumnSeries() {
      return <ColumnSeries<ChartSampleData, String>>[
        ColumnSeries<ChartSampleData, String>(
          color: contentTheme.primary.withAlpha(200),
          dataSource: controller.columnChartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, textStyle: TextStyle(fontSize: 10)),
        ),
        ColumnSeries<ChartSampleData, String>(
          color: contentTheme.success.withAlpha(200),
          dataSource: controller.columnChartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, textStyle: TextStyle(fontSize: 10)),
        )
      ];
    }

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          labelFormat: '{value}%',
          majorTickLines: MajorTickLines(size: 8, color: Colors.transparent)),
      series: getDefaultColumnSeries(),
      tooltipBehavior: controller.tooltipBehavior,
    );
  }

  SfCartesianChart _buildDefaultBarChart() {
    List<BarSeries<ChartSampleData, String>> getDefaultBarSeries() {
      return <BarSeries<ChartSampleData, String>>[
        BarSeries<ChartSampleData, String>(
            color: contentTheme.primary,
            dataSource: controller.barChartData,
            xValueMapper: (ChartSampleData sales, _) => sales.x as String,
            yValueMapper: (ChartSampleData sales, _) => sales.y,
            name: '2020'),
        BarSeries<ChartSampleData, String>(
            color: contentTheme.secondary,
            dataSource: controller.barChartData,
            xValueMapper: (ChartSampleData sales, _) => sales.x as String,
            yValueMapper: (ChartSampleData sales, _) =>
                sales.secondSeriesYValue,
            name: '2023'),
      ];
    }

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      series: getDefaultBarSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  Widget buildStudentDetail() {
    Widget buildStudentOverView(String title, String subTitle) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium(title, fontWeight: 600),
          MyText.bodyMedium(subTitle, fontWeight: 600, muted: true),
        ],
      );
    }

    return MyContainer(
      borderRadiusAll: 8,
      paddingAll: 0,
      child: Padding(
        padding: MySpacing.xy(16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.bodyMedium("Student Detail", fontWeight: 600),
            MySpacing.height(12),
            SizedBox(
              height: 260,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.studentDetail.length,
                itemBuilder: (context, index) {
                  var stuData = controller.studentDetail[index];
                  return MyContainer.bordered(
                    paddingAll: 0,
                    width: 200,
                    borderRadiusAll: 8,
                    child: Column(
                      children: [
                        Padding(
                          padding: MySpacing.only(
                              top: 16, left: 16, right: 16, bottom: 12),
                          child: Center(
                            child: MyContainer.rounded(
                                height: 100,
                                paddingAll: 0,
                                child: Image.asset(
                                  stuData['image'],
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        MyText.bodyLarge(
                          stuData['name'],
                          fontWeight: 600,
                        ),
                        MySpacing.height(8),
                        MyText.bodyMedium(
                          stuData['gender'],
                          fontWeight: 600,
                          xMuted: true,
                        ),
                        Divider(),
                        Padding(
                          padding: MySpacing.only(top: 16, left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildStudentOverView(stuData['marks'], "Grade"),
                              buildStudentOverView(stuData['gpa'], "GPA"),
                              buildStudentOverView(stuData['attend'], "Attend"),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 20,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildStudentOverView() {
    Widget buildTopStudentDetail(
      String image,
      String subTitle,
      String overViTitle1,
      String overViTitle2,
      String overViTitle3,
    ) {
      Widget buildStudentOverView(String title, String subTitle) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.bodyMedium(title, fontWeight: 600),
            MyText.bodyMedium(subTitle, fontWeight: 600, muted: true),
          ],
        );
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 60,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          MySpacing.width(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyLarge(subTitle, fontWeight: 600),
                MySpacing.height(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildStudentOverView(overViTitle1, "Grade"),
                    buildStudentOverView(overViTitle2, "GPA"),
                    buildStudentOverView(overViTitle3, "Attend"),
                  ],
                )
              ],
            ),
          )
        ],
      );
    }

    return MyContainer(
      borderRadiusAll: 8,
      paddingAll: 0,
      child: Padding(
        padding: MySpacing.fromLTRB(16, 14, 16, 14),
        child: MyFlex(
          contentPadding: false,
          children: [
            MyFlexItem(
                sizes: 'lg-6',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium(
                      "Best In Marks",
                      fontWeight: 600,
                    ),
                    MySpacing.height(4),
                    MyContainer.bordered(
                      borderRadiusAll: 8,
                      child: buildTopStudentDetail(
                        Images.avatars[15],
                        "Charita",
                        "3",
                        "5",
                        "88.98%",
                      ),
                    ),
                  ],
                )),
            MyFlexItem(
                sizes: 'lg-6',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium(
                      "Best In Attendance",
                      fontWeight: 600,
                    ),
                    MySpacing.height(4),
                    MyContainer.bordered(
                      borderRadiusAll: 8,
                      child: buildTopStudentDetail(
                        Images.avatars[14],
                        "Donni",
                        "5",
                        "4",
                        "78.89%",
                      ),
                    ),
                  ],
                )),
            MyFlexItem(
                sizes: 'lg-6',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium(
                      "Most Improved In Marks",
                      fontWeight: 600,
                    ),
                    MySpacing.height(4),
                    MyContainer.bordered(
                      borderRadiusAll: 8,
                      child: buildTopStudentDetail(
                        Images.avatars[13],
                        "Jourdan",
                        "2",
                        "5",
                        "89%",
                      ),
                    ),
                  ],
                )),
            MyFlexItem(
                sizes: 'lg-6',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium(
                      "Most Improved In Attendance",
                      fontWeight: 600,
                    ),
                    MySpacing.height(4),
                    MyContainer.bordered(
                      borderRadiusAll: 8,
                      child: buildTopStudentDetail(
                        Images.avatars[12],
                        "Kylila",
                        "6",
                        "8",
                        "78.99%",
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

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
            MyText.bodyLarge(description, fontWeight: 600, muted: true)
          ],
        )
      ],
    );
  }
}
