// ignore_for_file: non_constant_identifier_names, unused_import, prefer_const_declarations

import 'package:dio/dio.dart';

final String tablecategories = 'categories';

class Categorymodel {
  static final List<String> values = [
    /// Add all fields
    id, name_ar, name_en, description_ar, description_en, logo,
    sort
  ];

  static final String id = 'id';
  static final String name_ar = 'name_ar';
  static final String name_en = 'name_en';
  static final String description_ar = 'description_ar';
  static final String description_en = 'description_en';
  static final String logo = 'icon';
  static final String sort = 'sort';
}

class Category {
 int? id;
  String ? name_ar;
  String ? name_en;
  String ?logo;
  String ? description_ar;
  String ? description_en;
   int ? sort;

  Category(
      {this.id,
      required this.name_ar,
      required this.logo,
      required this.name_en,
      required this.description_ar,
      required this.description_en,
      required this.sort});

  Category copy(
          {final int? id,
        
          final String? name_ar,
          final String? name_en,
          final String? description_ar,
          final String? description_en,
          final String? logo,
          final int? sort}) =>
     Category(
          id: id ?? id,
          name_ar: name_ar ?? this.name_ar,
          name_en: name_en ?? this.name_en,
          description_ar: description_ar ?? this.description_ar,
          description_en: description_en ?? this.description_en,
          logo: logo ?? this.logo,
          sort: sort ?? this.sort);
  static Category fromJson(Map<String, Object?> json) => Category(
      id: json[Categorymodel.id] as int?,
      name_ar: json[Categorymodel.name_ar] as String?,
      name_en: json[Categorymodel.name_en] as String?,
      description_ar: json[Categorymodel.description_ar] as String?,
      description_en: json[Categorymodel.description_en] as String?,
      sort: json[Categorymodel.sort] as int?,
      logo: json[Categorymodel.logo] as String?);

  Map<String, Object?> toJson() => {
        Categorymodel.id: id,
        Categorymodel.name_ar: name_ar,
        Categorymodel.name_en: name_en,
        Categorymodel.description_ar: description_ar,
       Categorymodel.description_en: description_en,
        Categorymodel.logo: logo,
      Categorymodel.sort: sort
      };
}


/*class Categorymodel {
int? id;
 String ? name_ar, name_en,icon;
String ? description_ar;
String ? description_en;
  int sort;
  //final String name_ar, name_en, description_ar, description_en, icon;

  Categorymodel({
    required this.name_ar,
    required this.name_en,
    required this.description_ar,
    required this.id,
    required this.description_en,
    required this.icon,
    required this.sort,
  });

  Categorymodel.fromJson(Map<String, dynamic> json)
      : name_ar = json['name_ar'],
        name_en = json['name_en'],
        description_ar = json['description_ar'],
        description_en = json['description_en'],
        id = json['id'],
        icon = json['icon'],
        sort = json['sort'];
}
 */