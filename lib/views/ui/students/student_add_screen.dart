import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/app_constant.dart';
import 'package:study/controller/ui/students/students_add_contorller.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/widgets/my_breadcrumb.dart';
import 'package:study/helpers/widgets/my_breadcrumb_item.dart';
import 'package:study/helpers/widgets/my_button.dart';
import 'package:study/helpers/widgets/my_container.dart';
import 'package:study/helpers/widgets/my_flex.dart';
import 'package:study/helpers/widgets/my_flex_item.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/helpers/widgets/my_text_style.dart';
import 'package:study/views/layouts/layout.dart';

class StudentAddScreen extends StatefulWidget {
  const StudentAddScreen({super.key});

  @override
  State<StudentAddScreen> createState() => _StudentAddScreenState();
}

class _StudentAddScreenState extends State<StudentAddScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late StudentAddController controller;

  @override
  void initState() {
    controller = Get.put(StudentAddController());
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
                      "Add Student",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Add Student', active: true),
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
                                buildTextField(
                                    'First Name', 'Enter First Name'),
                                MySpacing.height(20),
                                buildTextField('Last Name', 'Enter Last Name'),
                                MySpacing.height(20),
                                buildTextField('Email', 'Enter Email'),
                                MySpacing.height(20),
                                buildTextField('Roll No.', 'Enter Roll No.'),
                                MySpacing.height(20),
                                buildTextField(
                                    'Phone Number', 'Enter Phone Number'),
                              ],
                            )),
                        MyFlexItem(
                            sizes: 'lg-6',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.labelMedium(
                                  "DOB",
                                ),
                                MySpacing.height(8),
                                MyContainer.bordered(
                                  width: double.infinity,
                                  padding: MySpacing.xy(12, 12),
                                  borderRadiusAll: 8,
                                  onTap: () => controller.pickDate(),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        MyText.labelMedium(
                                          controller.selectedDate != null
                                              ? dateFormatter.format(
                                                  controller.selectedDate!)
                                              : "Select DOB",
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
                                MyText.labelMedium(
                                  'category',
                                ),
                                MySpacing.height(8),
                                DropdownButtonFormField<Religion>(
                                  dropdownColor: colorScheme.surface,
                                  menuMaxHeight: 200,
                                  isDense: true,
                                  items: Religion.values
                                      .map(
                                        (category) =>
                                            DropdownMenuItem<Religion>(
                                          value: category,
                                          child: MyText.labelMedium(
                                            category.name.capitalize!,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  icon: Icon(
                                    LucideIcons.chevronDown,
                                    size: 20,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Select category",
                                    hintStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                    border: outlineInputBorder,
                                    enabledBorder: outlineInputBorder,
                                    focusedBorder: focusedInputBorder,
                                    contentPadding: MySpacing.all(14),
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                  ),
                                  onChanged: controller.basicValidator
                                      .onChanged<Object?>(
                                    'Religion',
                                  ),
                                ),
                                MySpacing.height(20),
                                MyText.labelMedium(
                                  'Section',
                                ),
                                MySpacing.height(8),
                                DropdownButtonFormField<Section>(
                                  dropdownColor: colorScheme.surface,
                                  menuMaxHeight: 200,
                                  isDense: true,
                                  items: Section.values
                                      .map(
                                        (category) => DropdownMenuItem<Section>(
                                          value: category,
                                          child: MyText.labelMedium(
                                            category.name.capitalize!,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  icon: Icon(
                                    LucideIcons.chevronDown,
                                    size: 20,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Select Section",
                                    hintStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                    border: outlineInputBorder,
                                    enabledBorder: outlineInputBorder,
                                    focusedBorder: focusedInputBorder,
                                    contentPadding: MySpacing.all(14),
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                  ),
                                  onChanged: controller.basicValidator
                                      .onChanged<Object?>(
                                    'Section',
                                  ),
                                ),
                                MySpacing.height(20),
                                MyText.labelMedium(
                                  'Gender',
                                ),
                                MySpacing.height(8),
                                DropdownButtonFormField<Gender>(
                                  dropdownColor: colorScheme.surface,
                                  menuMaxHeight: 200,
                                  isDense: true,
                                  items: Gender.values
                                      .map(
                                        (category) => DropdownMenuItem<Gender>(
                                          value: category,
                                          child: MyText.labelMedium(
                                            category.name.capitalize!,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  icon: Icon(
                                    LucideIcons.chevronDown,
                                    size: 20,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Select category",
                                    hintStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                    border: outlineInputBorder,
                                    enabledBorder: outlineInputBorder,
                                    focusedBorder: focusedInputBorder,
                                    contentPadding: MySpacing.all(14),
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                  ),
                                  onChanged: controller.basicValidator
                                      .onChanged<Object?>(
                                    'Gender',
                                  ),
                                ),
                                MySpacing.height(20),
                                MyText.labelMedium(
                                  'Blood Group',
                                ),
                                MySpacing.height(8),
                                DropdownButtonFormField<BloodGroup>(
                                  dropdownColor: colorScheme.surface,
                                  menuMaxHeight: 200,
                                  isDense: true,
                                  items: BloodGroup.values
                                      .map(
                                        (category) =>
                                            DropdownMenuItem<BloodGroup>(
                                          value: category,
                                          child: MyText.labelMedium(
                                            "${category.name.capitalize!}+",
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  icon: Icon(
                                    LucideIcons.chevronDown,
                                    size: 20,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Select BloodGroup",
                                    hintStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                    border: outlineInputBorder,
                                    enabledBorder: outlineInputBorder,
                                    focusedBorder: focusedInputBorder,
                                    contentPadding: MySpacing.all(14),
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                  ),
                                  onChanged: controller.basicValidator
                                      .onChanged<Object?>(
                                    'BloodGroup',
                                  ),
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
    String fieldTitle,
    String hintText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.labelMedium(
          fieldTitle,
        ),
        MySpacing.height(8),
        TextFormField(
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
