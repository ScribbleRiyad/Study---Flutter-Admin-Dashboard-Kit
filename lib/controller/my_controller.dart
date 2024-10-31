import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:study/helpers/theme/theme_customizer.dart';

abstract class MyController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    ThemeCustomizer.addListener((old, newVal) {
      if (old.theme != newVal.theme ||
          (old.currentLanguage.languageName !=
              newVal.currentLanguage.languageName)) {
        update();
        onThemeChanged();
      }
    });
  }

  void onThemeChanged() {}
}
