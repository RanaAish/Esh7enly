import 'package:flutter/cupertino.dart';

// ignore: camel_case_types
class providerloader extends ChangeNotifier {
  // modelhut
  bool isloading = false;
  int idnotification = 0;
  chngechannel() {
    idnotification = idnotification + 1;
    notifyListeners();
  }

  changeisloading(bool value) {
    isloading = value;
    notifyListeners();
  }
}
