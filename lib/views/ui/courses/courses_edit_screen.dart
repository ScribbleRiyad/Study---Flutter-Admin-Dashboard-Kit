import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/app_constant.dart';
import 'package:study/controller/ui/courses/course_edit_controller.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/utils/utils.dart';
import 'package:study/helpers/widgets/my_breadcrumb.dart';
import 'package:study/helpers/widgets/my_breadcrumb_item.dart';
import 'package:study/helpers/widgets/my_button.dart';
import 'package:study/helpers/widgets/my_container.dart';
import 'package:study/helpers/widgets/my_dotted_line.dart';
import 'package:study/helpers/widgets/my_flex.dart';
import 'package:study/helpers/widgets/my_flex_item.dart';
import 'package:study/helpers/widgets/my_list_extension.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/helpers/widgets/my_text_style.dart';
import 'package:study/views/layouts/layout.dart';

class CoursesEditScreen extends StatefulWidget {
  const CoursesEditScreen({super.key});

  @override
  State<CoursesEditScreen> createState() => _CoursesEditScreenState();
}

class _CoursesEditScreenState extends State<CoursesEditScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late CoursesEditController controller;

  @override
  void initState() {
    controller = Get.put(CoursesEditController());
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
                      "Edit Courses",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Edit Courses', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyContainer(
                  paddingAll: 0,
                  borderRadiusAll: 8,
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
                                buildTextField(
                                  "Course Name",
                                  'Course Name',
                                  controller.basicValidator
                                      .getController('course_name'),
                                ),
                                Padding(
                                  padding: MySpacing.y(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.labelMedium(
                                        "Course Detail",
                                      ),
                                      MySpacing.height(8),
                                      TextFormField(
                                        controller: controller.basicValidator
                                            .getController('course_detail'),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 3,
                                        style: MyTextStyle.bodyMedium(),
                                        decoration: InputDecoration(
                                          hintText: "Course Detail",
                                          hintStyle: MyTextStyle.bodySmall(
                                              xMuted: true),
                                          border: outlineInputBorder,
                                          enabledBorder: outlineInputBorder,
                                          focusedBorder: focusedInputBorder,
                                          contentPadding: MySpacing.all(16),
                                          isCollapsed: true,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                buildTextField(
                                  'Course Duration',
                                  'Course Duration',
                                  controller.basicValidator
                                      .getController('course_duration'),
                                ),
                                MySpacing.height(16),
                                buildTextField(
                                  'Professor Name',
                                  'Professor Name',
                                  controller.basicValidator
                                      .getController('professor_name'),
                                ),
                                MySpacing.height(16),
                                buildTextField(
                                  'Contact Number',
                                  'Contact Number',
                                  controller.basicValidator
                                      .getController('contact_number'),
                                ),
                              ],
                            )),
                        MyFlexItem(
                            sizes: 'lg-6',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildTextField(
                                  'Course Code',
                                  'Course Code',
                                  controller.basicValidator
                                      .getController('course_code'),
                                ),
                                MySpacing.height(16),
                                MyText.labelMedium(
                                  "DOB",
                                ),
                                MySpacing.height(8),
                                MyContainer.bordered(
                                  width: double.infinity,
                                  padding: MySpacing.xy(12, 12),
                                  borderRadiusAll: 4,
                                  onTap: () => controller.pickDate(),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        MyText.bodySmall(
                                          controller.selectedDate != null
                                              ? dateFormatter.format(
                                                  controller.selectedDate!)
                                              : "17 November 2021",
                                          fontWeight: 600,
                                        ),
                                        Icon(
                                          LucideIcons.calendar,
                                          color: colorScheme.primary,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                MySpacing.height(16),
                                buildTextField(
                                  'Course Prise',
                                  'Course Prise',
                                  controller.basicValidator
                                      .getController('course_prise'),
                                ),
                                MySpacing.height(16),
                                buildTextField(
                                  'Maximum Student',
                                  'Maximum Student',
                                  controller.basicValidator
                                      .getController('maximum_student'),
                                ),
                                MySpacing.height(16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyText.bodyMedium(
                                      "Course Images",
                                      fontSize: 12,
                                      fontWeight: 600,
                                    ),
                                    MySpacing.height(16),
                                    InkWell(
                                      onTap: controller.pickFile,
                                      child: MyDottedLine(
                                        strokeWidth: 0.2,
                                        color: contentTheme.onBackground,
                                        corner: MyDottedLineCorner(
                                          leftBottomCorner: 2,
                                          leftTopCorner: 2,
                                          rightBottomCorner: 2,
                                          rightTopCorner: 2,
                                        ),
                                        child: Center(
                                          heightFactor: 1.5,
                                          child: Padding(
                                            padding: MySpacing.all(8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(LucideIcons.uploadCloud,
                                                    size: 22),
                                                MyContainer(
                                                  width: 340,
                                                  alignment: Alignment.center,
                                                  paddingAll: 0,
                                                  child: MyText.titleMedium(
                                                    "Select Images to Upload",
                                                    fontWeight: 600,
                                                    muted: true,
                                                    fontSize: 18,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (controller.files.isNotEmpty) ...[
                                      MySpacing.height(16),
                                      Wrap(
                                        spacing: 16,
                                        runSpacing: 16,
                                        children: controller.files
                                            .mapIndexed((index, file) =>
                                                MyContainer.bordered(
                                                  paddingAll: 8,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      MyContainer(
                                                        color: contentTheme
                                                            .onBackground
                                                            .withAlpha(28),
                                                        paddingAll: 8,
                                                        child: Icon(
                                                          LucideIcons.file,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      MySpacing.width(16),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          MyText.bodyMedium(
                                                            file.name,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontWeight: 600,
                                                          ),
                                                          MyText.bodySmall(
                                                            Utils.getStorageStringFromByte(
                                                                file.bytes
                                                                        ?.length ??
                                                                    0),
                                                          ),
                                                        ],
                                                      ),
                                                      MySpacing.width(32),
                                                      MyContainer.roundBordered(
                                                        onTap: () => controller
                                                            .removeFile(file),
                                                        paddingAll: 4,
                                                        child: Icon(
                                                          LucideIcons.x,
                                                          size: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                      )
                                    ],
                                  ],
                                ),
                                MySpacing.height(16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MyButton(
                                      onPressed: () {},
                                      elevation: 0,
                                      padding: MySpacing.xy(20, 16),
                                      backgroundColor: contentTheme.primary,
                                      borderRadiusAll:
                                          AppStyle.buttonRadius.medium,
                                      child: MyText.bodySmall(
                                        'Save',
                                        color: contentTheme.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildTextField(
      String fieldTitle, String hintText, TextEditingController? controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.labelMedium(
          fieldTitle,
        ),
        MySpacing.height(8),
        TextFormField(
          controller: controller,
          style: MyTextStyle.bodyMedium(),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: MyTextStyle.bodySmall(xMuted: true),
            border: outlineInputBorder,
            contentPadding: MySpacing.all(16),
            isCollapsed: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ],
    );
  }
}
