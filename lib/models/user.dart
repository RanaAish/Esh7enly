// ignore_for_file: camel_case_types, non_constant_identifier_names

class user {
  int id;
  final String token, name, mobile, last_login;

  user({
    required this.name,
    required this.id,
    required this.token,
    required this.mobile,
    required this.last_login,
  });

  user.fromjson(Map<String, dynamic> json)
      : name = json["name"],
        id = json['id'],
        token = json['token'],
        mobile = json['mobile'],
        last_login = json['last_login'];
}
