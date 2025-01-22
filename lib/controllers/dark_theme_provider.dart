import 'package:flutter/material.dart';

class DarkThemeProvider extends ChangeNotifier {
  DarkThemeProvider() {
    _loadFromPrefs();
  }

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  void toogleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  void _loadFromPrefs() async {
    await Future.delayed(Duration(seconds: 1));
    _darkTheme = false;
    notifyListeners();
  }

  void _saveToPrefs() async {
    await Future.delayed(Duration(seconds: 1));
  }
}
