import 'package:wadeema/data/models/categories/entity/categories_entity.dart';

class ArgumentCategory{

  final Map<String, dynamic>? dataMap;
  int? id;
  String? name;
  List<CategoriesEntity?>? list;

  ArgumentCategory({this.dataMap,this.id,this.name,this.list});
}