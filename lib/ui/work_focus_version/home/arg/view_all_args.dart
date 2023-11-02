import 'package:dio/dio.dart';

class ViewAllArgs{

  final int? type;
  final String? title;
  final String? category_id;
  final dynamic formData;
  ViewAllArgs({this.type,this.title,this.category_id,this.formData});

}