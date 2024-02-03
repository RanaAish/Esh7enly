// ignore_for_file: camel_case_types, non_constant_identifier_names

class alert {
  int id,userid,serviceid,scduledate;
  final String invoicenumber, namear,nameen;

  alert({
    required this.userid,
    required this.id,
    required this.serviceid,
    required this.invoicenumber,
    required this.namear,
    required this.nameen,
    required this.scduledate
  });

  alert.fromjson(Map<String, dynamic> json)
      : id = json["id"],
        userid = json['user_id'],
        serviceid = json['service_id'],
        invoicenumber = json['invoice_number'],
        scduledate = json['schedule_date'],
        namear=json['name_ar'],
        nameen=json['name_en'];
}
