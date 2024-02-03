class Alerts {
  final List<dynamic> lists;

 Alerts(this.lists);
  Alerts.fromjson(Map<String, dynamic> json)
      : lists = json['data'];
}
