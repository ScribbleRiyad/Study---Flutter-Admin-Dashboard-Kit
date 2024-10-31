import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/ui/students/students_detail_controller.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/widgets/my_breadcrumb.dart';
import 'package:study/helpers/widgets/my_breadcrumb_item.dart';
import 'package:study/helpers/widgets/my_container.dart';
import 'package:study/helpers/widgets/my_flex.dart';
import 'package:study/helpers/widgets/my_flex_item.dart';
import 'package:study/helpers/widgets/my_progress_bar.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/images.dart';
import 'package:study/views/layouts/layout.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StudentDetailScreen extends StatefulWidget {
  const StudentDetailScreen({super.key});

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late StudentDetailController controller;

  @override
  void initState() {
    controller = Get.put(StudentDetailController());
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
                      "Student Detail",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Student Detail', active: true),
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
                    MyFlexItem(sizes: 'lg-3', child: buildPersonalDetail()),
                    MyFlexItem(sizes: 'lg-9', child: buildAboutMe()),
                    MyFlexItem(sizes: 'lg-3', child: buildSkills()),
                    MyFlexItem(sizes: 'lg-3', child: buildInterest()),
                    MyFlexItem(sizes: 'lg-6', child: buildSubjectChart())
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildSubjectChart() {
    return MyContainer(
      borderRadiusAll: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyLarge(
            "Score Chart :",
            fontWeight: 600,
          ),
          MySpacing.height(12),
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
                maximum: 7000,
              )
            ],
            series: [
              ColumnSeries<ChartSampleData, String>(
                color: contentTheme.primary,
                animationDuration: 2000,
                spacing: 0.5,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12)),
                dataSource: controller.chartData,
                xValueMapper: (ChartSampleData data, _) => data.x,
                yValueMapper: (ChartSampleData data, _) => data.y,
                name: 'Unit Sold',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInterest() {
    Widget buildInterestProgressBar(
        double progress, String title, String value, Color color) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.bodyLarge(title, fontWeight: 600),
              MyText.bodyLarge(value, fontWeight: 600),
            ],
          ),
          MySpacing.height(12),
          MyProgressBar(
              width: 600,
              progress: progress,
              height: 8,
              radius: 4,
              inactiveColor: theme.dividerColor,
              activeColor: color),
        ],
      );
    }

    return MyContainer(
      borderRadiusAll: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyLarge("Interested In :", fontWeight: 600),
          MySpacing.height(16),
          buildInterestProgressBar(0.4, 'Study', "60%", colorScheme.primary),
          MySpacing.height(20),
          buildInterestProgressBar(0.3, 'Cricket', "50%", contentTheme.info),
          MySpacing.height(20),
          buildInterestProgressBar(0.2, 'Music', "40%", contentTheme.warning),
          MySpacing.height(20),
          buildInterestProgressBar(
              0.49, 'Running', "65%", contentTheme.success),
          MySpacing.height(20),
          buildInterestProgressBar(
              0.41, 'Driving', "65%", contentTheme.secondary),
        ],
      ),
    );
  }

  Widget buildAboutMe() {
    Widget buildEducation(String date, String information) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium(date, fontWeight: 600),
          MyText.bodyMedium(information, fontWeight: 600, xMuted: true),
        ],
      );
    }

    return MyContainer(
      borderRadiusAll: 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyLarge("About Student :", fontWeight: 600),
          MySpacing.height(16),
          MyText.bodyLarge("Hello I am James David", fontWeight: 600),
          MySpacing.height(16),
          MyText.bodyMedium(
            controller.dummyTexts[1],
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          MySpacing.height(16),
          MyText.bodyMedium(
            controller.dummyTexts[2],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          MySpacing.height(16),
          MyText.bodyLarge("Education", fontWeight: 600),
          MySpacing.height(16),
          buildEducation('2008-2009',
              'Secondary Schooling at xyz school of secondary education, Mumbai.'),
          MySpacing.height(16),
          buildEducation('2010-2012',
              'Higher Secondary Schooling at xyz school of higher secondary education, Mumbai.'),
          MySpacing.height(16),
          buildEducation('2012 - 2015',
              'Bachelor of Science at Abc College of Art and Science, Chennai.'),
          MySpacing.height(16),
          buildEducation('2015 - 2017',
              'Master of Science at Cdm College of Engineering and Technology, Pune.'),
        ],
      ),
    );
  }

  Widget buildSkills() {
    Widget buildSkillsProgressBar(
        double progress, String title, String value, Color color) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.bodyLarge(title, fontWeight: 600),
              MyText.bodyLarge(value, fontWeight: 600),
            ],
          ),
          MySpacing.height(12),
          MyProgressBar(
              width: 600,
              progress: progress,
              height: 8,
              radius: 4,
              inactiveColor: theme.dividerColor,
              activeColor: color),
        ],
      );
    }

    return MyContainer(
      borderRadiusAll: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyLarge("Skills :", fontWeight: 600),
          MySpacing.height(16),
          buildSkillsProgressBar(0.4, 'PhotoShop', '60%', contentTheme.primary),
          MySpacing.height(20),
          buildSkillsProgressBar(
              0.3, 'Code Editor', '50%', contentTheme.danger),
          MySpacing.height(20),
          buildSkillsProgressBar(
              0.2, 'Illustrator', '40%', contentTheme.success),
          MySpacing.height(20),
          buildSkillsProgressBar(0.5, 'SQL', '60%', contentTheme.warning),
          MySpacing.height(20),
          buildSkillsProgressBar(0.4, 'FillMora', '80%', contentTheme.info),
        ],
      ),
    );
  }

  Widget buildPersonalDetail() {
    Widget buildDetail(IconData icon, String title, String subTitle) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: contentTheme.primary,
          ),
          MySpacing.width(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium(title, fontWeight: 600),
              MyText.bodyMedium(subTitle, fontWeight: 600, xMuted: true),
            ],
          ),
        ],
      );
    }

    return MyContainer(
      borderRadiusAll: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyLarge(
            "Personal Detail :",
            fontWeight: 600,
          ),
          MySpacing.height(12),
          Center(
            child: MyContainer.roundBordered(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              paddingAll: 0,
              height: 100,
              child: Image.asset(
                Images.avatars[2],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(child: MyText.bodyLarge("James David", fontWeight: 600)),
          MySpacing.height(16),
          buildDetail(LucideIcons.phoneCall, 'Mobile', "+91 234567890"),
          MySpacing.height(16),
          buildDetail(LucideIcons.mail, 'E-Mail', "james@gmail.com"),
          MySpacing.height(16),
          buildDetail(LucideIcons.users2, 'Gender', "Male"),
          MySpacing.height(16),
          buildDetail(LucideIcons.calendar, 'Date of Birth', "12 Apr 1999"),
          MySpacing.height(16),
          buildDetail(
              LucideIcons.mapPin, 'Address', "480, Eastern Avenue, New York"),
        ],
      ),
    );
  }
}
