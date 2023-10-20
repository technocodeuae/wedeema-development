import 'package:flutter/material.dart';

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

extension OrgColorExtension on String {
  Color toColor(){
    switch(this){
      case 'DMT':
        return Color(0xff005470);

      case 'DRM':
        return Color(0xff83332E);

      case 'AAM':
        return Color(0xff18988B);

      case 'ITC':
        return Color(0xff00758D);

      case 'ADM':
        return Color(0xff005F7F);

      case 'ALGURM':
        return Color(0xffBD9A5F);

      case 'ALFAYPARK':
        return Color(0xff005C5D);

    }
    return Color(0xff005470);
  }
}


extension ArabicNumberExtention on String {
  String toArabic(){
    var sb = StringBuffer();
    for (int i = 0; i < this.length; i++) {
      switch (this[i]) {
        case '0':
          sb.write('٠');
          break;
        case '1':
          sb.write('١');
          break;
        case '2':
          sb.write('٢');
          break;
        case '3':
          sb.write('٣');
          break;
        case '4':
          sb.write('٤');
          break;
        case '5':
          sb.write('٥');
          break;
        case '6':
          sb.write('٦');
          break;
        case '6':
          sb.write('٧');
          break;
        case '8':
          sb.write('٨');
          break;
        case '9':
          sb.write('٩');
          break;
        default:
          sb.write(this[i]);
          break;
      }
    }
    return sb.toString();
  }
}