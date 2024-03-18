import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider with ChangeNotifier {

  double _fontSize = 16.0;

  double get fontSize => _fontSize;
  
  setFontSize(double fontSizeContent) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontSizeContent', fontSizeContent);
    _fontSize = fontSizeContent;
    notifyListeners();
  }

  getFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble('fontSizeContent') ?? 16.0;
    notifyListeners();
    return _fontSize;
    
  }

}
