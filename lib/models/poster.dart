// ignore_for_file: non_constant_identifier_names

class Poster {
  int? id;
  String? banner;
  String? created_at;

  //final String name_ar, name_en, description_ar, description_en, icon;

  Poster({
    required this.id,
    required this.banner,
    required this.created_at,
  });

  Poster.fromJson(Map<String, dynamic> json)
      : banner = json["banner"],
        id = json['id'],
        created_at = json['created_at'];
}
