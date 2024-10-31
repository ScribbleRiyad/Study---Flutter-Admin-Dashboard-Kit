import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/helpers/extensions/string.dart';
import 'package:flutter/material.dart';

import 'package:study/controller/auth/login_controller.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/widgets/my_button.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/helpers/widgets/my_text_style.dart';
import 'package:study/views/layouts/auth_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late LoginController controller;

  @override
  void initState() {
    controller = Get.put(LoginController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Form(
            key: controller.basicValidator.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: MyText.titleLarge(
                    "Welcome Back, Please login \nto your account",
                    fontWeight: 700,
                    muted: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                MySpacing.height(32),
                MyText.labelLarge(
                  "email_address".tr().capitalizeWords,
                ),
                MySpacing.height(8),
                TextFormField(
                  validator: controller.basicValidator.getValidation('email'),
                  controller: controller.basicValidator.getController('email'),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: "Email Address",
                      labelStyle: MyTextStyle.bodyLarge(xMuted: true),
                      border: outlineInputBorder,
                      prefixIcon: Icon(
                        LucideIcons.mail,
                        size: 20,
                      ),
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                ),
                MySpacing.height(16),
                MyText.labelLarge(
                  "password".tr(),
                ),
                MySpacing.height(8),
                TextFormField(
                  validator:
                      controller.basicValidator.getValidation('password'),
                  controller:
                      controller.basicValidator.getController('password'),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !controller.showPassword,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: MyTextStyle.bodyLarge(xMuted: true),
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
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: MyButton.text(
                    onPressed: controller.goToForgotPassword,
                    elevation: 0,
                    padding: MySpacing.xy(8, 0),
                    splashColor: contentTheme.secondary.withOpacity(0.1),
                    child: MyText.labelLarge(
                      'forgot_password?'.tr().capitalizeWords,
                      color: contentTheme.secondary,
                    ),
                  ),
                ),
                MySpacing.height(28),
                Center(
                  child: MyButton.rounded(
                    onPressed: controller.onLogin,
                    elevation: 0,
                    borderRadiusAll: 6,
                    padding: MySpacing.xy(20, 16),
                    backgroundColor: contentTheme.primary,
                    child: MyText.bodySmall(
                      'login'.tr(),
                      fontSize: 16,
                      fontWeight: 600,
                      color: contentTheme.onPrimary,
                    ),
                  ),
                ),
                Center(
                  child: MyButton.text(
                    onPressed: controller.gotoRegister,
                    elevation: 0,
                    padding: MySpacing.x(16),
                    splashColor: contentTheme.secondary.withOpacity(0.1),
                    child: MyText.labelMedium(
                      'I haven\'t account',
                      color: contentTheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
