// ignore_for_file: camel_case_types

class posts {
  final List<dynamic> post;

  posts(this.post);
  posts.fromjson(Map<String, dynamic> json)
      : post = json['data']['data'];
}
