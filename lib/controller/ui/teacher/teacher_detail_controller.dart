import 'package:study/controller/my_controller.dart';
import 'package:study/helpers/widgets/my_text_utils.dart';

class TeacherDetailController extends MyController {
  List<String> dummyTexts =
      List.generate(12, (index) => MyTextUtils.getDummyText(60));
}
