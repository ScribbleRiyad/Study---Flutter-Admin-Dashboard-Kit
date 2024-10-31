import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study/controller/layouts/auth_layout_controller.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/widgets/my_container.dart';
import 'package:study/helpers/widgets/my_flex.dart';
import 'package:study/helpers/widgets/my_flex_item.dart';
import 'package:study/helpers/widgets/my_responsiv.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/images.dart';

class AuthLayout extends StatelessWidget {
  final Widget? child;

  final AuthLayoutController controller = AuthLayoutController();

  AuthLayout({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return MyResponsive(builder: (BuildContext context, _, screenMT) {
      return GetBuilder(
          init: controller,
          builder: (controller) {
            return screenMT.isMobile
                ? mobileScreen(context)
                : largeScreen(context);
          });
    });
  }

  Widget mobileScreen(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: MyContainer(
        height: MediaQuery.of(context).size.height,
        color: theme.cardTheme.color,
        child: Column(
          children: [
            Image.asset(Images.appLogo, height: 150),
            SingleChildScrollView(
              key: controller.scrollKey,
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  Widget largeScreen(BuildContext context) {
    return Scaffold(
        key: controller.scaffoldKey,
        body: Container(
          margin: MySpacing.top(100),
          width: MediaQuery.of(context).size.width,
          child: MyFlex(
            wrapAlignment: WrapAlignment.center,
            wrapCrossAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.center,
            spacing: 0,
            runSpacing: 0,
            children: [
              MyFlexItem(
                sizes: "xxl-3 lg-4 md-6 sm-8",
                child: Column(
                  children: [
                    Image.asset(Images.appLogo, height: 150),
                    MyContainer(
                      borderRadiusAll: 12,
                      child: child ?? Container(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
