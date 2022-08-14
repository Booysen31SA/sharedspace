import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  bool _loadThemeFromBox() => _box.read(_key) ?? false;
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }

  TextStyle get headingStyle {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.grey.shade600,
    );
  }

  TextStyle get subHeading {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.grey.shade600,
    );
  }
}

class DateService {
  final _box = GetStorage();
  final _key = 'date';

  _saveDateToBox(String date) => _box.write(_key, date);

  String _loadDateFromBox() =>
      _box.read(_key) ??
      DateFormat('yyyy-MM-dd').parse(DateTime.now().toString()).toString();

  DateTime get selectedDate => DateTime.parse(_loadDateFromBox());

  void changeDate(DateTime newDate) {
    _saveDateToBox(newDate.toString());
  }
}
