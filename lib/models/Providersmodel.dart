// ignore_for_file: file_names

class Providers {
  final List<dynamic> providers;

  Providers(this.providers);
  Providers.fromjson(Map<String, dynamic> json)
      : providers = json['data']['providers'];
}
