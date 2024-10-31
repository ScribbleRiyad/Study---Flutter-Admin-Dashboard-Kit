import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/ui/subscription/subscription_list_controller.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/utils/utils.dart';
import 'package:study/helpers/widgets/my_breadcrumb.dart';
import 'package:study/helpers/widgets/my_breadcrumb_item.dart';
import 'package:study/helpers/widgets/my_container.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/images.dart';
import 'package:study/models/subscription_model.dart';
import 'package:study/views/layouts/layout.dart';

class SubscriptionListScreen extends StatefulWidget {
  const SubscriptionListScreen({super.key});

  @override
  State<SubscriptionListScreen> createState() => _SubscriptionListScreenState();
}

class _SubscriptionListScreenState extends State<SubscriptionListScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late SubscriptionListController controller;

  @override
  void initState() {
    controller = Get.put(SubscriptionListController());
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
                      "Subscription List",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(
                            name: 'Subscription List', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Column(
                  children: [
                    if (controller.data != null)
                      PaginatedDataTable(
                        source: controller.data!,
                        columns: [
                          DataColumn(
                              label: MyText.bodyMedium('Teacher Name',
                                  fontWeight: 600)),
                          DataColumn(
                              label: MyText.bodyMedium('Course Id',
                                  fontWeight: 600)),
                          DataColumn(
                              label: MyText.bodyMedium('Subscribed At',
                                  fontWeight: 600)),
                          DataColumn(
                              label: MyText.bodyMedium('Subscribed Ends At',
                                  fontWeight: 600)),
                          DataColumn(
                              label:
                                  MyText.bodyMedium('Rate', fontWeight: 600)),
                          DataColumn(
                              label:
                                  MyText.bodyMedium('Status', fontWeight: 600)),
                          DataColumn(
                              label:
                                  MyText.bodyMedium('Action', fontWeight: 600)),
                        ],
                        columnSpacing: 152,
                        horizontalMargin: 50,
                        rowsPerPage: 10,
                        dataRowMaxHeight: 60,
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
}

class MyData extends DataTableSource with UIMixin {
  List<SubscriptionModel> subscription = [];

  MyData(this.subscription);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => subscription.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    SubscriptionModel data = subscription[index];

    return DataRow(
      cells: [
        DataCell(Row(
          children: [
            MyContainer.rounded(
              paddingAll: 0,
              height: 40,
              width: 40,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(Images.avatars[index % Images.avatars.length]),
            ),
            MySpacing.width(8),
            MyText.bodyMedium(
              data.teacherName,
              fontWeight: 600,
            ),
          ],
        )),
        DataCell(MyText.bodyMedium(
          "#${data.courseId}",
          fontWeight: 600,
        )),
        DataCell(MyText.bodyMedium(
          Utils.getDateStringFromDateTime(data.subscribedAt),
          fontWeight: 600,
        )),
        DataCell(MyText.bodyMedium(
          Utils.getDateStringFromDateTime(data.subscribedEndsAt),
          fontWeight: 600,
        )),
        DataCell(Row(
          children: [
            Icon(
              LucideIcons.star,
              color: contentTheme.warning,
              size: 16,
            ),
            MySpacing.width(8),
            MyText.bodyMedium(
              data.rate.toString(),
              fontWeight: 600,
            ),
          ],
        )),
        DataCell(
          MyText.bodyMedium(
            data.status,
            fontWeight: 600,
            color: data.status == 'Purchased'
                ? contentTheme.primary
                : data.status == 'On Going'
                    ? contentTheme.success
                    : data.status == 'Finished'
                        ? contentTheme.title
                        : data.status == 'Expired'
                            ? contentTheme.danger
                            : null,
          ),
        ),
        DataCell(
          InkWell(
            onTap: () => gotoDetailScreen(),
            borderRadius: BorderRadius.circular(100),
            child: MyContainer(
              padding: MySpacing.xy(12, 4),
              borderRadiusAll: 100,
              color: contentTheme.secondary.withAlpha(40),
              child: Row(
                children: [
                  MyText.bodyMedium(
                    "View",
                    color: contentTheme.secondary,
                    fontWeight: 600,
                  ),
                  MySpacing.width(8),
                  Icon(
                    LucideIcons.eye,
                    size: 20,
                    color: contentTheme.secondary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void gotoDetailScreen() {
    Get.toNamed('/admin/subscription/detail');
  }
}
