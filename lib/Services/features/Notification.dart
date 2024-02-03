// ignore_for_file: use_build_context_synchronously, deprecated_member_use, non_constant_identifier_names, library_prefixes, file_names

import 'package:dio/dio.dart' as Dio;
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:esh7enly/models/alert.dart';
import 'package:esh7enly/models/alerts.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../global/dio.dart';

// ignore: camel_case_types
class NotificationApi extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  Future checkinvoice(int? serviceid, var num, BuildContext context) async {
    Map creds = {"service_id": serviceid, "invoice_number": num};
    var token = await storage.read(key: 'token');
    print(creds);
    try {
      Dio.Response response = await dio().post(
        'schedule/check',
        data: creds,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

      notifyListeners();
      if (response.data["message"] == "Unauthenticated") {
        EasyLoading.dismiss();
        DailogAlert.openAlert(translator.translate("unauth"),
            translator.translate("failedmessage"), context);
        return;
      }
      print('output ${response.data['status']}');
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future addnotify(
      int serviceid, var num, BuildContext context, int schedule_date) async {
    Map creds = {
      "service_id": serviceid,
      "invoice_number": num,
      "schedule_date": schedule_date
    };
    var token = await storage.read(key: 'token');
    try {
      Dio.Response response = await dio().post(
        'schedule/add',
        data: creds,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

      notifyListeners();
      if (response.data["message"] == "Unauthenticated") {
        EasyLoading.dismiss();
        DailogAlert.openAlert(translator.translate("unauth"),
            translator.translate("failedmessage"), context);
        return;
      }

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future scdulelist(BuildContext context) async {
    var token = await storage.read(key: 'token');

    try {
      Dio.Response response = await dio().post(
        'schedule/list',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

      notifyListeners();
      if (response.data["message"] == "Unauthenticated") {
        EasyLoading.dismiss();
        DailogAlert.openAlert(translator.translate("unauth"),
            translator.translate("failedmessage"), context);
        return;
      }
      print('test');
      print('output ${response.data}');
      Alerts serviceformat = Alerts.fromjson((response.data));
      List<alert> alertlist =
          serviceformat.lists.map((e) => alert.fromjson(e)).toList();
       //   print( alertlist.length);
      return alertlist;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
