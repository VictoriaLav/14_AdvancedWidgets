import 'package:flutter/material.dart';
import '../widgets/color_tile.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData(
    primarySwatch: listColor[0],
  );
  MaterialColor _currentColor = listColor[0];

  ThemeData get currentTheme => _currentTheme;
  MaterialColor get currentColor => _currentColor;

  toggle(MaterialColor color) {
    _currentTheme = ThemeData(
      primarySwatch: color,
    );
    _currentColor = color;
    notifyListeners();
  }
}