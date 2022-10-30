import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
}

class DateTimeService {
  final _box = GetStorage();
  final _key = 'selectedDate';
  _saveDateTimeToBox(DateTime selectedDate) => _box.write(_key, selectedDate);

  DateTime _loadDateTimeToBox() => _box.read(_key) ?? DateTime.now();
  DateTime get date => _loadDateTimeToBox();

  void changeSelectedDate(DateTime selectedDate) {
    _saveDateTimeToBox(selectedDate);
  }
}
