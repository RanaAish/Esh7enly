// ignore_for_file: deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace, unused_local_variable, non_constant_identifier_names, unnecessary_brace_in_string_interps, prefer_collection_literals, use_build_context_synchronously, prefer_if_null_operators

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esh7enly/Services/features/Notification.dart';
import 'package:esh7enly/Services/features/ServiceApi.dart';
import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:esh7enly/models/inquiryobject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:unique_identifier/unique_identifier.dart';
import '../../core/widgets/CustomTextField.dart';
import '../../models/parameters.dart';
import '../../models/payment.dart';
import '../../models/services.dart';
import 'Fatora_details.dart';

class Detailsinquiry extends StatefulWidget {
  final Services service;
  final String providername;
  final List parameters;
  final Data responcemodel;
  final List<Map> arraytosend;
  const Detailsinquiry(
      {Key? key,
      required this.responcemodel,
      required this.service,
      required this.providername,
      required this.arraytosend,
      required this.parameters})
      : super(key: key);

  @override
  State<Detailsinquiry> createState() => _DetailsinquiryState();
}

class _DetailsinquiryState extends State<Detailsinquiry> {
  late var amountcontroller = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  late var onecontroller;
  late var twocontroller = TextEditingController();
  late var threecontroller = TextEditingController();
  late var fourcontroller = TextEditingController();
  late var changecontroller = TextEditingController();

  late var Amountcontroller =
      TextEditingController(text: widget.responcemodel.amount.toString());

  // ignore: prefer_typing_uninitialized_variables
  var _category;
  List<Map> output = [];
  var categories = ['o'];
  Map values = Map();
  // ignore: prefer_typing_uninitialized_variables
  var hintamount, hintwidget;
  bool shouldBreak = false;
  Map amountfromtypes = Map();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      hintamount = widget.responcemodel.amount.toString();
    });
    return Scaffold(
        body: SingleChildScrollView(
            child: Directionality(
                textDirection:
                    // ignore: unrelated_type_equality_checks
                    translator.currentLanguage == 'en'
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                child: Column(children: [
                  Container(
                      height: 100,
                      decoration: const BoxDecoration(
                          color: CustomColors.MainColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(40),
                              bottomLeft: Radius.circular(40))),
                      child: Directionality(
                          textDirection: translator.currentLanguage == 'ar'
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  right: 30, left: 30, top: 30),
                              child: Row(children: <Widget>[
                                SizedBox(
                                    width: 30,
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 26,
                                        ),
                                        onPressed: () {
                                          Get.back();
                                        })),
                                Text('    ${widget.providername}',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'ReadexPro',
                                      color: Colors.white,
                                    )),
                              ])))),
                  SizedBox(
                    height: 90,
                  ),
                  SizedBox(
                      width: 445,//440
                      height: 550, // default   185  // one text field:255
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 9, right: 20, left: 20, bottom: 10),
                          child: Center(
                              child: Card(
                                  color: Colors.white,
                                  elevation: 3,
                                  clipBehavior: Clip.antiAlias,
                                  margin: const EdgeInsets.only(
                                      top: 0, bottom: 1, right: 0, left: 0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1.0)),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 20,
                                          right: 0,
                                          left: 20,
                                          bottom: 7),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              right: 10,
                                              left: 10),
                                          child: SingleChildScrollView(child:Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Column(
                                                      children: [
                                                       Text(
                                                                widget
                                                                    .providername,
                                                               
                                                                  
                                                                softWrap: true,
                                                                style: const TextStyle(
                                                                    color: CustomColors
                                                                        .MainColor,
                                                                    fontSize:
                                                                        16)),
                                                        Text(
                                                          translator.currentLanguage ==
                                                                  'ar'
                                                              ? "${widget.service.name_ar}"
                                                              : "${widget.service.name_en}",
                                                          style: TextStyle(
                                                              color: CustomColors
                                                                  .MainColor,
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 14,
                                                    ),
                                                    Container(
                                                      width: 70,//90
                                                      height: 66,
                                                      color: Colors.white,
                                                      child: widget.service
                                                              .icon!.isEmpty
                                                          ? Image.asset(
                                                              'assets/logo.png')
                                                          : CachedNetworkImage(
                                                              imageUrl:
                                                                  "https://e-esh7nly.org/storage/${widget.service.icon}",
                                                              placeholder:
                                                                  (context,
                                                                          url) =>
                                                                      Center(
                                                                child: Image.asset(
                                                                    'assets/logo.png'),
                                                              ),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Image.asset(
                                                                      'assets/logo.png'),
                                                            ),
                                                    ),
                                                  ]),
                                              SizedBox(
                                                height: 18,
                                              ),
                                              SizedBox(
                                                  //    250 type ==4 160 280
                                                  //     width: 400,
                                                  height: double.parse((78 *
                                                          (widget.parameters
                                                              .length))
                                                      .toString()),
                                                  child: ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: widget
                                                          .parameters.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        print(
                                                            widget.parameters);
                                                        return SizedBox(
                                                            child: widget
                                                                        .parameters[
                                                                            index]
                                                                        .type ==
                                                                    1
                                                                ? layoutone(
                                                                    context,
                                                                    widget.parameters[
                                                                        index])
                                                                : widget.parameters[index].type ==
                                                                        2
                                                                    ? layouttwo(
                                                                        context,
                                                                        widget.parameters[
                                                                            index])
                                                                    : widget.parameters[index].type ==
                                                                            3
                                                                        ? layoutthree(
                                                                            context,
                                                                            widget.parameters[
                                                                                index])
                                                                        : widget.parameters[index].type ==
                                                                                4
                                                                            ? layoutfour(context,
                                                                                widget.parameters[index])
                                                                            : widget.parameters[index].type == 5
                                                                                ? layoutfive(context, widget.parameters[index])
                                                                                : layoutsix(context, widget.parameters[index]));
                                                      })),
                                              widget.service
                                                          .accept_amount_input ==
                                                      1
                                                  ? layoutamount(context)
                                                  : const SizedBox(
                                                      height: 0,
                                                    ),
                                              widget.responcemodel
                                                              .description ==
                                                          " " ||
                                                      widget.responcemodel
                                                              .description ==
                                                          null
                                                  ? staticlayout(
                                                      context,
                                                      "المعلومات",
                                                      widget.responcemodel
                                                          .description!,
                                                      false)
                                                  : const SizedBox(
                                                      height: 0,
                                                    ),
                                              staticlayout(context, "المبلغ",
                                                  hintamount, true),
                                              staticlayout(
                                                  context,
                                                  "الرسوم",
                                                  widget.responcemodel
                                                      .serviceCharge
                                                      .toString(),
                                                  false),
                                              staticlayout(
                                                  context,
                                                  "الاجمالي",
                                                  widget
                                                      .responcemodel.totalAmount
                                                      .toString(),
                                                  false),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  EasyLoading.show(
                                                      status: translator
                                                                  .currentLanguage ==
                                                              'ar'
                                                          ? 'جاري التحميل '
                                                          : 'loading...',
                                                      maskType:
                                                          EasyLoadingMaskType
                                                              .black);
                                                  output.clear();
                                                  shouldBreak = false;
                                                  if (getboolenvalue()) {
                                                    // output.add(amountfromtypes);
                                                    openAlertconfirm();
                                                  }
                                                },
                                                child: Container(
                                                  height: 30,//39
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 0),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        CustomColors.MainColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      translator
                                                          .translate("pay"),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                            ],
                                          ))))))))
                ]))));
  }

  Widget layoutamount(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  ' ${translator.translate("amunt")}',
                  style: TextStyle(fontSize: 16, color: CustomColors.MainColor),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 40,
                  child: CustomTextField(
                      OnTab: () {},
                      dense: false,
                      controller: Amountcontroller,
                      Padding: const EdgeInsets.only(
                          right: 16, top: 0, bottom: 0, left: 16)),
                )),
          ],
        ));
  }

  layoutthree(BuildContext context, parameters item) {
    DateTime datetime = DateTime.now();
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  translator.currentLanguage == 'ar'
                      ? item.name_ar!
                      : item.name_en!,
                  style: TextStyle(fontSize: 16, color: CustomColors.MainColor),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 40,
                  child: CustomTextField(
                      enable: false,
                      value: setvalue(item.internal_id!),
                      OnTab: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: datetime,
                            firstDate: DateTime(1800),
                            lastDate: DateTime(2100));
                        if (newDate == null) return;
                        threecontroller.text =
                            "${newDate.year}-${newDate.month}-${newDate.day}";
                      },
                      dense: false,
                      //controller: threecontroller,
                      Padding: const EdgeInsets.only(
                          right: 16, top: 0, bottom: 0, left: 16)),
                )),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }

  layoutone(BuildContext context, parameters item) {
    onecontroller = TextEditingController(text: setvalue(item.internal_id!));
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  translator.currentLanguage == 'ar'
                      ? item.name_ar!
                      : item.name_en!,
                  style: TextStyle(fontSize: 16, color: CustomColors.MainColor),
                )),
            Padding(
                padding: EdgeInsets.only(
                  top: 5,
                ),
                child: Container(
                  height: 40,
                  child: CustomTextField(
                      // value: setvalue(item.internal_id),
                      enable: true,
                      suffic: item.is_client_number == 1
                          ? IconButton(
                              icon: Icon(Icons.account_box),
                              onPressed: () async {
                                /* bool isShown = await Permission
                                    .contacts.shouldShowRequestRationale;
                                askPermission();
                                // Get all contacts
                                if (await Permission
                                    .speech.isPermanentlyDenied) {
                                  // The user opted to never again see the permission request dialog for this
                                  // app. The only way to change the permission's status now is to let the
                                  // user manually enable it in the system settings.
                                  openAppSettings(); */
                              })
                          : null,
                      OnTab: () {
                        //convert text to enghish numbers
                      },
                      type: TextInputType.number,
                      dense: false,
                      controller: onecontroller,
                      Padding: EdgeInsets.only(
                          right: 16, top: 0, bottom: 0, left: 16)),
                )),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }

  layouttwo(BuildContext context, parameters item) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(right: 8, top: 5),
                child: Text(
                  translator.currentLanguage == 'ar'
                      ? item.name_ar!
                      : item.name_en!,
                  style: TextStyle(fontSize: 16, color: CustomColors.MainColor),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(
                  height: 40,
                  child: CustomTextField(
                      value: setvalue(item.internal_id!),
                      enable: false,
                      OnTab: () {},
                      dense: false,
                      // controller: twocontroller,
                      Padding: EdgeInsets.only(
                          right: 16, top: 0, bottom: 0, left: 16)),
                )),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }

  String? amountselect;

  layoutsix(BuildContext context, parameters item) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
            padding: EdgeInsets.only(right: 15),
            child: SizedBox(
                //    250 type ==4 160 280
                height: 50,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                          title: setdropdownvalues(item.internal_id!, item),
                          value: categories[index],
                          groupValue: amountselect,
                          onChanged: null);
                    }))));
  }

  layoutfour(BuildContext context, parameters item) {
    late var datecontroller = TextEditingController();
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  translator.currentLanguage == 'ar'
                      ? item.name_ar!
                      : item.name_en!,
                  style: TextStyle(fontSize: 16, color: CustomColors.MainColor),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(
                  height: 70,
                  child: CustomTextField(
                      value: setvalue(item.internal_id!),
                      enable: false,
                      OnTab: () async {},
                      dense: false,
                      lines: 4,
                      // controller: datecontroller,
                      Padding: EdgeInsets.only(
                          right: 16, top: 0, bottom: 0, left: 16)),
                )),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }

  layoutfive(BuildContext context, parameters item) {
    readtypesvalue(item);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  'الفتره',
                  style: TextStyle(fontSize: 16, color: CustomColors.MainColor),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(
                  height: 40,
                  child: createdropdown(item),
                )),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }

  Widget staticlayout(
      BuildContext context, String text, String hint, bool flag) {
    var Infocontroller = TextEditingController(text: hint);
    // valueNotifier.value = "";

    return Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
            width: 400,
            // height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 0, top: 10),
                    child: Center(
                      child: Text(
                        "${text} :",
                        style: TextStyle(
                            fontSize: 15, color: CustomColors.MainColor),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 15, right: 0, left: 0),
                    child: Container(
                      height:
                          hint == widget.responcemodel.description ? 40 : 40,
                      width: 214,//220
                      child: CustomTextField(
                          changed: (value) {},
                          //value: changecontroller.text,
                          // hint: hint,
                          OnTab: () {
                            if (flag == true &&
                                widget.service.accept_change_paid_amount == 1 &&
                                widget.responcemodel.maxAmount !=
                                    widget.responcemodel.minAmount) openAlert();
                          },
                          dense: false,
                          controller:
                              flag == true ? Amountcontroller : Infocontroller,
                          Padding: EdgeInsets.only(
                              right: 12, top: 0, bottom: 0, left: 16)),
                    )),
              ],
            )));
  }

  createdropdown(parameters item) {
    categories.remove('o');
    return DropdownButtonFormField(
      value: _category,
      onChanged: null,
      validator: (value) {
        if (value == null || value == '') {
          return '  فارغ ';
        }
        return null;
      },
      isDense: true,
      items: categories.map((String category) {
        return DropdownMenuItem(
            value: category,
            child: Center(
              child: Text(category),
            ));
      }).toList(),
      isExpanded: true,
      hint: Center(child: Text(widget.responcemodel.amount.toString())),
      decoration: InputDecoration(
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
        hintText: setdropdownvalues(item.internal_id!, item),
        hintStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Color(0xFF00BAB5)),
        filled: true,
        contentPadding:
            const EdgeInsets.only(right: 16, top: 0, bottom: 0, left: 16),
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey)),
      ),
    );
  }

  setvalue(String internal_id) {
    for (var value in widget.responcemodel.parameters!) {
      if (internal_id == value.internalId) {
        return value.value.toString();
      }
    }
  }

  void readtypesvalue(parameters item) {
    values.clear();
    List list =
        item.type_values.replaceAll('[', '').replaceAll(']', '').split('},');
    for (var obj in list) {
      String text = obj + "}";

      String result = text
          .replaceAll("{", "{\"")
          .replaceAll("}", "\"}")
          .replaceAll(":", "\":\"")
          .replaceAll(",", "\",\"");

      if (result.contains('}"}') == true) {
        result = result.replaceAll('}"}', "}");
      }
      final data = jsonDecode(result);

      Map datatypes = Map();
      if (translator.currentLanguage == 'ar') {
        categories.add(data[" name_ar"]);
        values[data[" name_ar"]] = data["value"];
      } else {
        categories.add(data[" name_en"]);
        values[data[" name_en"]] = data["value"];
      }
    }
  }

  setdropdownvalues(String internalid, parameters item) {
    String hint = "";
    for (var value in widget.responcemodel.parameters!) {
      if (internalid == value.internalId) {
        values.forEach((key, val) {
          if (val.trim() == value.value!.trim()) {
            hint = key;
          }
        });
      }
    }
    return hint;
  }

  void openAlert() {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: Container(
        height: 193.0, //187
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 13),   //16
          //   decoration: boxDecorationStylealert,
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 22),
          height: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(translator.translate("confirm"),
                    style: TextStyle(
                      fontSize: 22,
                    )),
              ),
              SizedBox(
                height: 4,
              ),
              Center(
                child: Text(
                  "${widget.responcemodel.maxAmount} , ${widget.responcemodel.minAmount}يمكنك تغير القيمه بين ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextField(
                  OnTab: () {},
                  dense: true,
                  controller: changecontroller,
                  Padding:
                      EdgeInsets.only(right: 15, top: 5, bottom: 5, left: 15)),
              SizedBox(
                height: 9,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: CustomColors.MainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          translator.translate("cancel"),
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: MaterialButton(
                        onPressed: () async {
                          setState(() {
                            Amountcontroller.text = changecontroller.text;

                            changecontroller.clear();
                          });

                          Navigator.pop(context);
                        },
                        color: CustomColors.MainColor,
                        // ignore: sort_child_properties_last
                        child: const Text(
                          "OK",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  void openAlertconfirm() {
    EasyLoading.dismiss();
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: Container(
        height: 140.0, // 130
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 16),
          //   decoration: boxDecorationStylealert,
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 24),
          height: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(translator.translate("confirm"),
                    style: TextStyle(
                      fontSize: 19,
                    )),
              ),
              SizedBox(
                height: 8,
              ),
              Center(
                child: Text(
                  " ؟ EGp  ${widget.responcemodel.totalAmount}  هل انت متاكد من دفع ُ ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: CustomColors.MainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          translator.translate("cancel"),
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: MaterialButton(
                        onPressed: () async {
                          EasyLoading.show(
                              status: translator.currentLanguage == 'ar'
                                  ? 'جاري التحميل '
                                  : 'loading...',
                              maskType: EasyLoadingMaskType.black);
                          serviceApi obj = serviceApi();
                          String? identifier = await UniqueIdentifier.serial;

                          if (widget.service
                                  .accept_check_integration_provider_status ==
                              1) {
                            obj
                                .checkintegration(identifier,
                                    widget.responcemodel.id, context)
                                .then((value) {
                              if (value["status"] == true) {
                                paymentmodel objectmodel =
                                    paymentmodel.finalpayment(
                                        amount: widget.responcemodel.amount
                                            .toString(),
                                        imei: identifier,
                                        total: widget.responcemodel.totalAmount
                                            .toString(),
                                        serviceid: widget.service.id,
                                        id: widget.responcemodel.id,
                                        parameters: output);
                                obj
                                    .payment(objectmodel, context)
                                    .then((value2) {
                                  if (value2['status'] == true) {
//get fatora
                                    print('test');
                                    Data paymentformat =
                                        Data.fromJson((value2['data']));

                                    // check notification

                                    NotificationApi()
                                        .checkinvoice(
                                            widget.service.id,
                                            paymentformat.clientNumber
                                                .toString(),
                                            context)
                                        .then((value3) {
                                      print(value3);
                                      if (value3['status'] == true) {
                                        EasyLoading.dismiss();
                                        DailogAlert.opennotifyAlert(
                                              translator.currentLanguage == 'en'
                      ? "Alert":"تنبيه",
                                     translator.currentLanguage == 'en'?  "Are you want add this service to reminder":"هل تريد اضافه الخدمه لتذكيرك في وقتها ؟",
                                            context,
                                            widget.service.id!,
                                            paymentformat.clientNumber
                                                .toString(),
                                            paymentformat,
                                            widget.service.type!);
                                      } else {
                                        EasyLoading.dismiss();
                                        // get fators
                                        Get.off(fatora_details(
                                          bluknumber: 0,
                                          isbluck: false,
                                          paymentobject: paymentformat,
                                          servicetype: widget.service.type!,
                                        ));
                                      }
                                    });
                                  } else {
//print message
                                    EasyLoading.dismiss();
                                    DailogAlert.openbackAlert(
                                        "${value2['message']}",
                                        translator.translate("fail"),
                                        context);
                                  }
                                });
                              } else {
                                EasyLoading.dismiss();
                                DailogAlert.openbackAlert("${value['message']}",
                                    translator.translate("fail"), context);
                              }
                            });
                          } else {
                            paymentmodel objectmodel =
                                paymentmodel.finalpayment(
                                    amount:
                                        widget.responcemodel.amount.toString(),
                                    imei: identifier,
                                    total: widget.responcemodel.totalAmount
                                        .toString(),
                                    serviceid: widget.service.id,
                                    id: widget.responcemodel.id,
                                    parameters: output);
                            obj.payment(objectmodel, context).then((value2) {
                             
                              if (value2['status'] == true) {
//get fatora
                                Data paymentformat =
                                    Data.fromJson((value2['data']));

                                // check notification

                                NotificationApi()
                                    .checkinvoice(
                                        widget.service.id,
                                        paymentformat.clientNumber.toString(),
                                        context)
                                    .then((value3) {
                                  if (value3['status'] == true) {
                                    print(value3);
                                    EasyLoading.dismiss();
                                    DailogAlert.opennotifyAlert(
                                      translator.currentLanguage == 'en'
                      ? "Alert":"تنبيه",
                                     translator.currentLanguage == 'en'?  "Are you want add this service to reminder":"هل تريد اضافه الخدمه لتذكيرك في وقتها ؟",
                                        context,
                                        widget.service.id!,
                                        paymentformat.clientNumber.toString(),
                                        paymentformat,
                                        widget.service.type!);
                                  } else {
                                    //get fatora
                                    EasyLoading.dismiss();
                                    Get.off(fatora_details(
                                      bluknumber: 0,
                                      isbluck: false,
                                      paymentobject: paymentformat,
                                      servicetype: widget.service.type!,
                                    ));
                                  }
                                });
                              } else {
//print message
                                EasyLoading.dismiss();

                                DailogAlert.openback2Alert(
                                    "${value2['message']}",
                                    translator.translate("fail"),
                                    context);
                              }
                            });
                          }
                        },
                        color: CustomColors.MainColor,
                        // ignore: sort_child_properties_last
                        child: const Text(
                          "OK",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  getboolenvalue() {
    for (var item in widget.parameters) {
      if (item.type == 1) {
        if (item.required == 1 && onecontroller.text.isEmpty) {
          DailogAlert.openbackAlert(translator.translate('empty'),
              translator.translate("failedmessage"), context);
          shouldBreak = true;
        } else if (onecontroller.text.trim().length < item.min_length! ||
            onecontroller.text.trim().length > item.max_length!) {
          if (item.min_length == item.max_length) {
            //  DailogAlert.openbackAlert( "الحقل فارغ!", "فشل", context);
          } else {
            //    DailogAlert.openbackAlert( "الحقل فارغ!", "فشل", context);
          }
          shouldBreak = true;
        }
        amountfromtypes['key'] = item.internal_id;
        amountfromtypes['value'] = onecontroller.text;
        output.add({'key': item.internal_id, 'value': onecontroller.text});
      } else if (item.type == 2) {
        if (item.required == 1 && twocontroller.text.isEmpty) {
          DailogAlert.openbackAlert(translator.translate('empty'),
              translator.translate("failedmessage"), context);
          shouldBreak = true;
        }
        amountfromtypes['key'] = item.internal_id;
        amountfromtypes['value'] = twocontroller.text;
        output.add({'key': item.internal_id, 'value': twocontroller.text});
      } else if (item.type == 3) {
        if (item.required == 1 && threecontroller.text.isEmpty) {
          DailogAlert.openbackAlert(translator.translate('empty'),
              translator.translate("failedmessage"), context);
          shouldBreak = true;
        }
        amountfromtypes['key'] = item.internal_id;
        amountfromtypes['value'] = fourcontroller.text;
        output.add({'key': item.internal_id, 'value': threecontroller.text});
      } else if (item.type == 4) {
        if (item.required == 1 && fourcontroller.text.isEmpty) {
          DailogAlert.openbackAlert(translator.translate('empty'),
              translator.translate("failedmessage"), context);
          shouldBreak = true;
        }
        amountfromtypes['key'] = item.internal_id;
        amountfromtypes['value'] = fourcontroller.text;
        output.add({'key': item.internal_id, 'value': fourcontroller.text});
      } else if (item.type == 5) {
        if (item.required == 1) {
          if (_category == "") {
            DailogAlert.openbackAlert(translator.translate('empty'),
                translator.translate("failedmessage"), context);
            shouldBreak = true;
          } else {
            amountfromtypes['key'] = item.internal_id;
            amountfromtypes['value'] = getvaluefromdatatypes(
                setdropdownvalues(item.internal_id, item), item);
            output.add({
              'key': item.internal_id,
              'value': getvaluefromdatatypes(
                  setdropdownvalues(item.internal_id, item), item)
            });
          }
        }
      } else if (item.type == 6) {
        if (item.required == 1) {
          if (amountselect == "") {
            DailogAlert.openbackAlert(translator.translate('empty'),
                translator.translate("failedmessage"), context);
            shouldBreak = true;
          } else {
            amountfromtypes['key'] = item.internal_id;
            amountfromtypes['value'] =
                getvaluefromdatatypes(amountselect!, item);
            output.add({
              'key': item.internal_id,
              'value': getvaluefromdatatypes(amountselect!, item)
            });
          }
        }
      }
      if (shouldBreak) {
        return false;
      }
    }
    return true;
  }

  // ignore: prefer_typing_uninitialized_variables
  var valuetypes;
  getvaluefromdatatypes(String name, parameters item) {
    values.forEach((key, val) {
      if (name == key) {
        valuetypes = (values[key]);
      }
    });

    return valuetypes;
  }
}
// question
/* 
   {status: false, code: 880013, message: Unable to get inquiry, data: {id: 1047167, integration_provider: {id: 6, name: Fawry, description: null}, service: {id: 3756, name: فواتير وى انترنت, description: null, footer_description: null, powered_by: null, type: 2, provider: {id: 6, name: WE home internet, description: null, logo: service-provider/2021/12/14/y6q3dNGNTJBoUwYWhL8NblFgQYI3gTDwsZClXhzW.jpeg}, category: {id: 2, name: DSL Bills, description: null, icon: service-category/2021/12/14/8mhmLXHlu0eubzsikbu79LpBAbgosNHdROQMzjiW.jpeg}}, merchant: {id: 934, store_name: رنا, name: رنا}, type: 2, inquiry_transaction_id: null, external_transaction_id: null, status: 3, status_code: 880013, message: Unable to get inquiry, client_number: 0572367291, amount: 115.5, service_charge: null, total_amount: null, paid_amount: null, min_amount: null, max_amount: null, is_paid: null, provider_transaction_id: null, integration_provider_amount: null, integration_provider_balance: null, integration_provider_co

   3-totalamountprojmodel.amount ????????? toyalamountprojmodel.params
   1-key of daaentity id
   2-paramsArrayListToSend.add(
                                    TotalAmountPojoModel.Params(
                                        internalId,
                                        values[iii].id
                                    ) 
                                    ليه بيضيفها تاني 
                                    يعني هاخد دي ولا الي بعتها و امونت هاخد انهي 
                                    
                                    
                                             val paymentPojoModel = PaymentPojoModel("76e755047ea7a63f","",
                                            totalAmountPojoModel.serviceId,totalAmountPojoModel.amount,
                                            DATA_ENTITY!!.id.toString(),"", PAYMENTPOJOMODEL!!.params)

                                    */
