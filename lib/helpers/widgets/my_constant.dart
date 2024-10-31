

import 'package:study/helpers/widgets/my_breadcrumb_item.dart';

class MyConstantData {
  final double containerRadius;
  final double cardRadius;
  final double buttonRadius;

  final MyBreadcrumbItem? defaultBreadCrumbItem;

  MyConstantData(
      {this.containerRadius = 4,
      this.cardRadius = 4,
      this.buttonRadius = 4,
      this.defaultBreadCrumbItem});
}

class MyConstant {
  static MyConstantData _constant = MyConstantData();

  static MyConstantData get constant => _constant;

  static setConstant(MyConstantData constantData) {
    _constant = constantData;
  }
}
