import 'package:intl/intl.dart';

final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
final DateFormat timeFormatter = DateFormat('jms');

class AppConstant {
  static int androidAppVersion = 2;
  static int iOSAppVersion = 2;
  static String version = "2.0.0";

  static String get appName => 'Flatten';
}
