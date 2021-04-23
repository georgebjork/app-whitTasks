import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ThemeProvider with ChangeNotifier{

  ThemeData _themeData;
  String key; 

  ThemeProvider(String key){
    setTheme(key);
  }

  getTheme() => _themeData;

  setTheme(String theme){
    if(theme == "dark")
      _themeData = darkTheme;
    else
      _themeData = lightTeme;
    //_themeData = theme;

    notifyListeners();
  }
  

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF2A2B2A),
    primaryColor: Color(0xFF2A2B2A), 
    accentColor: Color(0xFFD90824),
    cardColor: Color(0xFF515252),
  );

  static final lightTeme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    accentColor: Color(0xFFD90824),
    cardColor: Color(0xFF515252)
  );
}

//https://www.schemecolor.com/gray-and-dark-burgundy.php
//https://coolors.co/2a2b2a-52000b-741306-b7b8b8-d90824
//https://medium.com/globant/flutter-dynamic-theme-dark-mode-custom-themes-bded572c8cdf