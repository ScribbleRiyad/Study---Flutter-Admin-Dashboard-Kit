import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/ui/home_controller.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/widgets/my_breadcrumb.dart';
import 'package:study/helpers/widgets/my_breadcrumb_item.dart';
import 'package:study/helpers/widgets/my_container.dart';
import 'package:study/helpers/widgets/my_flex.dart';
import 'package:study/helpers/widgets/my_flex_item.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/helpers/widgets/my_text_style.dart';
import 'package:study/images.dart';
import 'package:study/views/layouts/layout.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late HomeController controller;

  @override
  void initState() {
    controller = Get.put(HomeController());
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
                      "Home",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Home', active: true),
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
                      sizes: 'lg-7',
                      child: MyContainer(
                        borderRadiusAll: 8,
                        child: buildStudentOverView(),
                      )),
                  MyFlexItem(
                      sizes: 'lg-5',
                      child: MyContainer(
                        borderRadiusAll: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.bodyLarge("My Progress", fontWeight: 600),
                            SizedBox(
                              height: 261,
                              child: SfCircularChart(
                                title: ChartTitle(
                                    textStyle:
                                        MyTextStyle.bodySmall(fontWeight: 600)),
                                legend: Legend(
                                    isVisible: true,
                                    iconHeight: 20,
                                    iconWidth: 20,
                                    position: LegendPosition.right,
                                    overflowMode: LegendItemOverflowMode.none),
                                series: controller.getRadialBarSeries(),
                              ),
                            ),
                          ],
                        ),
                      )),
                  MyFlexItem(
                      sizes: 'lg-8',
                      child: MyContainer(
                        borderRadiusAll: 8,
                        child: SizedBox(
                          height: 500,
                          child: SfCalendar(
                            view: CalendarView.month,
                            allowedViews: const [
                              CalendarView.day,
                              CalendarView.week,
                              CalendarView.month,
                            ],
                            dataSource: controller.events,
                            allowDragAndDrop: true,
                            onDragEnd: controller.dragEnd,
                            monthViewSettings: const MonthViewSettings(
                              showAgenda: true,
                            ),
                            scheduleViewSettings: ScheduleViewSettings(
                                weekHeaderSettings: WeekHeaderSettings(
                                    startDateFormat: 'dd MMM ',
                                    endDateFormat: 'dd MMM, yy',
                                    height: 50,
                                    textAlign: TextAlign.center,
                                    backgroundColor: Colors.red,
                                    weekTextStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ))),
                          ),
                        ),
                      )),
                  MyFlexItem(
                      sizes: 'lg-4',
                      child: MyContainer(
                        paddingAll: 0,
                        borderRadiusAll: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: MySpacing.only(left: 16, top: 12),
                              child: MyText.bodyMedium(
                                "Up coming Classes",
                                fontWeight: 600,
                              ),
                            ),
                            buildUpComingClasses(
                              LucideIcons.pencil,
                              "Generative AI for Everyone",
                              Images.avatars[8],
                              'Templeton',
                              "4h 59m",
                            ),
                            Divider(),
                            buildUpComingClasses(
                              LucideIcons.bookMarked,
                              "Generative AI Fundamentals Specialization",
                              Images.avatars[9],
                              'Milicent',
                              "2h",
                            ),
                            Divider(),
                            buildUpComingClasses(
                              LucideIcons.bookOpen,
                              "ChatGPT Advanced Data Analysis",
                              Images.avatars[10],
                              'Alexandros',
                              "1h 15m",
                            ),
                            Divider(),
                            buildUpComingClasses(
                              LucideIcons.library,
                              "Introduction to Generative AI",
                              Images.avatars[11],
                              'Ugo',
                              "3h 45m",
                            ),
                          ],
                        ),
                      )),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildUpComingClasses(
      IconData icon, String subName, String image, String name, String time) {
    return Padding(
      padding: MySpacing.xy(16, 16),
      child: Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 60,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(image),
          ),
          MySpacing.width(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium(subName, fontWeight: 600),
              MySpacing.height(4),
              MyText.bodyMedium(
                name,
                fontWeight: 600,
                muted: true,
              ),
              MySpacing.height(4),
              Row(
                children: [
                  Icon(LucideIcons.clock4, size: 16),
                  MySpacing.width(12),
                  MyText.bodyMedium(
                    time,
                    fontWeight: 600,
                    muted: true,
                  )
                ],
              ),
            ],
          ),
          Spacer(),
          MyContainer.bordered(
            borderRadiusAll: 8,
            paddingAll: 20,
            color: contentTheme.secondary.withAlpha(40),
            child: Icon(
              icon,
              color: contentTheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStudentOverView() {
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyContainer.rounded(
              height: 135,
              width: 135,
              paddingAll: 0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                Images.avatars[2],
                fit: BoxFit.cover,
              ),
            ),
            MySpacing.height(12),
            MyText.bodyLarge(
              "James David",
              fontWeight: 600,
            ),
            MyText.bodyMedium("Student - Beginner",
                fontWeight: 600, muted: true),
            MySpacing.height(12),
            MyContainer.bordered(
              borderRadiusAll: 8,
              child: Row(
                children: [
                  MyContainer.rounded(
                    paddingAll: 12,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: contentTheme.info.withAlpha(40),
                    child: Icon(LucideIcons.userCog2, color: contentTheme.info),
                  ),
                  MySpacing.width(12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.bodyLarge("150", fontWeight: 600),
                      MyText.bodyMedium("Earning Point",
                          fontWeight: 600, muted: true)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        MySpacing.width(12),
        Expanded(
          child: MyFlex(children: [
            MyFlexItem(
                sizes: 'lg-6',
                child: MyContainer.bordered(
                  height: 130,
                  borderRadiusAll: 8,
                  child: buildDetail(
                    LucideIcons.calendarClock,
                    contentTheme.primary,
                    "04",
                    "Pending Courses",
                  ),
                )),
            MyFlexItem(
                sizes: 'lg-6',
                child: MyContainer.bordered(
                  height: 130,
                  borderRadiusAll: 8,
                  child: buildDetail(
                    LucideIcons.graduationCap,
                    contentTheme.info,
                    "15",
                    "Completed",
                  ),
                )),
            MyFlexItem(
                sizes: 'lg-6',
                child: MyContainer.bordered(
                  height: 130,
                  borderRadiusAll: 8,
                  child: buildDetail(
                    LucideIcons.hourglass,
                    contentTheme.warning,
                    "70h",
                    "Watch Time",
                  ),
                )),
            MyFlexItem(
                sizes: 'lg-6',
                child: MyContainer.bordered(
                  height: 130,
                  borderRadiusAll: 8,
                  child: buildDetail(
                    LucideIcons.trophy,
                    contentTheme.success,
                    "12",
                    "Certificates",
                  ),
                )),
          ]),
        ),
      ],
    );
  }
}
