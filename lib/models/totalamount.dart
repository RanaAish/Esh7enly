// ignore_for_file: camel_case_types, non_constant_identifier_names

class totalamount {
  int service_charge, total_amount, paid_amount, system, agent, merchant, code;
  final String message, amount;
  bool status;

  totalamount({
    required this.agent,
    required this.service_charge,
    required this.total_amount,
    required this.paid_amount,
    required this.system,
    required this.merchant,
    required this.code,
    required this.message,
    required this.amount,
    required this.status,
  });

  totalamount.fromJson(Map<String, dynamic> json)
      : service_charge = json['service_charge'],
        total_amount = json['total_amount'],
        paid_amount = json['paid_amount'],
        system = json['system'],
        agent = json['agent'],
        merchant = json['merchant'],
        code = json['code'],
        message = json['message'],
        amount = json['amount'],
        status = json['status'];
}
