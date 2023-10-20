import 'dart:ui';

extension ColorExtension on String {
  toColor() {
    if(this.contains("0x")){
      return Color(int.parse(this));
    }
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    if(this.length == 10){
      return ('#' + int.parse(this).toRadixString(16)).toColor();
    }
  }
}