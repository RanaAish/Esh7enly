// ignore_for_file: camel_case_types, file_names

class totalamounts {
  final String? imei;
  final int? serviceid;
  final String? pricevalue;

  List<Map>? parameters;

  totalamounts({
    required this.imei,
    required this.serviceid,
    required this.pricevalue,
  });
  totalamounts.pareameters({
    required this.imei,
    required this.serviceid,
    required this.pricevalue,
    required this.parameters,
  });
}
