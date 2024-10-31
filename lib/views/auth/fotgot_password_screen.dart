import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/auth/fotgot_password_controller.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/widgets/my_button.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/helpers/widgets/my_text_style.dart';
import 'package:study/views/layouts/auth_layout.dart';
import 'package:study/helpers/extensions/string.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late ForgotPasswordController controller;

  @override
  void initState() {
    controller = Get.put(ForgotPasswordController());
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
                    "forgot_password".tr().capitalizeWords,
                    fontWeight: 700,
                  ),
                ),
                MySpacing.height(10),
                Center(
                  child: MyText.bodyLarge(
                    "Enter the email address associated with your account we'll send an email with instructions on how to recover your password",
                    fontSize: 16,
                    fontWeight: 600,
                    textAlign: TextAlign.center,
                    muted: true,
                  ),
                ),
                MySpacing.height(45),
                MyText.labelLarge("email_address".tr().capitalizeWords),
                MySpacing.height(4),
                TextFormField(
                  validator: controller.basicValidator.getValidation('email'),
                  controller: controller.basicValidator.getController('email'),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "email_address".tr().capitalizeWords,
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
                MySpacing.height(28),
                Center(
                  child: MyButton.rounded(
                    onPressed: controller.onForgotPassword,
                    elevation: 0,
                    padding: MySpacing.xy(20, 16),
                    backgroundColor: contentTheme.primary,
                    child: MyText.bodySmall(
                      'forgot_password'.tr().capitalizeWords,
                      fontSize: 14,
                      color: contentTheme.onPrimary,
                    ),
                  ),
                ),
                Center(
                  child: MyButton.text(
                    onPressed: controller.gotoLogIn,
                    elevation: 0,
                    padding: MySpacing.x(16),
                    splashColor: contentTheme.secondary.withOpacity(0.1),
                    child: MyText.labelMedium(
                      'back_to_log_in'.tr(),
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
