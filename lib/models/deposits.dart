// ignore_for_file: camel_case_types

class deposits {
  final List<dynamic> depos;

  deposits(this.depos);
  deposits.fromjson(Map<String, dynamic> json)
      : depos = json['data']['data'];
}
