import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/ui/cart_controller.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/utils/utils.dart';
import 'package:study/helpers/widgets/my_breadcrumb.dart';
import 'package:study/helpers/widgets/my_breadcrumb_item.dart';
import 'package:study/helpers/widgets/my_button.dart';
import 'package:study/helpers/widgets/my_container.dart';
import 'package:study/helpers/widgets/my_flex.dart';
import 'package:study/helpers/widgets/my_flex_item.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/helpers/widgets/my_text_style.dart';
import 'package:study/images.dart';
import 'package:study/models/cart_model.dart';
import 'package:study/views/layouts/layout.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late CartController controller;

  @override
  void initState() {
    controller = Get.put(CartController());
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
                      "Cart",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Client'),
                        MyBreadcrumbItem(name: 'Cart', active: true),
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
                        sizes: 'lg-7',
                        child: SizedBox(
                          child: controller.carts.isNotEmpty
                              ? ListView.separated(
                                  itemCount: controller.carts.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    CartModel cart = controller.carts[index];
                                    return MyContainer(
                                      borderRadiusAll: 8,
                                      child: Wrap(
                                        spacing: 20,
                                        runSpacing: 16,
                                        alignment: WrapAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              MyContainer.rounded(
                                                paddingAll: 0,
                                                height: 70,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                child: Image.asset(
                                                    Images.avatars[index %
                                                        Images.avatars.length]),
                                              ),
                                              MySpacing.width(16),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  MyText.bodyMedium(
                                                    "Course Name: ${cart.courseName}",
                                                    fontWeight: 600,
                                                  ),
                                                  MyText.bodyMedium(
                                                      "Teacher Name: ${cart.teacherName}"),
                                                ],
                                              ),
                                            ],
                                          ),
                                          MyText.bodyMedium(
                                              "Fees : \$${cart.fees}",
                                              fontWeight: 600),
                                          MyText.bodyMedium(
                                            "Valid Till: ${Utils.getDateStringFromDateTime(cart.validTill)}",
                                          ),
                                          MyContainer.rounded(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              onTap: () =>
                                                  controller.removeData(cart),
                                              color: contentTheme.danger
                                                  .withAlpha(36),
                                              paddingAll: 8,
                                              child: Icon(
                                                LucideIcons.trash2,
                                                size: 16,
                                                color: contentTheme.danger,
                                              )),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 20);
                                  },
                                )
                              : MyContainer(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MyText.titleLarge(
                                        "Data is empty ",
                                        fontWeight: 600,
                                      ),
                                      MySpacing.height(24),
                                      MyContainer.bordered(
                                        borderRadiusAll: 8,
                                        onTap: () => controller.gotoExplore(),
                                        child: MyText.bodyLarge(
                                          "Explore Courses",
                                          fontWeight: 600,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                        )),
                    MyFlexItem(
                      sizes: 'lg-5',
                      child: Column(
                        children: [
                          buildDiscountCouponCode(),
                          MySpacing.height(12),
                          buildCartSummary()
                        ],
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

  Widget buildCartSummary() {
    return MyContainer(
      height: 250,
      borderRadiusAll: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText.bodyLarge("Cart Summary", fontWeight: 600),
          MySpacing.height(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.bodyMedium("Sub Total", fontWeight: 600),
              MyText.bodyMedium("\$1000.00", fontWeight: 600)
            ],
          ),
          MySpacing.height(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.bodyMedium("Shipping Cost", fontWeight: 600),
              MyText.bodyMedium("\$00.00", fontWeight: 600),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.bodyLarge("Grand Total", fontWeight: 700),
              MyText.bodyMedium("\$1000.00", fontWeight: 600),
            ],
          ),
          MySpacing.height(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(
                  padding: MySpacing.xy(60, 20),
                  onPressed: () {},
                  elevation: 0,
                  backgroundColor: contentTheme.primary.withAlpha(80),
                  splashColor: contentTheme.primary.withAlpha(120),
                  borderRadiusAll: 8,
                  child: MyText.bodyLarge(
                    "Check out",
                    fontWeight: 600,
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget buildTextField(String hintText) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: MyTextStyle.bodySmall(xMuted: true),
        border: outlineInputBorder,
        contentPadding: MySpacing.all(16),
        isCollapsed: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }

  Widget buildDiscountCouponCode() {
    return MyContainer(
      width: double.infinity,
      borderRadiusAll: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyLarge("Discount Coupon Code", fontWeight: 600),
          MySpacing.height(16),
          Row(
            children: [
              Expanded(child: buildTextField('Coupon Code')),
              MySpacing.width(12),
              MyButton(
                padding: MySpacing.xy(12, 20),
                borderRadiusAll: 8,
                onPressed: () {},
                elevation: 0,
                splashColor: contentTheme.primary.withAlpha(40),
                backgroundColor: contentTheme.primary.withAlpha(40),
                child: MyText.bodyMedium(
                  "Apply Code",
                  color: contentTheme.primary,
                  fontWeight: 600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
