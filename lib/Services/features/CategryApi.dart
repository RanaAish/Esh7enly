// ignore: library_prefixes
// ignore_for_file: avoid_print, library_prefixes, empty_catches, duplicate_ignore, file_names

import 'package:dio/dio.dart' as Dio;
import 'package:esh7enly/db/imagesdb.dart';
import 'package:esh7enly/models/Imagesmodel.dart';
import 'package:esh7enly/models/Providersmodel.dart';
import 'package:esh7enly/models/categories.dart';
import 'package:esh7enly/models/category.dart';
import 'package:esh7enly/models/parameters.dart';
import 'package:esh7enly/models/parametersmodel.dart';
import 'package:esh7enly/models/provider.dart';
import 'package:esh7enly/models/services.dart';
import 'package:esh7enly/models/servicesmodel.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../db/providerdb.dart';
import '../../db/servicedb.dart';
import '../../models/Image.dart';
import '../global/dio.dart';
import '../../db/categoriesdb.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class CategoryApi extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  // String? token = "f4090be887f3416759e281ca6943a11d5b62e7d147b4fc1cc447a44c9243fa81";

  Future<List<Category>> getallcategoriess() async {
    var tocken = await storage.read(key: 'token');

    try {
      Dio.Response response = await dio().post(
        'service/list',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $tocken'},
          validateStatus: (_) => true,
        ),
      );
      if (response.data["message"] == "Unauthenticated") {
        EasyLoading.dismiss();
        return [];
      }
//      print(response.data);

      Categories categoryformat = Categories.fromjson((response.data));
      List<Category> categoryslist =
          categoryformat.categories.map((e) => Category.fromJson(e)).toList();

      Providers providerformat = Providers.fromjson((response.data));
      List<Provider> providerslist =
          providerformat.providers.map((e) => Provider.fromJson(e)).toList();

      servicesmodel serviceformat = servicesmodel.fromjson((response.data));
      List<Services> serviceslist =
          serviceformat.serviceslist.map((e) => Services.fromJson(e)).toList();

      Parametersmodel parameterformat =
          Parametersmodel.fromjson((response.data));
      List<parameters> parameterslist = parameterformat.parameterslist
          .map((e) => parameters.fromJson(e, 0))
          .toList();

      imagesmodel imageformat = imagesmodel.fromjson((response.data));
      List<Imageparameters> imagelists = imageformat.imageslist
          .map((e) => Imageparameters.fromJson(e))
          .toList();
//ProviderDatabase.instance.getcount().then((value) async {
     categoryDatabase.instance.getcount().then((value) async {
        if (value == true) {
          storage.write(
              key: 'updatenum', value: response.data['service_update_num']);
          createcategory(categoryslist);
          createprovider(providerslist);
          createservices(serviceslist);
          createparameters(parameterslist);
          createimsges(imagelists);
        } else {
          var num = await storage.read(key: 'updatenum');
          print('test');
          print(num);
          print(response.data['service_update_num']);
          if (num != response.data['service_update_num']) {
            // delete all db
            await sqflite.deleteDatabase('categories.db');
            await sqflite.deleteDatabase('IMAGESlist.db');
            await sqflite.deleteDatabase('PROVIDERS.db');
            await sqflite.deleteDatabase('SERVICES.db');

            // create all db
            createcategory(categoryslist);
            createprovider(providerslist);
            createservices(serviceslist);
            createparameters(parameterslist);
            createimsges(imagelists);
          }
        }
      });

      notifyListeners();
      return categoryslist;
    } catch (e) {}
    return [];
  }

  Future getcategoriess() async {
    var tocken = await storage.read(key: 'token');
    try {
      Dio.Response response = await dio().post(
        'service/list',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $tocken'},
          validateStatus: (_) => true,
        ),
      );

      Categories categoryformat = Categories.fromjson((response.data));
      List<Category> categoryslist =
          categoryformat.categories.map((e) => Category.fromJson(e)).toList();

      notifyListeners();

      return categoryslist;
    } catch (e) {}

    return null;
  }

  Future createcategory(List categories) async {
    // ignore: unrelated_type_equality_checks
    categoryDatabase.instance.getcount().then((value) => print(value));
    // ignore: unrelated_type_equality_checks
    for (var object in categories) {
      categoryDatabase.instance.create(object);
    }
  }

  Future createprovider(List providers) async {
    // ignore: unrelated_type_equality_checks
    ProviderDatabase.instance.getcount().then((value) => print(value));
    // ignore: unrelated_type_equality_checks
    for (var object in providers) {
      ProviderDatabase.instance.create(object);
    }
  }

  Future createservices(List services) async {
    // ignore: unrelated_type_equality_checks

    for (var object in services) {
      ServiceDatabase.instance.createservice(object);
    }
  }

  Future createparameters(List parameters) async {
    // ignore: unrelated_type_equality_checks

    for (var object in parameters) {
      ServiceDatabase.instance.createparameter(object);
    }
  }

  Future createimsges(List images) async {
    // ignore: unrelated_type_equality_checks

    for (var object in images) {
      ImageDatabase.instance.createimage(object);
    }
  }
}

// check update service name
// check categories when start app shemer loader
// check search     crotselectricity كروت الكهرباء فكه
