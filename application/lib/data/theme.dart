import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;

  ThemeNotifier(this._currentTheme);

  ThemeData get currentTheme => _currentTheme;

  void swithcTheme() {
    _currentTheme = _currentTheme == ThemeData.light()
      ? ThemeData.dark()
      : ThemeData.light();

    notifyListeners();
  }
}