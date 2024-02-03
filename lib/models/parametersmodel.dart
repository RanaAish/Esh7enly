class Parametersmodel {
  final List<dynamic> parameterslist;

  Parametersmodel(this.parameterslist);
  Parametersmodel.fromjson(Map<String, dynamic> json)
      : parameterslist = json['data']['parameters'];
}
