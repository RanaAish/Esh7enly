// ignore_for_file: prefer_const_declarations, non_constant_identifier_names


final String tableproviders = 'providers';

class ProviderFields {
  static final List<String> values = [
    /// Add all fields
    id, category_id, name_ar, name_en, description_ar, description_en, logo,
    sort
  ];

  static final String id = 'id';
  static final String category_id = 'category_id';
  static final String name_ar = 'name_ar';
  static final String name_en = 'name_en';
  static final String description_ar = 'description_ar';
  static final String description_en = 'description_en';
  static final String logo = 'logo';
  static final String sort = 'sort';
}

class Provider {
  final int? id, category_id;
  String ? name_ar;
  String ? name_en;
  String ?logo;
  String ? description_ar;
  String ? description_en;
  final int ? sort;

  Provider(
      {this.id,
      this.category_id,
      required this.name_ar,
      required this.logo,
      required this.name_en,
      required this.description_ar,
      required this.description_en,
      required this.sort});

  Provider copy(
          {final int? id,
          final int? category_id,
          final String? name_ar,
          final String? name_en,
          final String? description_ar,
          final String? description_en,
          final String? logo,
          final int? sort}) =>
      Provider(
          id: id ?? id,
          category_id: category_id ?? category_id,
          name_ar: name_ar ?? this.name_ar,
          name_en: name_en ?? this.name_en,
          description_ar: description_ar ?? this.description_ar,
          description_en: description_en ?? this.description_en,
          logo: logo ?? this.logo,
          sort: sort ?? this.sort);
  static Provider fromJson(Map<String, Object?> json) => Provider(
      id: json[ProviderFields.id] as int?,
      category_id: json[ProviderFields.category_id] as int?,
      name_ar: json[ProviderFields.name_ar] as String?,
      name_en: json[ProviderFields.name_en] as String?,
      description_ar: json[ProviderFields.description_ar] as String?,
      description_en: json[ProviderFields.description_en] as String?,
      sort: json[ProviderFields.sort] as int?,
      logo: json[ProviderFields.logo] as String?);

  Map<String, Object?> toJson() => {
        ProviderFields.id: id,
        ProviderFields.category_id: category_id,
        ProviderFields.name_ar: name_ar,
        ProviderFields.name_en: name_en,
        ProviderFields.description_ar: description_ar,
        ProviderFields.description_en: description_en,
        ProviderFields.logo: logo,
        ProviderFields.sort: sort
      };
}
