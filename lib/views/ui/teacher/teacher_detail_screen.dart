import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/ui/teacher/teacher_detail_controller.dart';
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
import 'package:study/views/layouts/layout.dart';

import 'package:study/images.dart';

class TeacherDetailScreen extends StatefulWidget {
  const TeacherDetailScreen({super.key});

  @override
  State<TeacherDetailScreen> createState() => _TeacherDetailScreenState();
}

class _TeacherDetailScreenState extends State<TeacherDetailScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late TeacherDetailController controller;

  @override
  void initState() {
    controller = Get.put(TeacherDetailController());
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
                      "Teacher Detail",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Teacher Detail', active: true),
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
                    MyFlexItem(
                      sizes: 'lg-9',
                      child: MyFlex(
                        contentPadding: false,
                        children: [
                          MyFlexItem(child: buildProfile()),
                          MyFlexItem(child: buildDetail()),
                          MyFlexItem(sizes: 'lg-6', child: buildSkills()),
                          MyFlexItem(sizes: 'lg-6', child: buildInterest()),
                        ],
                      ),
                    ),
                    MyFlexItem(
                      sizes: 'lg-3',
                      child: Column(
                        children: [
                          MyContainer(
                              borderRadiusAll: 8,
                              width: double.infinity,
                              child: MyText.bodyLarge("Schedule Details")),
                          MySpacing.height(12),
                          buildSchedule(
                            "World History",
                            "Class VII-B",
                            "March 20, 2022",
                            "09.00 - 10.00 AM",
                            Images.avatars[12],
                          ),
                          MySpacing.height(12),
                          buildSchedule(
                            "Ancient History",
                            "Class VII-A",
                            "March 20, 2022",
                            "09.00 - 10.00 AM",
                            Images.avatars[8],
                          ),
                          MySpacing.height(12),
                          buildSchedule(
                            "Culture",
                            "Class VIII-A",
                            "March 20, 2022",
                            "09.00 - 10.00 AM",
                            Images.avatars[5],
                          ),
                          MySpacing.height(12),
                          buildSchedule(
                            "World History",
                            "Class VII-C",
                            "March 20, 2022",
                            "09.00 - 10.00 AM",
                            Images.avatars[10],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
          MyText.bodyLarge("Skills :", fontWeight: 700),
          MySpacing.height(16),
          buildSkillsProgressBar(0.5, 'PhotoShop', '70%', contentTheme.primary),
          MySpacing.height(20),
          buildSkillsProgressBar(
              0.28, 'Code Editor', '40%', contentTheme.warning),
          MySpacing.height(20),
          buildSkillsProgressBar(
              0.69, 'Illustrator', '85%', contentTheme.success),
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
          MyText.bodyLarge("Interested In :", fontWeight: 700),
          MySpacing.height(16),
          buildInterestProgressBar(0.89, 'Study', "90%", contentTheme.dark),
          MySpacing.height(20),
          buildInterestProgressBar(
              0.3, 'Cricket', "50%", contentTheme.secondary),
          MySpacing.height(20),
          buildInterestProgressBar(0.2, 'Music', "40%", contentTheme.info),
        ],
      ),
    );
  }

  Widget buildSchedule(
      String name, String className, String date, String time, String image) {
    return MyContainer(
      borderRadiusAll: 8,
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText.bodyLarge(name, fontWeight: 600),
          MyText.bodyLarge(className, fontWeight: 600),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        LucideIcons.calendar,
                        size: 16,
                      ),
                      MySpacing.width(8),
                      MyText.bodyLarge(date, fontWeight: 600),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.clock,
                        size: 16,
                      ),
                      MySpacing.width(8),
                      MyText.bodyLarge(time, fontWeight: 600),
                    ],
                  ),
                ],
              ),
              MyContainer.rounded(
                paddingAll: 0,
                height: 50,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildDetail() {
    return MyContainer(
      borderRadiusAll: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleLarge("About", fontWeight: 600),
          MySpacing.height(8),
          MyText.bodyMedium(
            controller.dummyTexts[1],
            maxLines: 4,
            fontWeight: 600,
            xMuted: true,
          ),
          MySpacing.height(12),
          MyText.titleLarge("Education", fontWeight: 600),
          MySpacing.height(8),
          MyText.bodyLarge(
            "History Major, University",
            fontSize: 16,
            fontWeight: 600,
          ),
          MySpacing.height(8),
          MyText.bodyMedium('2020-2022', fontWeight: 600),
          MySpacing.height(12),
          MyText.titleLarge("Expertise", fontWeight: 600),
          MySpacing.height(8),
          MyText.bodyLarge(
            "World History, Philosophy, Prehistoric, Culture, Ancient",
            fontSize: 16,
            fontWeight: 600,
          ),
        ],
      ),
    );
  }

  Widget buildProfile() {
    Widget buildTeacherDetail(
        IconData icon, String title, String subTitle, Color color) {
      return MyContainer.bordered(
        borderRadiusAll: 8,
        child: Row(
          children: [
            MyContainer.rounded(
              color: color.withAlpha(36),
              child: Icon(icon, size: 20, color: color),
            ),
            MySpacing.width(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(title, fontWeight: 600),
                MySpacing.height(4),
                MyText.bodyMedium(subTitle),
              ],
            )
          ],
        ),
      );
    }

    return MyContainer(
      borderRadiusAll: 8,
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyContainer.roundBordered(
                paddingAll: 2,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: MyContainer.roundBordered(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  paddingAll: 0,
                  height: 100,
                  child: Image.asset(
                    Images.avatars[3],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              MySpacing.width(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodyMedium("Maria Historian",
                      fontWeight: 700, fontSize: 20),
                  MySpacing.height(4),
                  MyText.bodyMedium("History Teacher",
                      fontWeight: 600, muted: true),
                ],
              ),
            ],
          ),
          MySpacing.height(20),
          MyFlex(contentPadding: false, children: [
            MyFlexItem(
              sizes: 'lg-3',
              child: buildTeacherDetail(LucideIcons.map, 'Address :',
                  "Jakarta, Indonesia", contentTheme.primary),
            ),
            MyFlexItem(
              sizes: 'lg-3',
              child: buildTeacherDetail(LucideIcons.phoneCall, 'Phone :',
                  "+12 34567890", contentTheme.danger),
            ),
            MyFlexItem(
              sizes: 'lg-3',
              child: buildTeacherDetail(LucideIcons.user, 'DOB :', "1 jan 1999",
                  contentTheme.warning),
            ),
            MyFlexItem(
              sizes: 'lg-3',
              child: buildTeacherDetail(LucideIcons.mail, 'Email :',
                  "Historia@mail.com", contentTheme.success),
            ),
          ])
        ],
      ),
    );
  }
}
