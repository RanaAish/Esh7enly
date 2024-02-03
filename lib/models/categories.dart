class Categories {
  final List<dynamic> categories;

  Categories(this.categories);
  Categories.fromjson(Map<String, dynamic> json)
      : categories = json['data']['categories'];
}
