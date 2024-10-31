import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/auth/reset_password_controller.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/widgets/my_button.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/helpers/widgets/my_text_style.dart';
import 'package:study/views/layouts/auth_layout.dart';
import 'package:study/helpers/extensions/string.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late ResetPasswordController controller;

  @override
  void initState() {
    controller = Get.put(ResetPasswordController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Form(
            key: controller.basicV.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: MyText.titleLarge(
                    "reset_password".tr().capitalizeWords,
                    fontWeight: 700,
                  ),
                ),
                MySpacing.height(10),
                Center(
                  child: MyText.bodySmall(
                    "your_password_will_be_reset".tr(),
                    muted: true,
                  ),
                ),
                MySpacing.height(45),
                MyText.labelMedium("password".tr()),
                MySpacing.height(4),
                TextFormField(
                  controller: controller.passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !controller.showPassword,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: MyTextStyle.bodySmall(xMuted: true),
                    border: outlineInputBorder,
                    prefixIcon: Icon(
                      LucideIcons.lock,
                      size: 20,
                    ),
                    suffixIcon: InkWell(
                      onTap: controller.onChangeShowPassword,
                      child: Icon(
                        controller.showPassword
                            ? LucideIcons.eye
                            : LucideIcons.eyeOff,
                        size: 20,
                      ),
                    ),
                    contentPadding: MySpacing.all(16),
                    isCollapsed: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      controller.password = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                MyText.labelMedium("confirm_password".tr().capitalizeWords),
                TextFormField(
                  controller: controller.confirmPasswordController,
                  obscureText: controller.confirmPassword,
                  keyboardType: TextInputType.visiblePassword,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: MyTextStyle.bodySmall(xMuted: true),
                    border: outlineInputBorder,
                    prefixIcon: Icon(LucideIcons.lock, size: 20),
                    suffixIcon: InkWell(
                      onTap: controller.onResetPassword,
                      child: Icon(
                          controller.confirmPassword
                              ? LucideIcons.eyeOff
                              : LucideIcons.eye,
                          size: 20),
                    ),
                    contentPadding: MySpacing.all(16),
                    isCollapsed: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a confirm password';
                    }
                    if (value != controller.passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      controller.confirmPassword1 = value;
                    });
                  },
                ),
                SizedBox(height: 24.0),
                Center(
                  child: MyButton.rounded(
                      onPressed: () {
                        controller.onLogin(context);
                      },
                      elevation: 0,
                      padding: MySpacing.xy(20, 16),
                      child: MyText.bodyMedium(
                        "Confirm",
                        color: contentTheme.onPrimary,
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
