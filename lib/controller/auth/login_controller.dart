import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/helpers/services/auth_service.dart';
import 'package:study/helpers/widgets/my_form_validator.dart';
import 'package:study/helpers/widgets/my_validators.dart';

class LoginController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();

  bool showPassword = false;

  final String _dummyEmail = "study@demo.com";
  final String _dummyPassword = "1234567";

  @override
  void onInit() {
    super.onInit();
    basicValidator.addField('email',
        required: true,
        label: "Email",
        validators: [MyEmailValidator()],
        controller: TextEditingController(text: _dummyEmail));

    basicValidator.addField('password',
        required: true,
        label: "Password",
        validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController(text: _dummyPassword));
  }

  // UI
  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  // Services
  Future<void> onLogin() async {
    if (basicValidator.validateForm()) {
      update();
      var errors = await AuthService.loginUser(basicValidator.getData());
      if (errors != null) {
        basicValidator.addErrors(errors);
        basicValidator.validateForm();
        basicValidator.clearErrors();
      } else {
        String nextUrl =
            Uri.parse(ModalRoute.of(Get.context!)?.settings.name ?? "")
                    .queryParameters['next'] ??
                "/client/home";
        Get.toNamed(
          nextUrl,
        );
      }
      update();
    }
  }

  // Navigation
  void goToForgotPassword() {
    Get.toNamed('/auth/forgot_password');
  }

  void gotoRegister() {
    Get.toNamed('/auth/sign_up');
  }
}
