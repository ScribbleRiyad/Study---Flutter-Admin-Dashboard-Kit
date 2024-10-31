import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/ui/courses/course_detail_controller.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/widgets/my_breadcrumb.dart';
import 'package:study/helpers/widgets/my_breadcrumb_item.dart';
import 'package:study/helpers/widgets/my_button.dart';
import 'package:study/helpers/widgets/my_container.dart';
import 'package:study/helpers/widgets/my_flex.dart';
import 'package:study/helpers/widgets/my_flex_item.dart';
import 'package:study/helpers/widgets/my_progress_bar.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_star_rating.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/images.dart';
import 'package:study/views/layouts/layout.dart';
import 'package:video_player/video_player.dart';

class CoursesDetailScreen extends StatefulWidget {
  const CoursesDetailScreen({super.key});

  @override
  State<CoursesDetailScreen> createState() => _CoursesDetailScreenState();
}

class _CoursesDetailScreenState extends State<CoursesDetailScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late CoursesDetailController controller;

  @override
  void initState() {
    controller = Get.put(CoursesDetailController());

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
                      "Courses Detail",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Courses Detail', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(children: [
                  MyFlexItem(sizes: 'lg-8', child: buildCourseOverView()),
                  MyFlexItem(sizes: 'lg-4', child: buildVideoPlayer()),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildVideoPlayer() {
    Widget buildCourseDetail(IconData icon, String title, String time) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 16),
              MySpacing.width(8),
              MyText.bodyMedium(title, fontWeight: 600),
            ],
          ),
          MyText.bodyMedium(
            time,
            fontWeight: 600,
          )
        ],
      );
    }

    return MyContainer(
      borderRadiusAll: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyContainer(
            borderRadiusAll: 8,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            paddingAll: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                controller.videoController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio:
                            controller.videoController.value.aspectRatio,
                        child: VideoPlayer(controller.videoController),
                      )
                    : Container(),
                Center(
                  child: MyContainer.rounded(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          controller.videoController.value.isPlaying
                              ? controller.videoController.pause()
                              : controller.videoController.play();
                        });
                      },
                      icon: Icon(
                        controller.videoController.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          MySpacing.height(12),
          MyText.bodyLarge(
            "Price :\$49.99",
            fontWeight: 600,
          ),
          MySpacing.height(20),
          buildCourseDetail(LucideIcons.clock, "Duration", "40 Minutes"),
          MySpacing.height(12),
          Divider(),
          MySpacing.height(12),
          buildCourseDetail(LucideIcons.menu, "Level", "Expert"),
          MySpacing.height(12),
          Divider(),
          MySpacing.height(12),
          buildCourseDetail(LucideIcons.file, "Lectures", "5 Lectures"),
          MySpacing.height(12),
          Divider(),
          MySpacing.height(12),
          buildCourseDetail(LucideIcons.languages, "Language", "English"),
          MySpacing.height(12),
          Divider(),
          MySpacing.height(12),
          buildCourseDetail(LucideIcons.user, "Enrolled", "3 Enrolled"),
          MySpacing.height(20),
          MyButton.block(
            onPressed: () => controller.gotoCartScreen(),
            elevation: 0,
            padding: MySpacing.y(16),
            child: MyText.bodyMedium(
              "Add To cart",
              color: contentTheme.onPrimary,
              fontWeight: 600,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCourseOverView() {
    Widget buildRating(double rating) {
      return MyStarRating(
        rating: rating,
        size: 20,
        spacing: 12,
        inactiveColor: contentTheme.secondary,
        activeColor: AppColors.star,
      );
    }

    Widget buildReviews(String image, String name, String time, double number,
        String description) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 100,
            width: 100,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.bodyMedium(name, fontWeight: 600),
                    MyText.bodyMedium(
                      time,
                      fontWeight: 600,
                      muted: true,
                    ),
                  ],
                ),
                MySpacing.height(12),
                buildRating(number),
                MySpacing.height(12),
                MyText.bodyMedium(
                  description,
                  fontWeight: 600,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      );
    }

    Widget buildReviewRatingChart(
        String number, double processBar, Color color, String ratingNumber) {
      return Row(
        children: [
          Icon(
            Icons.star,
            size: 20,
            color: contentTheme.warning,
          ),
          MySpacing.width(8),
          MyText.bodyMedium(
            number,
            fontWeight: 600,
          ),
          MySpacing.width(8),
          MyProgressBar(
              progress: processBar,
              height: 8,
              radius: 0,
              inactiveColor: theme.dividerColor,
              activeColor: colorScheme.primary),
          MySpacing.width(8),
          MyText.titleMedium(
            ratingNumber,
            fontSize: 16,
            fontWeight: 600,
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
            "Course OverView",
            fontWeight: 700,
            fontSize: 20,
          ),
          MySpacing.height(8),
          MyText.bodyMedium(
            controller.dummyTexts[11],
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
          MySpacing.height(16),
          MyText.bodyLarge(
            "Course Instructor",
            fontSize: 20,
            fontWeight: 700,
          ),
          MySpacing.height(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyContainer(
                paddingAll: 0,
                height: 150,
                width: 150,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  Images.avatars[12],
                  fit: BoxFit.cover,
                ),
              ),
              MySpacing.width(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyText.bodyLarge("Alena Hedge", fontWeight: 600),
                    Row(
                      children: [
                        MyStarRating(
                          rating: 4.6,
                          size: 20,
                          spacing: 2,
                          inactiveColor: contentTheme.secondary,
                          activeColor: AppColors.star,
                        ),
                        MyText.bodyLarge(
                          "(4.6)",
                          fontWeight: 600,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(LucideIcons.playCircle, size: 16),
                        MySpacing.width(4),
                        MyText.bodyMedium("8 Tutorials", fontWeight: 600),
                      ],
                    ),
                    MySpacing.height(8),
                    MyText.bodyMedium(
                      controller.dummyTexts[5],
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
          MySpacing.height(16),
          MyText.bodyLarge(
            "Review",
            fontWeight: 700,
          ),
          MySpacing.height(12),
          MyFlex(
            contentPadding: false,
            children: [
              MyFlexItem(
                sizes: "lg-3",
                child: MyContainer.bordered(
                  height: 170,
                  width: 170,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyText.headlineLarge("4.7", fontWeight: 600),
                      MyStarRating(
                        rating: 4.7,
                        size: 20,
                        spacing: 4,
                        inactiveColor: contentTheme.secondary,
                        activeColor: AppColors.star,
                      ),
                      MyText.bodyLarge("Total 3 Rating", fontWeight: 600)
                    ],
                  ),
                ),
              ),
              MyFlexItem(
                  sizes: "lg-9",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildReviewRatingChart(
                          "5 Star", 0.9, contentTheme.primary, "5.0k"),
                      MySpacing.height(12),
                      buildReviewRatingChart(
                          "4 Star", 0.5, contentTheme.title, "3.0k"),
                      MySpacing.height(12),
                      buildReviewRatingChart(
                          "3 Star", 0.3, contentTheme.warning, "400"),
                      MySpacing.height(12),
                      buildReviewRatingChart(
                          "2 Star", 0.2, contentTheme.success, "100"),
                      MySpacing.height(12),
                      buildReviewRatingChart(
                          "1 Star", 0.5, contentTheme.info, "4k"),
                    ],
                  )),
            ],
          ),
          MySpacing.height(16),
          buildReviews(
            Images.avatars[2],
            'David Gea',
            '8 Month ago',
            3.5,
            controller.dummyTexts[5],
          ),
          MySpacing.height(20),
          buildReviews(
            Images.avatars[9],
            'Andrew packer',
            '11 Month ago',
            2,
            controller.dummyTexts[4],
          ),
        ],
      ),
    );
  }
}
