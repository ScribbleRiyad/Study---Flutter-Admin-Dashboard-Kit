/*
* File : App Theme Notifier (Listener)
* Version : 1.0.0
* */

import
'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study/helpers/services/json_decoder.dart';
import 'package:study/helpers/services/localizations/language.dart';
import 'package:study/helpers/services/localizations/translator.dart';
import 'package:study/helpers/services/navigation_service.dart';
import 'package:study/helpers/theme/admin_theme.dart';
import 'package:study/helpers/theme/app_notifier.dart';
import 'package:study/helpers/theme/app_style.dart';

typedef ThemeChangeCallback = void Function(
    ThemeCustomizer oldVal, ThemeCustomizer newVal);

class ThemeCustomizer {
  ThemeCustomizer();

  static final List<ThemeChangeCallback> _notifier = [];

  Language currentLanguage = Language.languages.first;

  ThemeMode theme = ThemeMode.light;
  ThemeMode leftBarTheme = ThemeMode.light;
  ThemeMode rightBarTheme = ThemeMode.light;
  ThemeMode topBarTheme = ThemeMode.light;

  bool rightBarOpen = false;
  bool leftBarCondensed = false;

  static ThemeCustomizer instance = ThemeCustomizer();
  static ThemeCustomizer oldInstance = ThemeCustomizer();

  static Future<void> init() async {
    await initLanguage();
  }

  static initLanguage() async {
    await changeLanguage(ThemeCustomizer.instance.currentLanguage);
  }

  String toJSON() {
    return jsonEncode({'theme': theme.name});
  }

  static ThemeCustomizer fromJSON(String? json) {
    instance = ThemeCustomizer();
    if (json != null && json.trim().isNotEmpty) {
      JSONDecoder decoder = JSONDecoder(json);
      instance.theme =
          decoder.getEnum('theme', ThemeMode.values, ThemeMode.light);
    }
    return instance;
  }

  static void addListener(ThemeChangeCallback callback) {
    _notifier.add(callback);
  }

  static void removeListener(ThemeChangeCallback callback) {
    _notifier.remove(callback);
  }

  static void _notify() {
    AdminTheme.setTheme();
    AppStyle.changeMyTheme();
    if (NavigationService.globalContext != null) {
      Provider.of<AppNotifier>(NavigationService.globalContext!, listen: false)
          .updateTheme(instance);
    }
    for (var value in _notifier) {
      value(oldInstance, instance);
    }
  }

  static void notify() {
    for (var value in _notifier) {
      value(oldInstance, instance);
    }
  }

  static void setTheme(ThemeMode theme) {
    oldInstance = instance.clone();
    instance.theme = theme;
    instance.leftBarTheme = theme;
    instance.rightBarTheme = theme;
    instance.topBarTheme = theme;
    _notify();
  }

  static Future<void> changeLanguage(Language language) async {
    oldInstance = instance.clone();
    ThemeCustomizer.instance.currentLanguage = language;
    await Translator.changeLanguage(language);
  }

  static void openRightBar(bool opened) {
    instance.rightBarOpen = opened;
    _notify();
  }

  static void toggleLeftBarCondensed() {
    instance.leftBarCondensed = !instance.leftBarCondensed;
    _notify();
  }

  ThemeCustomizer clone() {
    var tc = ThemeCustomizer();
    tc.theme = theme;
    tc.rightBarTheme = rightBarTheme;
    tc.leftBarTheme = leftBarTheme;
    tc.topBarTheme = topBarTheme;
    tc.rightBarOpen = rightBarOpen;
    tc.leftBarCondensed = leftBarCondensed;
    tc.currentLanguage = currentLanguage.clone();
    return tc;
  }

  @override
  String toString() {
    return 'ThemeCustomizer{theme: $theme}';
  }
}
