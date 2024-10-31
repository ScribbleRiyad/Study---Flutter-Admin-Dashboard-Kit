import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/ui/organization/organization_list_controller.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/widgets/my_breadcrumb.dart';
import 'package:study/helpers/widgets/my_breadcrumb_item.dart';
import 'package:study/helpers/widgets/my_button.dart';
import 'package:study/helpers/widgets/my_container.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/models/organization_list_model.dart';
import 'package:study/views/layouts/layout.dart';

class OrganizationListScreen extends StatefulWidget {
  const OrganizationListScreen({super.key});

  @override
  State<OrganizationListScreen> createState() => _OrganizationListScreenState();
}

class _OrganizationListScreenState extends State<OrganizationListScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late OrganizationListController controller;

  @override
  void initState() {
    controller = Get.put(OrganizationListController());
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
                      "Organization List",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(
                            name: 'Organization List', active: true),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 302,
                            child: TextField(
                              controller: controller.sController,
                              onChanged: controller.searchOrganization,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  LucideIcons.search,
                                  size: 20,
                                ),
                                hintText: "Search Schools",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                contentPadding: MySpacing.all(12),
                              ),
                            ),
                          ),
                          MyButton(
                            borderRadiusAll: 8,
                            elevation: 0,
                            padding: MySpacing.xy(20, 20),
                            backgroundColor: contentTheme.primary.withAlpha(80),
                            splashColor: contentTheme.primary.withAlpha(120),
                            onPressed: () => controller.gotoOrganizationAdd(),
                            child: Row(
                              children: [
                                Icon(
                                  LucideIcons.plus,
                                  size: 20,
                                  color: contentTheme.primary,
                                ),
                                MySpacing.width(8),
                                MyText.bodyMedium(
                                  "Add New Customer",
                                  fontWeight: 600,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      MySpacing.height(12),
                      GridView.builder(
                        shrinkWrap: true,
                        primary: true,
                        itemCount: controller.searchOrganizationList.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 380,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            mainAxisExtent: 400),
                        itemBuilder: (context, index) {
                          OrganizationListModel organization =
                              controller.searchOrganizationList[index];
                          return MyContainer.bordered(
                            borderRadiusAll: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    MyContainer(
                                      onTap: () =>
                                          controller.gotoOrganizationEdit(),
                                      height: 150,
                                      width: double.infinity,
                                      borderRadiusAll: 8,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      paddingAll: 0,
                                      child: Image.asset(
                                        organization.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 12,
                                      right: 12,
                                      child: InkWell(
                                        onTap: () =>
                                            controller.gotoOrganizationEdit(),
                                        child: Icon(
                                          LucideIcons.edit,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                MyText.bodyLarge(
                                  "~ ${organization.name}",
                                  fontWeight: 600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                MyText.bodyMedium(
                                  "Email :${organization.email}",
                                  fontWeight: 600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                MyText.bodyMedium(
                                  "Address :${organization.address}",
                                  fontWeight: 600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                MyText.bodyMedium(
                                  "City :${organization.city}",
                                  fontWeight: 600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                MyText.bodyMedium(
                                  "Contact Number : +81 ${organization.contactNumber}",
                                  fontWeight: 600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                MyText.bodyMedium(
                                  "Number of courses :${organization.numberOfCourses}",
                                  fontWeight: 600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
