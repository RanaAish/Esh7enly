// ignore_for_file: camel_case_types

class paymentmodel {
  final String? imei;
  final int? serviceid;
  final String amount;
  final String? total;
  List<Map>? parameters;
  int? id;

  paymentmodel(
      {required this.imei,
      required this.serviceid,
      required this.amount,
      required this.total});

  paymentmodel.pareameters({
    required this.imei,
    required this.serviceid,
    required this.amount,
    required this.total,
    required this.parameters,
  });
  paymentmodel.finalpayment(
      {required this.imei,
      required this.serviceid,
      required this.amount,
      required this.total,
      required this.parameters,
      required this.id});
}
