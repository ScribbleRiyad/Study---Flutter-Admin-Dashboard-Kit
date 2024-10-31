import 'dart:math';

class Images {
  static String appLogo = 'assets/logo/study_logo.png';
  static String dashboard = 'assets/dummy/dashboard.png';

  static List<String> avatars =
      List.generate(20, (index) => 'assets/dummy/avatar${index + 1}.png');

  static List<String> courses = List.generate(
      19, (index) => 'assets/dummy/courses/course_${index + 1}.png');

  static List<String> schools = List.generate(
      13, (index) => 'assets/dummy/school/school_${index + 1}.png');

  static String randomImage(List<String> images) {
    return images[Random().nextInt(images.length)];
  }
}
