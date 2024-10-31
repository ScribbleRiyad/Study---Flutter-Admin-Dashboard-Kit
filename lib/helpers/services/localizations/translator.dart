import 'dart:convert';
import 'dart:developer';


import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study/helpers/services/localizations/language.dart';

class Translator {
  static Map<String, String>? _localizedStrings;

  static Future<bool> changeLanguage(Language language) async {
    try {
      String jsonString = await rootBundle
          .loadString('assets/lang/${language.locale.languageCode}.json');
      Map<String, dynamic> jsonLanguageMap = json.decode(jsonString);
      _localizedStrings = jsonLanguageMap.map((key, value) {
        return MapEntry(key, value.toString());
      });
      return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  // called from every screens which needs a localized text
  static String translate(String text) {
    if (_localizedStrings != null) {
      String? value = _localizedStrings![text];
      return value ?? autoTranslate(text);
    }

    return autoTranslate(text);
  }

  static String autoTranslate(String text) {
    // log("You need to translate this text : " + text);
    at(text);

    try {
      List<String> texts = text.split("_");
      StringBuffer stringBuffer = StringBuffer();
      for (String singleText in texts) {
        stringBuffer
            .write("${singleText[0].toUpperCase()}${singleText.substring(1)} ");
      }
      String result = stringBuffer.toString();
      return result.substring(0, result.length - 1);
    } catch (err) {
      return text;
    }
  }

  static Future<void> at(String t) async {
    // print("at");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var data = sharedPreferences.getStringList('test_tr') ?? [];
    var set = data.toSet();
    set.add(t);
    sharedPreferences.setStringList('test_tr', set.toList());
  }

  static clearTrans() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('test_tr');
  }

  static getUnTrans() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var data = sharedPreferences.getStringList('test_tr') ?? [];
    var set = data.toSet();
    String text = "";
    for (var value in set.toList()) {
      var p = value.replaceAll("_", " ");
      p = p.capitalize!;
      text += ('"$value": "$p",\n');
    }
    log(text);
  }
}
