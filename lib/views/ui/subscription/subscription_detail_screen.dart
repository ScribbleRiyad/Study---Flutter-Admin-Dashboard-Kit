import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/ui/subscription/subscription_detail_controller.dart';
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
import 'package:study/views/layouts/layout.dart';

class SubscriptionDetailScreen extends StatefulWidget {
  const SubscriptionDetailScreen({super.key});

  @override
  State<SubscriptionDetailScreen> createState() =>
      _SubscriptionDetailScreenState();
}

class _SubscriptionDetailScreenState extends State<SubscriptionDetailScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late SubscriptionDetailController controller;

  @override
  void initState() {
    controller = Get.put(SubscriptionDetailController());
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
                      "Subscription Detail",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(
                            name: 'Subscription Detail', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(
                      child: MyContainer(
                        borderRadiusAll: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.bodyLarge("Subscription", fontWeight: 600),
                            MySpacing.height(12),
                            MyContainer.bordered(
                              width: double.infinity,
                              borderRadiusAll: 8,
                              padding: MySpacing.xy(20, 16),
                              child: Wrap(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                alignment: WrapAlignment.spaceBetween,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  buildOverView("Current Plan", "Students",
                                      LucideIcons.users2, contentTheme.primary),
                                  buildOverView(
                                      "Price Monthly",
                                      "\$ 45",
                                      LucideIcons.calendar,
                                      contentTheme.danger),
                                  buildOverView("Users", "23", LucideIcons.user,
                                      contentTheme.success),
                                  buildOverView(
                                      "Total per month",
                                      "\$ 1035",
                                      LucideIcons.calendarCheck2,
                                      contentTheme.info),
                                  MyButton(
                                    onPressed: () {},
                                    elevation: 0,
                                    borderRadiusAll: 8,
                                    padding: MySpacing.xy(50, 16),
                                    child: MyText.bodyLarge(
                                      "Cancel Plan",
                                      fontWeight: 600,
                                      color: contentTheme.onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            MySpacing.height(16),
                            MyText.bodyLarge("Status", fontWeight: 600),
                            MySpacing.height(16),
                            Table(
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(8),
                                  color: contentTheme.secondary),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: MySpacing.x(20),
                                      child: MyText.bodyMedium(
                                        "Billing cycle :",
                                        fontWeight: 600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 70,
                                      child: Padding(
                                        padding: MySpacing.x(20),
                                        child: Row(
                                          children: [
                                            Icon(LucideIcons.calendar,
                                                size: 16),
                                            MySpacing.width(8),
                                            MyText.bodyMedium("Monthly"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: MySpacing.x(20),
                                      child: MyText.bodyMedium(
                                          "Account Credit :",
                                          fontWeight: 600),
                                    ),
                                    SizedBox(
                                      height: 70,
                                      child: Padding(
                                        padding: MySpacing.x(20),
                                        child: Row(
                                          children: [
                                            Icon(LucideIcons.calendarCheck,
                                                size: 16),
                                            MySpacing.width(8),
                                            MyText.bodyMedium(
                                                "January 11, 2022"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: MySpacing.x(20),
                                      child: MyText.bodyMedium(
                                          "Account Credit :",
                                          fontWeight: 600),
                                    ),
                                    SizedBox(
                                      height: 70,
                                      child: Padding(
                                        padding: MySpacing.x(20),
                                        child: Row(
                                          children: [
                                            Icon(LucideIcons.dollarSign,
                                                size: 16),
                                            MySpacing.width(8),
                                            MyText.bodyMedium("\$ 50"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            MySpacing.height(16),
                            MyText.bodyLarge("Payment Detail", fontWeight: 600),
                            MySpacing.height(16),
                            Table(
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(8),
                                  color: contentTheme.secondary),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(children: [
                                  Padding(
                                    padding: MySpacing.x(20),
                                    child: MyText.bodyMedium("Payment Card :",
                                        fontWeight: 600),
                                  ),
                                  SizedBox(
                                    height: 70,
                                    child: Padding(
                                      padding: MySpacing.x(20),
                                      child: Row(
                                        children: [
                                          Icon(LucideIcons.landmark, size: 16),
                                          MySpacing.width(8),
                                          MyText.bodyMedium("VISA ****6554"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: MySpacing.x(20),
                                    child: MyText.bodyMedium(
                                        "Billing Address :",
                                        fontWeight: 600),
                                  ),
                                  SizedBox(
                                    height: 70,
                                    child: Padding(
                                      padding: MySpacing.x(20),
                                      child: Row(
                                        children: [
                                          Icon(LucideIcons.mapPin, size: 16),
                                          MySpacing.width(8),
                                          MyText.bodyMedium(
                                              "Yashmak Nagar 1st Block 1st Cross"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: MySpacing.x(20),
                                    child: MyText.bodyMedium("Billing Email :",
                                        fontWeight: 600),
                                  ),
                                  SizedBox(
                                    height: 70,
                                    child: Padding(
                                      padding: MySpacing.x(20),
                                      child: Row(
                                        children: [
                                          Icon(LucideIcons.mail, size: 16),
                                          MySpacing.width(8),
                                          MyText.bodyMedium("james@gmail.com"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: MySpacing.x(20),
                                      child: MyText.bodyMedium(
                                          "Extra invoice details :",
                                          fontWeight: 600),
                                    ),
                                    SizedBox(
                                      height: 70,
                                      child: Padding(
                                        padding: MySpacing.x(20),
                                        child: Row(
                                          children: [
                                            Icon(LucideIcons.file, size: 16),
                                            MySpacing.width(8),
                                            MyText.bodyMedium(
                                                "VAT 326598. Company ID: 654987"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildOverView(
      String title, String subTitle, IconData icon, Color color) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        MyContainer.rounded(
          color: color.withAlpha(40),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Icon(
            icon,
            color: color,
          ),
        ),
        MySpacing.width(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.bodyLarge(
              title,
              fontWeight: 600,
            ),
            MyText.bodyLarge(
              subTitle,
              fontWeight: 600,
              xMuted: true,
              fontSize: 20,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDetails(String title, String subTitle) {
    return Expanded(
      child: Padding(
        padding: MySpacing.xy(20, 16),
        child: Row(
          children: [
            MyText.bodyLarge(
              title,
              fontWeight: 600,
            ),
            MySpacing.width(60),
            Expanded(
              child: MyText.bodyLarge(
                subTitle,
                fontWeight: 600,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
