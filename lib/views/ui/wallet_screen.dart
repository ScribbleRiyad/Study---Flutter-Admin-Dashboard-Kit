import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/ui/wallet_controller.dart';
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
import 'package:study/models/transaction_model.dart';
import 'package:study/views/layouts/layout.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late WalletController controller;

  @override
  void initState() {
    controller = Get.put(WalletController());
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
                      "Wallet",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Wallet', active: true),
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
                      color: contentTheme.danger,
                      child: Row(
                        children: [
                          Icon(
                            LucideIcons.wallet,
                            size: 24,
                            color: contentTheme.onDanger,
                          ),
                          MySpacing.width(12),
                          MyText.bodyLarge(
                            "Your Wallet Balance",
                            fontWeight: 600,
                            color: contentTheme.onDanger,
                          ),
                          MySpacing.width(12),
                          MyText.bodyLarge(
                            "\$45,123",
                            color: contentTheme.onDanger,
                          ),
                          Spacer(),
                          MyButton(
                              onPressed: () {},
                              elevation: 0,
                              borderRadiusAll: 8,
                              backgroundColor:
                                  contentTheme.onPrimary.withAlpha(80),
                              splashColor:
                                  contentTheme.onPrimary.withAlpha(120),
                              padding: MySpacing.xy(20, 16),
                              child: MyText.bodyLarge("Add Money",
                                  fontWeight: 600)),
                        ],
                      ),
                    )),
                    MyFlexItem(child: buildOverView()),
                    MyFlexItem(
                      child: Column(
                        children: [
                          if (controller.data != null)
                            PaginatedDataTable(
                              source: controller.data!,
                              columns: [
                                DataColumn(
                                    label: MyText.bodyMedium('Transaction ID',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodyMedium('Date/Time',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodyMedium('Transaction Type',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodyMedium('Amount',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodyMedium('Status',
                                        fontWeight: 600))
                              ],
                              columnSpacing: 245,
                              horizontalMargin: 50,
                              rowsPerPage: 8,
                              dataRowMaxHeight: 60,
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildOverView() {
    Widget buildDetail(
        String title, String subTitle, IconData icon, Color color) {
      return MyContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyLarge(title, fontWeight: 600),
                MySpacing.height(12),
                MyText.bodyLarge(subTitle, fontWeight: 600),
              ],
            ),
            MyContainer.rounded(
              height: 60,
              width: 60,
              paddingAll: 0,
              color: color.withAlpha(36),
              child: Icon(
                icon,
                color: color,
              ),
            )
          ],
        ),
      );
    }

    return MyFlex(contentPadding: false, children: [
      MyFlexItem(
        sizes: 'lg-3',
        child: buildDetail("Wallet Balance", '\$45,123', LucideIcons.wallet,
            contentTheme.primary),
      ),
      MyFlexItem(
        sizes: 'lg-3',
        child: buildDetail("Received Amount", '\$ 1000',
            LucideIcons.circleDollarSign, contentTheme.success),
      ),
      MyFlexItem(
        sizes: 'lg-3',
        child: buildDetail("Expenditure Amount", '\$23', LucideIcons.landmark,
            contentTheme.warning),
      ),
      MyFlexItem(
        sizes: 'lg-3',
        child: buildDetail("Total Turnover", '\$1500', LucideIcons.dollarSign,
            contentTheme.danger),
      ),
    ]);
  }
}

class MyData extends DataTableSource with UIMixin {
  List<TransactionModel> transactionList = [];

  MyData(this.transactionList);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => transactionList.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    TransactionModel transaction = transactionList[index];
    return DataRow(
      cells: [
        DataCell(MyText.bodyMedium(
          "#${transaction.transactionId}",
          fontWeight: 600,
        )),
        DataCell(MyText.bodyMedium(
          Utils.getDateTimeStringFromDateTime(transaction.dateTime),
          fontWeight: 600,
        )),
        DataCell(MyText.bodyLarge('\$${transaction.amount}', fontWeight: 600)),
        DataCell(MyText.bodyLarge('${transaction.transactionType}',
            fontWeight: 600)),
        DataCell(
          MyContainer(
            padding: MySpacing.xy(12, 4),
            borderRadiusAll: 100,
            color: transaction.status == 'Refund'
                ? contentTheme.primary.withAlpha(40)
                : transaction.status == 'Paid'
                    ? contentTheme.success.withAlpha(40)
                    : transaction.status == 'Cancel'
                        ? contentTheme.danger.withAlpha(40)
                        : null,
            child: MyText.bodyMedium(
              transaction.status,
              fontWeight: 600,
              color: transaction.status == 'Refund'
                  ? contentTheme.primary
                  : transaction.status == 'Paid'
                      ? contentTheme.success
                      : transaction.status == 'Cancel'
                          ? contentTheme.danger
                          : null,
            ),
          ),
        ),
      ],
    );
  }
}
