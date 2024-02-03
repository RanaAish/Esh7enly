// ignore: file_names
// ignore_for_file: camel_case_types, file_names, duplicate_ignore

class imagesmodel {
  final List<dynamic> imageslist;

  imagesmodel(this.imageslist);
  imagesmodel.fromjson(Map<String, dynamic> json)
      : imageslist = json['data']['images'];
}
