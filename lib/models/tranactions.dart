class Tranactions {
  final List<dynamic> tranactions;

  Tranactions(this.tranactions);
  Tranactions.fromjson(Map<String, dynamic> json) : tranactions = json['data']['data'];
}
