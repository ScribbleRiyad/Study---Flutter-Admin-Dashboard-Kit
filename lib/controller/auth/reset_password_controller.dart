import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/helpers/services/auth_service.dart';
import 'package:study/helpers/widgets/my_form_validator.dart';

class ResetPasswordController extends MyController {
  MyFormValidator basicV = MyFormValidator();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String password = '';
  String confirmPassword1 = '';

  bool showPassword = false;

  bool confirmPassword = false;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void onLogin(context) async {
    if (basicV.validateForm()) {
      if (password == confirmPassword1) {
        Get.toNamed('/starter');
      } else {
        var errors = await AuthService.loginUser(basicV.getData());
        if (errors != null) {
          basicV.addErrors(errors);
          basicV.validateForm();
          basicV.clearErrors();
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Password Mismatch'),
              content: Text('The passwords do not match.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void onResetPassword() {
    confirmPassword = !confirmPassword;
    update();
  }
}
