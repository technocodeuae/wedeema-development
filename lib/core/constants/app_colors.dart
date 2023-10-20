import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../blocs/application/application_bloc.dart';

class AppColorsController {
  AppColorsController();

  Rx<Color?> _primaryColor = Color(0xfffcd6d5).obs;
  String _primaryColorStr = '#' + Color(0xfffcd6d5).value.toRadixString(16);

  Color get primaryColor => _primaryColor.value ?? this.defaultPrimaryColor;

  String get primaryColorStr => _primaryColorStr;

  setPrimaryColor(Color? color) {
    print('setPrimaryColor $color');
    if (color == null) {
      _primaryColor.value = defaultPrimaryColor;
      _primaryColorStr = '#' + Color(0xfffcd6d5).value.toRadixString(16);
      // ThemeProvider().refreshColor();
      return;
    }
    // _primaryColorStr = "#" + color.toString().split('(0x')[1].split(')')[0];
    _primaryColorStr = '#' + color.value.toRadixString(16);
    _primaryColor.value = color;
    // ThemeProvider().refreshColor();
  }

  void resetPrimaryColor() {
    setPrimaryColor(defaultPrimaryColor);
  }

  Color black =
      ThemeProvider().appMode == "light" ? Colors.black : Colors.white;
  Color dropdown =
  ThemeProvider().appMode == "light" ? Color(0xFF78181C) : Colors.black;
  Color greyTextColor = Color(0xFFACB1C0);
  Color scaffoldBGColor = ThemeProvider().appMode == "light"
      ? Color(0xFFFCD6D5)
      : Color(0xFF191D20);

  Color pobColor =
       Color(0xFFEAE5E5);


  Color scaffoldBGColorAdds = ThemeProvider().appMode == "light"
      ? Color(0xFFF5F1F2)
      : Color(0xFF191D20);

  Color borderColor =
      ThemeProvider().appMode == "light" ? Color(0xFF460003) : Colors.white;
  Color borderGrayColor = Color(0xFF707070);
  Color buttonRedColor = Color(0xFF89393D);
  Color iconColor =
      ThemeProvider().appMode == "light" ? Color(0xFFDE0F17) : Colors.white;
  Color iconColor2 =
  ThemeProvider().appMode == "light" ? Color(0xFFDE0F17) : Colors.black54;
  Color selectIconColor = Color(0xFFDE0F17);
  Color unSelectIconColor =
      ThemeProvider().appMode == "light" ? Color(0xFFDE0F17) : Colors.white;
  Color textPrimaryColor =
      ThemeProvider().appMode == "light" ? Color(0xFF650101) : Colors.white;
  Color textButtonBackground = Color(0x00000000);
  Color defaultPrimaryColor = ThemeProvider().appMode == "light"
      ? Color(0xfffcd6d5)
      : Color(0xFF191D20);
  Color chatPrimaryColor = ThemeProvider().appMode == "light"
      ? Color(0x80fcddd5)
      : Color(0xFF18171C);
  Color containerPrimaryColor = ThemeProvider().appMode == "light"
      ? Color(0x4DFCD6D5)
      : Color(0xFF18171C);
  Color buttonPrimaryColor = Color(0x26FCD6D5);
  Color secondaryColor =
      ThemeProvider().appMode == "light" ? Color(0xffcd0300) : Colors.white;
  Color darkGreyTextColor =
      ThemeProvider().appMode == "light" ? Color(0xFF595959) : Colors.white;
  Color greyIconColor = Color(0xFFD9D9D9);
  Color naveTextColor =
      ThemeProvider().appMode == "light" ? Color(0xF5001831) : Colors.white;
  Color red =
      ThemeProvider().appMode == "light" ? Color(0xFFF44336) : Colors.white;
  Color greyBackground = ThemeProvider().appMode == "light"
      ? Color(0xFFFAE6E5)
      : Color(0x26FCD6D5);
  Color notSelectedGrey = Color(0xFF7A8FA6);
  Color white =
      ThemeProvider().appMode == "light" ? Colors.white : Color(0xFF191D20);

  Color whiteBackground =
  ThemeProvider().appMode == "light" ? Color(0xFFFFFBFA) : Color(0xFF191D20);

  Color grey =
  ThemeProvider().appMode == "light" ? Color(0xFFD7D3D2) : Color(0xFFD7D3D2);

  Color lightGrey =
  ThemeProvider().appMode == "light" ? Color(0xFFF2ECEC) : Color(0xFFF2ECEC);

  Color darkRed = Color(0xFF8E3C40);
  Color lightRed = Color(0xFFB88389);
  Color colorBarRed = Color(0xFFF6BFBE);
  Color card = ThemeProvider().appMode == "light" ? Color(0xFFFEF0F0):Colors.black26;
  Color dialog = Color(0xFFE8E1E1);
  Color textColor = Color(0xFF040000);
}
