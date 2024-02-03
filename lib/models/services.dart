// ignore_for_file: prefer_const_declarations, non_constant_identifier_names



final String tableservices = 'services';

/* "id": 5,
                "provider_id": 4,
                "type": 2,
                "name_ar": "فواتير",
                "name_en": "Bill Payment",
                "description_ar": null,
                "description_en": null,
                "powered_by_ar": null,
                "powered_by_en": null,
                "icon": "service/2022/11/22/pFFGtZNrCCbRks2ZC66MuGeovyMeUTb2H1zVU1lC.jpeg",
                "accept_amount_input": 0,
                "accept_change_paid_amount": 0,
                "accept_check_integration_provider_status": 0,
                "price_type": 1,
                "price_value": "1",
                "price_value_list": "1",
                "price_min_value": "1",
                "price_max_value": "1000000000",
                "type_code": "NORMAL",
                "sort": 1
            }, */

class ServiveFields {
  static final List<String> values = [
    /// Add all fields
    id, provider_id, name_ar, name_en, description_ar, description_en, logo,
    type,
    powered_by_ar, powered_by_en, icon, accept_amount_input,
    accept_change_paid_amount, accept_check_integration_provider_status,
    price_type, price_value, price_value_list, price_min_value,
    price_max_value, type_code, sort
  ];

  static final String id = 'id';
  static final String provider_id = 'provider_id';
  static final String name_ar = 'name_ar';
  static final String name_en = 'name_en';
  static final String description_ar = 'description_ar';
  static final String description_en = 'description_en';
  static final String powered_by_ar = 'powered_by_ar';
  static final String powered_by_en = 'powered_by_en';
  static final String icon = 'icon';
  static final String logo = 'logo';
  static final String accept_amount_input = 'accept_amount_input';
  static final String accept_change_paid_amount = 'accept_change_paid_amount';
  static final String accept_check_integration_provider_status =
      'accept_check_integration_provider_status';
  static final String price_type = 'price_type';
  static final String price_value = 'price_value';
  static final String price_value_list = 'price_value_list';
  static final String price_min_value = 'price_min_value';
  static final String price_max_value = 'price_max_value';
  static final String type_code = 'type_code';
  static final String sort = 'sort';
  static final String type = 'type';
}

class Services {
  final int? id, provider_id;
  final String ? name_ar,
      name_en,
      description_ar,
      description_en,
      logo,
      icon,
      price_value,
      powered_by_ar,
      powered_by_en,
      price_min_value,
      price_value_list,
      price_max_value,
      type_code;
  final int ? sort,
      accept_amount_input,
      type,
      accept_change_paid_amount,
      accept_check_integration_provider_status,
      price_type;

  const Services(
      {this.id,
      this.provider_id,
      required this.name_ar,
      required this.logo,
      required this.icon,
      required this.type,
      required this.type_code,
      required this.name_en,
      required this.description_ar,
      required this.description_en,
      required this.price_value,
      required this.powered_by_ar,
      required this.powered_by_en,
      required this.price_min_value,
      required this.price_value_list,
      required this.price_max_value,
      required this.accept_amount_input,
      required this.accept_change_paid_amount,
      required this.accept_check_integration_provider_status,
      required this.price_type,
      required this.sort});

  Services copy(
          {final int? id,
          final int? provider_id,
          final String? name_ar,
          final String? name_en,
          final String? description_ar,
          final String? description_en,
          final String? logo,
          final String? icon,
          final String? price_value,
          final String? powered_by_ar,
          final String? powered_by_en,
          final String? price_min_value,
          final String? price_value_list,
          final String? price_max_value,
          final String? type_code,
          final int? accept_amount_input,
          final int? accept_change_paid_amount,
          final int? accept_check_integration_provider_status,
          final int? price_type,
          final int? type,
          final int? sort}) =>
      Services(
        id: id ?? id,
        provider_id: provider_id ?? provider_id,
        name_ar: name_ar ?? this.name_ar,
        name_en: name_en ?? this.name_en,
        icon: icon ?? this.icon,
        description_ar: description_ar ?? this.description_ar,
        description_en: description_en ?? this.description_en,
        price_value: price_value ?? this.price_value,
        powered_by_ar: powered_by_ar ?? this.powered_by_ar,
        powered_by_en: powered_by_en ?? this.powered_by_en,
        price_min_value: price_min_value ?? this.price_min_value,
        price_value_list: price_value_list ?? this.price_value_list,
        price_max_value: price_max_value ?? this.price_max_value,
        type_code: type_code ?? this.type_code,
        logo: logo ?? this.logo,
        sort: sort ?? this.sort,
        type: type ?? this.type,
        accept_amount_input: accept_amount_input ?? this.accept_amount_input,
        accept_change_paid_amount:
            accept_change_paid_amount ?? this.accept_change_paid_amount,
        accept_check_integration_provider_status:
            accept_check_integration_provider_status ??
                this.accept_check_integration_provider_status,
        price_type: price_type ?? this.price_type,
      );
  static Services fromJson(Map<String, Object?> json) => Services(
      id: json[ServiveFields.id] as int?,
      provider_id: json[ServiveFields.provider_id] as int?,
      name_ar: json[ServiveFields.name_ar] as String?,
      name_en: json[ServiveFields.name_en] as String?,
      icon: json[ServiveFields.icon] as String?,
      description_ar: json[ServiveFields.description_ar] as String?,
      description_en: json[ServiveFields.description_en] as String?,
      sort: json[ServiveFields.sort] as int?,
      logo: json[ServiveFields.logo] as String?,
      type: json[ServiveFields.type] as int?,
      accept_amount_input: json[ServiveFields.accept_amount_input] as int?,
      accept_change_paid_amount: json[ServiveFields.accept_amount_input] as int?,
      price_min_value: json[ServiveFields.price_min_value] as String?,
      price_type: json[ServiveFields.price_type] as int?,
      price_max_value: json[ServiveFields.price_max_value] as String?,
      accept_check_integration_provider_status:
          json[ServiveFields.accept_check_integration_provider_status] as int?,
      powered_by_ar: json[ServiveFields.powered_by_ar] as String?,
      powered_by_en: json[ServiveFields.powered_by_en] as String?,
      price_value: json[ServiveFields.price_value] as String?,
      price_value_list: json[ServiveFields.price_value_list] as String?,
      type_code: json[ServiveFields.type_code] as String?);

  Map<String, Object?> toJson() => {
        ServiveFields.id: id,
        ServiveFields.provider_id: provider_id,
        ServiveFields.name_ar: name_ar,
        ServiveFields.name_en: name_en,
        ServiveFields.description_ar: description_ar,
        ServiveFields.description_en: description_en,
        ServiveFields.logo: logo,
        ServiveFields.sort: sort,
        ServiveFields.accept_amount_input: accept_amount_input,
        ServiveFields.accept_change_paid_amount: accept_change_paid_amount,
        ServiveFields.accept_check_integration_provider_status:
            accept_check_integration_provider_status,
        ServiveFields.powered_by_ar: powered_by_ar,
        ServiveFields.powered_by_en: powered_by_en,
        ServiveFields.price_value: price_value,
        ServiveFields.price_type: price_type,
        ServiveFields.price_value_list: price_value_list,
        ServiveFields.icon: icon,
        ServiveFields.price_value: price_value,
        ServiveFields.price_value: price_value,
        ServiveFields.type: type
      };
}
