
import 'package:url_launcher/url_launcher.dart';

class UrlService {
  static goToUrl(String url) async {
    await launchUrl(Uri.parse(url));
  }


  static goToPurchase(){
    goToUrl('https://codecanyon.net/item/flatten-flutter-admin-panel/45285824');
  }

  static goToPagger(){
    goToUrl('https://getappui.com/pagger');
  }

  static getCurrentUrl(){
    var path = Uri.base.path;
    return path.replaceAll('study/web/', '');
  }
}
