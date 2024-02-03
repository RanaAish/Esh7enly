// ignore_for_file: camel_case_types

class servicesmodel {
  final List<dynamic> serviceslist;

  servicesmodel(this.serviceslist);
  servicesmodel.fromjson(Map<String, dynamic> json)
      : serviceslist = json['data']['services'];
}
