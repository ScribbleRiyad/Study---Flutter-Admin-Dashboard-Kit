import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class JSONDecoder {
  late final Map<String, dynamic> jsonObject;
  late final List<dynamic> jsonList;

  JSONDecoder(dynamic json) {
    if (json is Map<String, dynamic>) {
      jsonObject = json;
    } else if (json is String) {
      dynamic object = jsonDecode(json);
      if (object is Map<String, dynamic>) {
        jsonObject = object;
      } else if (object is List<Map<String, dynamic>>) {
        jsonList = object;
      } else if (object is List<dynamic>) {
        jsonList = object;
      }
    } else if (json is List<Map<String, dynamic>>) {
      jsonList = json;
    }
  }

  int get getId => getInt('id');

  int getInt(String key, [int defaultValue = 0]) {
    return getIntOrNull(key) ?? defaultValue;
  }

  bool has(String key) {
    return jsonObject.containsKey(key);
  }

  int? getIntOrNull(String key) {
    if (has(key)) {
      return int.tryParse(jsonObject[key].toString());
    }
    return null;
  }

  double getDouble(String key, [double defaultValue = 0]) {
    if (jsonObject.containsKey(key)) {
      return double.tryParse(jsonObject[key].toString()) ?? defaultValue;
    }
    return defaultValue;
  }

  double? getDoubleOrNull(
    String key,
  ) {
    if (jsonObject.containsKey(key)) {
      return double.tryParse(jsonObject[key].toString());
    }
    return null;
  }

  String getString(String key, {String defaultValue = "", bool utf8 = false}) {
    String? value;
    if (jsonObject.containsKey(key)) {
      value = validateString(jsonObject[key]) ?? defaultValue;
      if (utf8) {
        return _utf8Decode(value);
      }
    }
    return value ?? defaultValue;
  }

  String _utf8Decode(String string) {
    try {
      return utf8.decode(string.codeUnits);
    } catch (e) {
      return string;
    }
  }

  bool getBool(String key, [bool defaultValue = false]) {
    if (jsonObject.containsKey(key)) {
      String? value = validateString(jsonObject[key]);
      if (value == null) return defaultValue;
      return value.toLowerCase().compareTo('true') == 0;
    }
    return defaultValue;
  }

  String? getStringOrNull(String key) {
    if (jsonObject.containsKey(key)) {
      return validateString(jsonObject[key]);
    }
    return null;
  }

  T getEnum<T extends Enum>(String key, List<T> options, T defaultValue) {
    return getEnumOrNull(key, options) ?? defaultValue;
  }

  T? getEnumOrNull<T extends Enum>(
    String key,
    List<T> options,
  ) {
    String? value = getStringOrNull(key);
    if (value == null) return null;
    for (T t in options) {
      if (t.name == value) {
        return t;
      }
    }
    return null;
  }

  DateTime getDateTime(String key,
      {DateTime? defaultValue, bool local = true}) {
    defaultValue ??= DateTime.now();
    if (jsonObject.containsKey(key)) {
      defaultValue = DateTime.tryParse(jsonObject[key]);
    }
    return local ? defaultValue!.toLocal() : defaultValue!;
  }

  LatLng getLatLng(
      {String latitudeKey = 'latitude', String longitudeKey = 'longitude'}) {
    double latitude = getDouble(latitudeKey);
    double longitude = getDouble(longitudeKey);
    return LatLng(latitude, longitude);
  }

  LatLng? getLatLngOrNull(
      {String latitudeKey = 'latitude', String longitudeKey = 'longitude'}) {
    double? latitude = getDoubleOrNull(latitudeKey);
    double? longitude = getDoubleOrNull(longitudeKey);
    if (latitude != null && longitude != null) {
      return LatLng(latitude, longitude);
    }
    return null;
  }

  DateTime? getDateTimeOrNull(String key, {bool local = true}) {
    if (jsonObject.containsKey(key)) {
      String? validatedDate = validateString(jsonObject[key]);
      if (validatedDate != null) {
        return local
            ? DateTime.tryParse(validatedDate)?.toLocal()
            : DateTime.tryParse(validatedDate);
      }
    }
    return null;
  }

  String? validateString(Object? value) {
    if (value != null &&
        value.toString().toLowerCase().compareTo('null') != 0) {
      return value.toString();
    }
    return null;
  }

  List<T> getObjectList<T>(String key, [List<T> defaultValue = const []]) {
    if (jsonObject.containsKey(key)) {
      if (jsonObject[key] is List<dynamic>) {
        return List<T>.from(jsonObject[key]);
      }
    }
    return defaultValue;
  }

  List<T>? getObjectListOrNull<T>(String key) {
    if (has(key)) {
      if (jsonObject[key] is List<dynamic>) {
        return List<T>.from(jsonObject[key]);
      } else if (jsonObject[key] is String) {
        try {
          return List<T>.from(jsonDecode(jsonObject[key]));
        } catch (e) {}
      }
    }
    return null;
  }

  List<Map<String, dynamic>>? getMapListOrNull(String? key) {
    if (jsonObject.containsKey(key) && jsonObject[key] is List<dynamic>) {
      return List<Map<String, dynamic>>.from(jsonObject[key]);
    }
    return null;
  }

  Map<String, dynamic>? getMapOrNull(String? key) {
    if (jsonObject.containsKey(key) &&
        jsonObject[key] is Map<String, dynamic>) {
      return jsonObject[key];
    }
    return null;
  }

  // List<T> getModelFromList<T extends Serializable>(T object){
  //
  // }

  Map<String, dynamic>? getMapObjectOrNull(String key) {
    if (jsonObject.containsKey(key) && jsonObject[key] != null) {
      if (jsonObject[key] is Map<String, dynamic>) {
        return jsonObject[key];
      } else {
        dynamic data = json.decode(jsonObject[key]);
        if (data != null && data is Map<String, dynamic>) {
          return data;
        }
      }
    }

    return null;
  }

  static String objectToString(Map<String, dynamic> object) {
    return json.encode(object);
  }

  dynamic getDynamic(String key) {
    return jsonObject[key];
  }
}
