// ignore_for_file: non_constant_identifier_names, camel_case_types

class depositmodel {
  int? id;
  String? amount, status, type;
  String? created_at;

  //final String name_ar, name_en, description_ar, description_en, icon;

  depositmodel({
    required this.id,
    required this.amount,
    required this.status,
    required this.type,
    required this.created_at,
  });

  depositmodel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        amount = json['amount'],
        status = json['status'],
        type=json['type'],
        created_at = json['created_at'];
}
