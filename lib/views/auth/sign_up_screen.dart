import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:study/helpers/extensions/string.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/auth/sign_up_controller.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/widgets/my_button.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/helpers/widgets/my_text_style.dart';
import 'package:study/views/layouts/auth_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late SignUpController controller;

  @override
  void initState() {
    controller = Get.put(SignUpController());
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
                  "register".tr(),
                  fontWeight: 700,
                )),
                MySpacing.height(10),
                Center(
                    child: MyText.bodyLarge(
                  "We are proud to have you as an user joining our already existing platform of awesome users.",
                  textAlign: TextAlign.center,
                  fontWeight: 600,
                  muted: true,
                )),
                MySpacing.height(45),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.labelLarge(
                            "first_name".tr().capitalizeWords,
                          ),
                          MySpacing.height(4),
                          TextFormField(
                            validator: controller.basicValidator
                                .getValidation('first_name'),
                            controller: controller.basicValidator
                                .getController('first_name'),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "First Name",
                              labelStyle: MyTextStyle.bodyLarge(xMuted: true),
                              border: outlineInputBorder,
                              prefixIcon: Icon(
                                LucideIcons.user,
                                size: 20,
                              ),
                              contentPadding: MySpacing.all(16),
                              isCollapsed: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MySpacing.width(20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.labelLarge(
                            "last_name".tr().capitalizeWords,
                          ),
                          MySpacing.height(4),
                          TextFormField(
                            validator: controller.basicValidator
                                .getValidation('last_name'),
                            controller: controller.basicValidator
                                .getController('last_name'),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Last Name",
                              labelStyle: MyTextStyle.bodyLarge(xMuted: true),
                              border: outlineInputBorder,
                              prefixIcon: Icon(
                                LucideIcons.user,
                                size: 20,
                              ),
                              contentPadding: MySpacing.all(16),
                              isCollapsed: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                MySpacing.height(20),
                MyText.labelLarge(
                  "email_address".tr().capitalizeWords,
                ),
                MySpacing.height(4),
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
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
                MySpacing.height(20),
                MyText.labelLarge(
                  "password".tr().capitalizeWords,
                ),
                MySpacing.height(4),
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
                MySpacing.height(30),
                Center(
                  child: MyButton.rounded(
                    onPressed: controller.onLogin,
                    elevation: 0,
                    borderRadiusAll: 6,
                    padding: MySpacing.xy(20, 16),
                    backgroundColor: contentTheme.primary,
                    child: MyText.bodySmall(
                      'register'.tr(),
                      fontWeight: 600,
                      fontSize: 14,
                      color: contentTheme.onPrimary,
                    ),
                  ),
                ),
                Center(
                  child: MyButton.text(
                    onPressed: controller.gotoLogin,
                    elevation: 0,
                    padding: MySpacing.x(16),
                    splashColor: contentTheme.secondary.withOpacity(0.1),
                    child: MyText.labelLarge(
                      'already_have_account_?'.tr(),
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
