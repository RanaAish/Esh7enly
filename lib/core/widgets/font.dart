
import 'package:flutter/services.dart';

import 'package:pdf/widgets.dart';

class PdfGenerator {
  static late Font arFont;

  static  init() async {
    arFont = Font.ttf((await rootBundle.load("assets/font/Amiri-Regular.ttf")));
    return arFont;
  }
}
