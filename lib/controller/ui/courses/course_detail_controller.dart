import 'package:get/get.dart';
import 'package:study/controller/my_controller.dart';
import 'package:study/helpers/widgets/my_text_utils.dart';
import 'package:video_player/video_player.dart';

class CoursesDetailController extends MyController {
  late VideoPlayerController videoController;

  List<String> dummyTexts =
      List.generate(12, (index) => MyTextUtils.getDummyText(60));

  void gotoCartScreen() {
    Get.toNamed('/client/cart');
  }

  @override
  void onInit() {
    videoController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        update();
      });
    super.onInit();
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }
}
