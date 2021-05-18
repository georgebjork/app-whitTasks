import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  Future<bool> getOption() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('option');
   
  }

  Future<void> saveOption(bool isSelected) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('option', isSelected);
   
  }

  Future<bool> applyTheme() async {
    bool _value =  await getOption();

    if(_value == true){
      setTheme("dark");
    }else{
      setTheme("light");
    }
    return _value;

  }

  

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF2A2B2A),
    primaryColor: Color(0xFF2A2B2A), 
    accentColor: Color(0xFFD90824).withOpacity(0.6),
    cardColor: Color(0xFF515252),
    iconTheme: IconThemeData(color: Colors.white),
    colorScheme: ColorScheme.dark().copyWith(
        primary: Color(0xFFD90824),
      ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.white)
    ),
  );

  static final lightTeme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    accentColor: Color(0xFFD90824),
    cardColor: Colors.grey[700],
    colorScheme: ColorScheme.light().copyWith(
        primary: Color(0xFFD90824),
      ),
    iconTheme: IconThemeData(color: Colors.black),
  );
}

//https://www.schemecolor.com/gray-and-dark-burgundy.php
//https://coolors.co/2a2b2a-52000b-741306-b7b8b8-d90824
//https://medium.com/globant/flutter-dynamic-theme-dark-mode-custom-themes-bded572c8cdf