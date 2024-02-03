// ignore_for_file: library_prefixes

import 'package:dio/dio.dart' as Dio;
import 'package:esh7enly/models/possts.dart';
import 'package:esh7enly/models/poster.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import '../global/dio.dart';

// ignore: camel_case_types
class BannerApi extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  Future getimages() async {
    var token = await storage.read(key: 'token');

    try {
      Dio.Response response = await dio().post(
        'news/all',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );
     
      posts postformat = posts.fromjson((response.data));
      List<Poster> postersslist =
          postformat.post.map((e) => Poster.fromJson(e)).toList();
      notifyListeners();
    
      return postersslist;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
