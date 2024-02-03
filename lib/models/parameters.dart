// ignore_for_file: prefer_const_declarations, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, unnecessary_question_mark

/*"id": 16,
                "service_id": 57,
                "internal_id": "mobile",
                "name_ar": "رقم الموبايل",
                "name_en": "Mobile",
                "type": 1,
                "type_values": [],
                "min_length": 11,
                "max_length": 11,
                "required": 1,
                "display": 1,
                "sort": 1,
                "is_client_number": 1 */


final String tableparametrs = 'parameters';

class parametersFields {
  static final List<String> values = [
    /// Add all fields
    id, service_id, internal_id, name_ar, name_en, type, type_values,
    min_length, max_length, required, display,
    sort, is_client_number
  ];

  static final String id = 'id';
  static final String service_id = 'service_id';
  static final String name_ar = 'name_ar';
  static final String name_en = 'name_en';
  static final String internal_id = 'internal_id';
  static final String type = 'type';
  static final String type_values = 'type_values';
  static final String sort = 'sort';
  static final String min_length = 'min_length';
  static final String max_length = 'max_length';
  static final String required = 'required';
  static final String display = 'display';
  static final String is_client_number = 'is_client_number';
}

class parameters {
  final int? id,
      service_id,
      is_client_number,
      min_length,
      max_length,
      sort,
      type,
      display,
      required;
  final String ?name_ar, name_en, internal_id;
  var type_values;

  parameters({
    required this.id,
    required this.min_length,
    required this.is_client_number,
    required this.service_id,
    required this.name_ar,
    required this.internal_id,
    required this.name_en,
    required this.required,
    required this.display,
    required this.max_length,
    required this.sort,
    required this.type_values,
    required this.type,
  });

  parameters copy(
          {final int? id,
          final int? service_id,
          final String? internal_id,
          final String? name_ar,
          final String? name_en,
          final int? display,
          final int? required,
          final int? max_length,
          final int? min_length,
          final int? type,
          final int? is_client_number,
          final dynamic? type_values,
          final int? sort}) =>
      parameters(
          id: id ?? id,
          service_id: service_id ?? service_id,
          is_client_number: is_client_number ?? is_client_number,
          name_ar: name_ar ?? this.name_ar,
          name_en: name_en ?? this.name_en,
          internal_id: internal_id ?? this.internal_id,
          display: display ?? this.display,
          required: required ?? this.required,
          sort: sort ?? this.sort,
          max_length: max_length ?? this.max_length,
          type_values: type_values ?? this.type_values,
          min_length: min_length ?? this.min_length,
          type: type ?? this.type);
  static parameters fromJson(Map<String, Object?> json, int value) =>
      parameters(
          id: json[parametersFields.id] as int?,
          service_id: json[parametersFields.service_id] as int?,
          name_ar: json[parametersFields.name_ar] as String,
          name_en: json[parametersFields.name_en] as String,
          internal_id: json[parametersFields.internal_id] as String,
          display: json[parametersFields.display] as int,
          sort: json[parametersFields.sort] as int,
          required: json[parametersFields.required] as int,
          max_length: json[parametersFields.max_length] as int,
          type: json[parametersFields.type] as int,
          is_client_number: json[parametersFields.is_client_number] as int,
          type_values: value == 0
              ? json[parametersFields.type_values] as List
              : json[parametersFields.type_values] as String,
          min_length: json[parametersFields.min_length] as int);

  static parameters fromJsondb(Map<String, Object?> json) => parameters(
      id: json[parametersFields.id] as int?,
      service_id: json[parametersFields.service_id] as int?,
      name_ar: json[parametersFields.name_ar] as String,
      name_en: json[parametersFields.name_en] as String,
      internal_id: json[parametersFields.internal_id] as String,
      display: json[parametersFields.display] as int,
      sort: json[parametersFields.sort] as int,
      required: json[parametersFields.required] as int,
      max_length: json[parametersFields.max_length] as int,
      type: json[parametersFields.type] as int,
      is_client_number: json[parametersFields.is_client_number] as int,
      type_values: json[parametersFields.type_values] as String,
      min_length: json[parametersFields.min_length] as int);

  Map<String, Object?> toJson() => {
        parametersFields.id: id,
        parametersFields.service_id: service_id,
        parametersFields.name_ar: name_ar,
        parametersFields.name_en: name_en,
        parametersFields.internal_id: internal_id,
        parametersFields.display: display,
        parametersFields.required: required,
        parametersFields.sort: sort,
        parametersFields.max_length: max_length,
        parametersFields.type: type,
        parametersFields.is_client_number: is_client_number,
        parametersFields.min_length: min_length,
        parametersFields.type_values: type_values.toString()
      };
}
