// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, deprecated_member_use, prefer_const_constructors, unnecessary_new, unnecessary_brace_in_string_interps, unused_local_variable

import 'package:esh7enly/core/widgets/font.dart';
import 'package:flutter/material.dart';
import '../../core/utils/colors.dart';
import '../../core/widgets/header.dart';
import '../../models/inquiryobject.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

import 'dart:typed_data';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';

class transaction_details extends StatefulWidget {
  final Data paymentobject;
  final int servicetype;
  final bool isbluck;
  final int bluknumber;
  const transaction_details(
      {super.key,
      required this.bluknumber,
      required this.paymentobject,
      required this.servicetype,
      required this.isbluck});

  @override
  State<transaction_details> createState() => transaction_detailsState();
}

class transaction_detailsState extends State<transaction_details> {
  final _controller = ScreenshotController();

  ScreenshotController screenshotController = ScreenshotController();
  var _imageFile;

@override
  void initState() {
   
     PdfGenerator.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Screenshot(
        controller: screenshotController,
        child: Scaffold(
            body: SingleChildScrollView(
                child: Directionality(
          textDirection:
              // ignore: unrelated_type_equality_checks
              translator.currentLanguage == 'en'
                  ? TextDirection.ltr
                  : TextDirection.rtl,
          child: Column(children: [
            createpage(),
            Card(
                color: Colors.white,
                elevation: 3,
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.only(
                    top: 0, bottom: 48, right: 30, left: 30),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0))),
                child: Padding(
                    padding: EdgeInsets.only(left: 0, top: 15, bottom: 15),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Image.asset(
                              'assets/ui new -24.png',
                              width: 60,
                              height: 40,
                            ),
                            onTap: () {
                              _takeScreenshotandShare();
                            },
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                              onTap: () {
                                createpdf();
                              },
                              child: Image.asset(
                                'assets/ui new -25.png',
                                width: 60,
                                height: 40,
                              ))
                        ],
                      ),
                    )))
          ]),
        ))));
  }

  _takeScreenshotandShare() async {
    _imageFile = null;
    screenshotController
        .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
        .then((var image) async {
      setState(() {
        _imageFile = image;
      });
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile;
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
     
      await Share.file('Anupam', 'screenshot.png', pngBytes, 'image/png');
    }).catchError((onError) {
    
    });
  }

  createpage() {
    
    return Screenshot(
        controller: _controller,
        child: Column(children: [
          header(
            heightcon: 180,
          ),
          const SizedBox(height: 15),
          // ignore: unrelated_type_equality_checks
          Text(
            // ignore: unrelated_type_equality_checks
            widget.paymentobject.status == 1
                ? translator.translate("pending2")
                : widget.paymentobject.status == 2
                    ? translator.translate("success2")
                    : translator.translate("fail"),
            
            style: TextStyle(
              fontSize: 25,
              color: CustomColors.MainColor,
            ),
          ),
          const SizedBox(height: 4),
          Text("${widget.paymentobject.amount.toString()} EGP",
              
              style: TextStyle(
                fontSize: 19,
                color: CustomColors.MainColor,
              )),
          const SizedBox(height: 2),
          Card(
              color: Colors.white,
              elevation: 3,
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.only(
                  top: 10, bottom: 0, right: 30, left: 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0))),
              child: Padding(
                  padding: EdgeInsets.only(left: 0, top: 0),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 5),
                      child: Text(
                        translator.translate("service"),
                        style: TextStyle(
                            color: CustomColors.MainColor, fontSize: 17),
                      ),
                    ),
                    SizedBox(
                        width: 410,
                        height: 60,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                right: 0, left: 0, top: 0),
                            child: Card(
                                color: Colors.white,
                                elevation: 3,
                                clipBehavior: Clip.antiAlias,
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 8, right: 32, left: 25),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Padding(
                                  // edit in pading space //  left: 20, top: 8, right: 13
                                  padding: EdgeInsets.only(
                                      left: 5, top: 8, right: 5),
                                  child: Text(
                                    "${widget.paymentobject.service!.name!}:${widget.paymentobject.service!.provider!.name!}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: CustomColors.MainColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )))),
                    SizedBox(
                        width: 410,
                        height: 60,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                right: 0, left: 0, top: 0),
                            child: Card(
                                color: Colors.white,
                                elevation: 3,
                                clipBehavior: Clip.antiAlias,
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 8, right: 32, left: 25),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, top: 8, right: 13),
                                    child: Text(
                                      "${translator.translate("transid")} ${widget.paymentobject.id.toString()}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: CustomColors.MainColor,
                                          fontWeight: FontWeight.bold),
                                    ))))), //tranasctionnumber
                    SizedBox(
                        width: 410,
                        height: 60,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                right: 0, left: 0, top: 0),
                            child: Card(
                                color: Colors.white,
                                elevation: 3,
                                clipBehavior: Clip.antiAlias,
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 8, right: 32, left: 25),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, top: 8, right: 13),
                                    child: Text(
                                        "${translator.translate("time")} ${widget.paymentobject.createdAt.toString()}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: CustomColors.MainColor,
                                          fontWeight: FontWeight.bold,
                                        )))))),
                    SizedBox(
                        width: 410,
                        height: 60,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                right: 0, left: 0, top: 0),
                            child: Card(
                                color: Colors.white,
                                elevation: 3,
                                clipBehavior: Clip.antiAlias,
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 8, right: 32, left: 25),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, top: 8, right: 13),
                                    child: Text(
                                      "${translator.translate("amunt")} ${widget.paymentobject.amount.toString()} EGP",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: CustomColors.MainColor,
                                          fontWeight: FontWeight.bold),
                                    ))))),
                    SizedBox(
                        width: 410,
                        height: 60,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                right: 0, left: 0, top: 0),
                            child: Card(
                                color: Colors.white,
                                elevation: 3,
                                clipBehavior: Clip.antiAlias,
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 8, right: 32, left: 25),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, top: 8, right: 13),
                                    child: Text(
                                      "${translator.translate("totalamount")} ${widget.paymentobject.totalAmount.toString()} EGP",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: CustomColors.MainColor,
                                          fontWeight: FontWeight.bold),
                                    ))))),
                    // ignore: unrelated_type_equality_checks
                    widget.paymentobject.type == 3
                        ? const SizedBox(
                            height: 0,
                            width: 0,
                          )
                        : widget.paymentobject.balanceBefore == 0
                            ? const SizedBox(
                                height: 0,
                                width: 0,
                              )
                            : SizedBox(
                                width: 410,
                                height: 60,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 0, left: 0, top: 0),
                                    child: Card(
                                        color: Colors.white,
                                        elevation: 3,
                                        clipBehavior: Clip.antiAlias,
                                        margin: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 8,
                                            right: 32,
                                            left: 25),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 8, right: 13),
                                            child: Text(
                                              "${translator.translate("before")} ${widget.paymentobject.balanceBefore.toString()}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: CustomColors.MainColor,
                                                  fontWeight: FontWeight.bold),
                                            ))))),
                    // ignore: unrelated_type_equality_checks
                    widget.paymentobject.type == 3
                        ? const SizedBox(
                            height: 0,
                            width: 0,
                          )
                        : widget.paymentobject.balanceAfter == 0
                            ? const SizedBox(
                                height: 0,
                                width: 0,
                              )
                            : SizedBox(
                                width: 410,
                                height: 60,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 0, left: 0, top: 0),
                                    child: Card(
                                        color: Colors.white,
                                        elevation: 3,
                                        clipBehavior: Clip.antiAlias,
                                        margin: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 8,
                                            right: 32,
                                            left: 25),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 8, right: 13),
                                            child: Text(
                                              "${translator.translate("after")} ${widget.paymentobject.balanceAfter.toString()}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: CustomColors.MainColor,
                                                  fontWeight: FontWeight.bold),
                                            ))))),
                    //  widget.paymentobject.type==3|| widget.paymentobject.isSettled==0?SizedBox(height: 0,width: 0,):Text(widget.paymentobject.agentCommission.toString()),

                    gettext() == null
                        ? SizedBox(
                            height: 0,
                            width: 0,
                          )
                        : SizedBox(
                            width: 410,
                            height: 60,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 0, left: 0, top: 0),
                                child: Card(
                                    color: Colors.white,
                                    elevation: 3,
                                    clipBehavior: Clip.antiAlias,
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 8,
                                        right: 32,
                                        left: 25),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, top: 8, right: 13),
                                        child: Text("${gettext()}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: CustomColors.MainColor,
                                                fontWeight:
                                                    FontWeight.bold)))))),
                    widget.servicetype == 3
                        ? widget.isbluck
                            ? SizedBox(
                                width: 410,
                                height: 60,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 0, left: 0, top: 0),
                                    child: Card(
                                        color: Colors.white,
                                        elevation: 3,
                                        clipBehavior: Clip.antiAlias,
                                        margin: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 8,
                                            right: 32,
                                            left: 25),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 8, right: 13),
                                            child: Text(
                                                "${widget.bluknumber} + cards")))))
                            : const SizedBox(
                                height: 0,
                                width: 0,
                              )
                        : const SizedBox(
                            height: 0,
                            width: 0,
                          ),

                    widget.paymentobject.clientNumber == null
                        ? const SizedBox(
                            height: 0,
                            width: 0,
                          )
                        : SizedBox(
                            width: 410,
                            height: 60,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 0, left: 0, top: 0),
                                child: Card(
                                    color: Colors.white,
                                    elevation: 3,
                                    clipBehavior: Clip.antiAlias,
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 8,
                                        right: 32,
                                        left: 25),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, top: 8, right: 13),
                                        child: Text(
                                          "${translator.translate("clientnum")} ${widget.paymentobject.clientNumber.toString()}",
                                          style: TextStyle(
                                              color: CustomColors.MainColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ))))),
                    widget.paymentobject.status == 3
                        ? SizedBox(
                            width: 410,
                            height: 70,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 0, left: 0, top: 0),
                                child: Card(
                                    color: Colors.white,
                                    elevation: 3,
                                    clipBehavior: Clip.antiAlias,
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 8,
                                        right: 32,
                                        left: 25),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, top: 8, right: 13),
                                        child: Text(
                                          "${translator.translate("error")} ${widget.paymentobject.message.toString()}",
                                          style: TextStyle(
                                              color: CustomColors.MainColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )))))
                        : SizedBox(width: 0, height: 0)
                  ])))
        ]));
  }

  gettext() {
    String text = "";
    if (widget.servicetype == 3) {
    
      if (widget.paymentobject.description != "" &&
          widget.paymentobject.description != null) {
    
        var lines = widget.paymentobject.description.split("\n");
        for (var line in lines) {
          if (line.contains("PIN")) {
            //visible pin ,serial
            // what,s value
          } else {
            var stringBuilder = StringBuffer();

            for (var i in lines) {
              var key = i;
              stringBuilder.write("•");
              stringBuilder.write(key);
              if (i != lines.length - 1) stringBuilder.write("\n");
              //pin text  stringBuilder
              return '${stringBuilder}';
            }
          }
        }
      }
      if (widget.isbluck) {
        //cards text
        String text = "${widget.bluknumber} + cards";
      }
    }
    if (widget.paymentobject.description != "" &&
        widget.paymentobject.description != null) {
      var lines = widget.paymentobject.description.split("\n");
      for (var line in lines) {
        if (line.contains("Serial")) {
          text = line.trim().toLowerCase().replace("serial:", "");
          return 'Serialnumber:${text}';
        } else if (line.contains("PIN")) {
          text = line.trim().toLowerCase().replace("pin:", "");
          return 'pinnumber:${text}';
        }
      }
    }
  }
   // base: arFont,
      
  createpdf() async {


    final doc = pw.Document();
    doc.addPage(pw.Page(
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(
          base:PdfGenerator.arFont
       ),
        pageFormat: PdfPageFormat.a4,
        //pageFormat: PdfPageFormat.roll80 ,
        build: (pw.Context context) {
          return pw.Directionality(
              textDirection:
                  // ignore: unrelated_type_equality_checks
                  translator.currentLanguage == 'en'
                      ? pw.TextDirection.ltr
                      : pw.TextDirection.rtl,
              child: pw.Column(children: [
                // ignore: unrelated_type_equality_checks
                pw.Text(
                  // ignore: unrelated_type_equality_checks
                  widget.paymentobject.type == 1
                      ? translator.translate("pending2")
                      : widget.paymentobject.type == 2
                          ? translator.translate("success2")
                          : translator.translate("fail"),
                
                  style: pw.TextStyle(
                    fontSize: 25,
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text("${widget.paymentobject.amount.toString()} EGP",
                
                    style: pw.TextStyle(
                      fontSize: 25,
                    )),

                pw.SizedBox(
                  height: 30,
                ),
                pw.SizedBox(
                    width: 410,
                    height: 60,
                    child: pw.Text(
                      "${widget.paymentobject.service!.name!}:${widget.paymentobject.service!.provider!.name!}",
                      style: pw.TextStyle(
                        fontSize: 16,
                      ),
                    )),
                pw.SizedBox(
                    width: 410,
                    height: 60,
                    child: pw.Text(
                      "${translator.translate("transid")} ${widget.paymentobject.id.toString()}",
                      style: pw.TextStyle(
                        fontSize: 16,
                      ),
                    )), //tranasctionnumber
                pw.SizedBox(
                    width: 410,
                    height: 60,
                    child: pw.Text(
                        "${translator.translate("time")} ${widget.paymentobject.createdAt.toString()}",
                        style: pw.TextStyle(
                          fontSize: 16,
                        ))),
                pw.SizedBox(
                    width: 410,
                    height: 60,
                    child: pw.Text(
                        "${translator.translate("amunt")} ${widget.paymentobject.amount.toString()} EGP",
                        style: pw.TextStyle(
                          fontSize: 16,
                        ))),
                pw.SizedBox(
                    width: 410,
                    height: 60,
                    child: pw.Text(
                        "${translator.translate("totalamount")} ${widget.paymentobject.totalAmount.toString()} EGP",
                        style: pw.TextStyle(
                          fontSize: 16,
                        ))),
                // ignore: unrelated_type_equality_checks
                widget.paymentobject.type == 3
                    ? pw.SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : pw.SizedBox(
                        width: 410,
                        height: 60,
                        child: pw.Text(
                            "${translator.translate("before")} ${widget.paymentobject.balanceBefore.toString()}",
                            style: pw.TextStyle(
                              fontSize: 16,
                            ))),
                // ignore: unrelated_type_equality_checks
                widget.paymentobject.type == 3
                    ? pw.SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : pw.SizedBox(
                        width: 410,
                        height: 60,
                        child: pw.Text(
                          "${translator.translate("after")} ${widget.paymentobject.balanceAfter.toString()}",
                          style: pw.TextStyle(
                            fontSize: 16,
                          ),
                        )),
                //  widget.paymentobject.type==3|| widget.paymentobject.isSettled==0?SizedBox(height: 0,width: 0,):Text(widget.paymentobject.agentCommission.toString()),

                gettext() == null
                    ? pw.SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : pw.SizedBox(
                        width: 410,
                        height: 60,
                        child: pw.Text("${gettext()}",
                            style: pw.TextStyle(
                              fontSize: 16,
                            ))),
                widget.servicetype == 3
                    ? widget.isbluck
                        ? pw.SizedBox(
                            width: 410,
                            height: 60,
                            child: pw.Text("${widget.bluknumber} + cards"))
                        : pw.SizedBox(
                            height: 0,
                            width: 0,
                          )
                    : pw.SizedBox(
                        height: 0,
                        width: 0,
                      ),

                widget.paymentobject.clientNumber == null
                    ? pw.SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : pw.SizedBox(
                        width: 410,
                        height: 60,
                        child: pw.Padding(
                            padding:
                                pw.EdgeInsets.only(right: 0, left: 0, top: 0),
                            child: pw.Padding(
                                padding: pw.EdgeInsets.only(left: 20, top: 8),
                                child: pw.Text(
                                  "${translator.translate("clientnum")} ${widget.paymentobject.clientNumber.toString()}",
                                  style: pw.TextStyle(fontSize: 16),
                                )))),

                widget.paymentobject.status == 3
                    ? pw.SizedBox(
                        width: 410,
                        height: 70,
                        child: pw.Padding(
                            padding:
                                pw.EdgeInsets.only(right: 0, left: 0, top: 0),
                            child: pw.Padding(
                                padding: pw.EdgeInsets.only(left: 20, top: 8),
                                child: pw.Text(
                                  "${translator.translate("error")} ${widget.paymentobject.message.toString()}",
                                  style: pw.TextStyle(fontSize: 16),
                                ))))
                    : pw.SizedBox(width: 0, height: 0),
              ]));
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}



/*

comissiopn value????
serial pin value???
 for(oneLine in lines)
                {
                    if(oneLine.contains("PIN"))
                    {
                        ui.lytPin.visibility = View.VISIBLE
                        ui.lytSerial.visibility = View.VISIBLE
                    }


 */



/* Future<void> shareScreenshot() async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    final String localPath =
        '${directory!.path}/${DateTime.now().toIso8601String()}.png';
    print(localPath);
    await _controller.captureAndSave(localPath);

    await Future.delayed(Duration(seconds: 1));

    await FlutterShare.shareFile(
        text: 'Example share text', filePath: localPath, title: 'tt');
  }

  /*_takeScreenshotandShare() async {
    _imageFile = null;
    screenshotController
        .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
        .then((var image) async {
      setState(() {
        _imageFile = image;
      });
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile.readAsBytesSync();
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      print("File Saved to Gallery");
    }).catchError((onError) {
      print(onError);
    });
  }
 */ */