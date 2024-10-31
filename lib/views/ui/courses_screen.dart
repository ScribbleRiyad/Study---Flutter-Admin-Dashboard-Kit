import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/ui/courses_controller.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/widgets/my_breadcrumb.dart';
import 'package:study/helpers/widgets/my_breadcrumb_item.dart';
import 'package:study/helpers/widgets/my_container.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_star_rating.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/images.dart';
import 'package:study/models/courses_model.dart';
import 'package:study/views/layouts/layout.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late CoursesController controller;

  @override
  void initState() {
    controller = Get.put(CoursesController());
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
                      "Courses",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Client'),
                        MyBreadcrumbItem(name: 'Courses', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyContainer(
                  borderRadiusAll: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 302,
                        child: TextField(
                          controller: controller.searchController,
                          onChanged: controller.searchCourseList,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              LucideIcons.search,
                              size: 20,
                            ),
                            hintText: "Search Courses",
                            border: const OutlineInputBorder(),
                            contentPadding: MySpacing.all(16),
                          ),
                        ),
                      ),
                      MySpacing.height(12),
                      GridView.builder(
                        shrinkWrap: true,
                        primary: true,
                        itemCount: controller.searchCourse.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            mainAxisExtent: 373),
                        itemBuilder: (context, index) {
                          CoursesModel course = controller.searchCourse[index];
                          return MyContainer.bordered(
                            borderRadiusAll: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyContainer(
                                  paddingAll: 0,
                                  height: 150,
                                  borderRadiusAll: 8,
                                  width: double.infinity,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.asset(
                                    course.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                MySpacing.height(12),
                                Row(
                                  children: [
                                    MyContainer.rounded(
                                      paddingAll: 0,
                                      height: 40,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Image.asset(
                                        Images.avatars[
                                            index % Images.avatars.length],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    MySpacing.width(8),
                                    MyText.bodyMedium(
                                      "${course.name}",
                                      fontWeight: 600,
                                    ),
                                  ],
                                ),
                                MySpacing.height(12),
                                MyText.bodyLarge(
                                  "Course Name :${course.courseName}",
                                  fontWeight: 600,
                                ),
                                MySpacing.height(12),
                                Row(
                                  children: [
                                    Icon(
                                      LucideIcons.user,
                                      size: 16,
                                    ),
                                    MyText.bodyMedium(
                                        " ${course.students} Students"),
                                    MySpacing.width(12),
                                    Icon(
                                      LucideIcons.file,
                                      size: 16,
                                    ),
                                    MyText.bodyMedium(
                                        " ${course.lessons} Lessons"),
                                  ],
                                ),
                                MySpacing.height(12),
                                Row(
                                  children: [
                                    MyStarRating(
                                      rating: course.rating,
                                      size: 20,
                                      spacing: 12,
                                      inactiveColor: contentTheme.secondary,
                                      activeColor: AppColors.star,
                                    ),
                                    MyText.bodyLarge("(${course.rating})"),
                                  ],
                                ),
                                MySpacing.height(12),
                                MyText.bodyLarge(
                                  "\$ ${course.price}",
                                  fontWeight: 600,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
