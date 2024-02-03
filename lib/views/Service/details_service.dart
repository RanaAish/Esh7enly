// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types, prefer_collection_literals, unused_field, deprecated_member_use, prefer_const_constructors, avoid_unnecessary_containers, use_build_context_synchronously, sort_child_properties_last, prefer_if_null_operators
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:esh7enly/Services/features/Notification.dart';
import 'package:esh7enly/Services/features/ServiceApi.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:esh7enly/models/inquiryobject.dart';
import 'package:esh7enly/models/parameters.dart';
import 'package:esh7enly/views/Service/Fatora_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'dart:async';
//import 'package:flutter/services.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:unique_identifier/unique_identifier.dart';
import '../../core/utils/colors.dart';
import '../../core/widgets/CustomTextField.dart';
import '../../db/imagesdb.dart';
import '../../db/servicedb.dart';
import '../../models/Image.dart';
import '../../models/TotalAmounts.dart';
import '../../models/payment.dart';
import '../../models/services.dart';
import 'detailsinquiry.dart';

//import 'package:flutter/foundation.dart';

class detailsservice extends StatefulWidget {
  final serviceid,
      image,
      providername,
      servicename,
      servicetype,
      acceptampount,
      pricevalue,
      pricetype;
  final Services service;

  const detailsservice(
      {Key? key,
      this.image,
      this.pricetype,
      this.pricevalue,
      this.serviceid,
      required this.service,
      this.servicename,
      this.servicetype,
      this.acceptampount,
      this.providername})
      : super(key: key);

  @override
  State<detailsservice> createState() => _detailsserviceState();
}

class _detailsserviceState extends State<detailsservice> {
  //radiobuttun
  String? amountselect;
  late var quantitycontroller = TextEditingController();
  // dropdown
  var _category;
  var categories = ['o'];
  bool shouldBreak = false;
  serviceApi service = serviceApi();
  List<Map> output = [];
  Map amountfromtypes = Map();
  late List<parameters> lists = [];
  late List<parameters> listsfordetailsinquiry = [];
  late List<Imageparameters> listofimages = [];
  DateTime datetime = DateTime.now();
  late var amountcontroller = TextEditingController();
  late var onecontroller = TextEditingController();
  late var twocontroller = TextEditingController();
  late var threecontroller = TextEditingController();
  late var fourcontroller = TextEditingController();
  String? namedropdown;
  var valuetyped;

  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  Contact? _contact;
  String? selectedNumber;
  var myControllers = [];
  createControllers(int len) {
    for (var i = 0; i < len; i++) {
      myControllers.add(TextEditingController());
    }
  }

  List electricids = [
    3683,
    3702,
    3703,
    3704,
    3705,
    3706,
    3707,
    3708,
    3709,
    3697,
    3851,
    4062.4064,
    4065
  ];
  Future readallimages() async {
    await ImageDatabase.instance.readAllimages().then((value) {
      setState(() {
        listofimages = value
            .where((element) => element.service_id == widget.serviceid)
            .toList();
      });
    });
  }

  Future readparameters() async {
    //print(widget.serviceid);
    //this.lists = await ProviderDatabase.instance.readAllNotes();
    await ServiceDatabase.instance.readAllparameters().then((value) {
      setState(() {
        listsfordetailsinquiry = value
            .where((element) =>
                element.service_id == widget.serviceid &&
                (element.display == 1 || element.display == 3))
            .toList();
        if (widget.servicetype == 1) {
          lists = value
              .where((element) =>
                  element.service_id == widget.serviceid &&
                  (element.display == 1 || element.display == 3))
              .toList();
        }
        if (widget.servicetype == 2) {
          lists = value
              .where((element) =>
                  element.service_id == widget.serviceid &&
                  (element.display == 1 || element.display == 2))
              .toList();
        }
      });
      for (var object in lists) {
        if (object.type == 5) {
          addtypevalues(object);
        }
      }
      // print(lists[1]);
    });
  }

/*
  Future readparameters() async {
    //print(widget.serviceid);
    //this.lists = await ProviderDatabase.instance.readAllNotes();
    await ServiceDatabase.instance.readAllparameters().then((value) {
      setState(() {
       
           listsfordetailsinquiry = value
            .where((element) =>
                element.service_id == widget.serviceid &&
                (element.display == 1 || element.display == 3))
            .toList();
        
       
         lists = value
            .where((element) =>
                element.service_id == widget.serviceid &&
                (element.display == 1 || element.display == 2))
            .toList();
       
      });
      for (var object in lists) {
        if (object.type == 5) {
          addtypevalues(object);
        }
      }
      // print(lists[1]);
      print(widget.servicetype);
    });
*/
  @override
  void initState() {
    readparameters();
    readallimages();

    super.initState();
  }

  addtypevalues(parameters item) {
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
      setState(() {
        if (translator.currentLanguage == 'ar') {
          categories.add(data[" name_ar"]);
        } else {
          categories.add(data[" name_en"]);
        }
      });
    }
  }

  var valuetypes;
  getvaluefromdatatypes(String name, parameters item) {
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
      setState(() {
        if (name.trim() == data[" name_ar"].trim()) {
          namedropdown = data[" name_ar"];
          valuetypes = (data['value'].trim());
        }
        //  categories.add(data[" name_ar"]);
      });
    }
    return valuetypes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                            padding:
                                EdgeInsets.only(right: 30, left: 30, top: 30),
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
                              SizedBox(
                                  width: 268,
                                  child: Text('    ${widget.servicename}',
                                      softWrap: false,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'ReadexPro',
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                            ])))),
                SizedBox(
                  height: 120,
                ),
                SizedBox(
                    width: 440,
                    //height: 340, // default   185  // one text field:255
                    child: Padding(
                        padding:
                            EdgeInsets.only(top: 9, right: 20, left: 25),
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
                                        right: 20,
                                        left: 20,
                                        bottom: 7),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 0,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  right: 0, left: 0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(widget.servicename,
                                                        style: const TextStyle(
                                                            color: CustomColors
                                                                .MainColor,
                                                            fontSize: 15)),
                                                    Container(
                                                      width: 68,
                                                      height: 46,
                                                      color: Colors.white,
                                                      child: widget
                                                              .image.isEmpty
                                                          ? Image.asset(
                                                              'assets/logo.png')
                                                          : CachedNetworkImage(
                                                              imageUrl:
                                                                  "https://e-esh7nly.org/storage/${widget.image}",
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
                                                  ])),
                                          //  "${widget.providername}(${widget.servicename})",
                                          Text(
                                            "${widget.servicename}",
                                            style: TextStyle(
                                                color: CustomColors.MainColor,
                                                fontSize: 15),
                                          ),

                                          listofimages.isNotEmpty
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: CarouselSlider(
                                                    options: CarouselOptions(),
                                                    items: listofimages
                                                        .map(
                                                            (item) => Container(
                                                                  child: Center(
                                                                      child: Image.network(
                                                                          "https://e-esh7nly.org/storage/${item.path}",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          width:
                                                                              70)),//300
                                                                ))
                                                        .toList(),
                                                  ))
                                              : SizedBox(height: 0),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          electricids.contains(widget.serviceid)
                                              ? const Text(" electric ")
                                              : SizedBox(
                                                  //    250 type ==4 160 280
                                                  height: double.parse(//78
                                                      (78 * (lists.length))
                                                          .toString()),
                                                  child: ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount: lists.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        createControllers(
                                                            lists.length);
                                                        return SizedBox(
                                                            child: lists[index]
                                                                        .type ==
                                                                    1
                                                                ? layoutone(
                                                                    context,
                                                                    lists[
                                                                        index],
                                                                    index)
                                                                : lists[index]
                                                                            .type ==
                                                                        2
                                                                    ? layouttwo(
                                                                        context,
                                                                        lists[
                                                                            index],
                                                                        index)
                                                                    : lists[index].type ==
                                                                            3
                                                                        ? layoutthree(
                                                                            context,
                                                                            lists[
                                                                                index],
                                                                            index)
                                                                        : lists[index].type ==
                                                                                4
                                                                            ? layoutfour(
                                                                                context,
                                                                                lists[index],
                                                                                index)
                                                                            : lists[index].type == 5
                                                                                ? layoutfive(context, lists[index], index)
                                                                                : layoutsix(context, lists[index], index));
                                                      })),
                                          widget.acceptampount == 1
                                              ? layoutamount(context)
                                              : SizedBox(
                                                  height: 0,
                                                ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              EasyLoading.show(
                                                  status: translator
                                                              .currentLanguage ==
                                                          'ar'
                                                      ? 'جاري التحميل '
                                                      : 'loading...',
                                                  maskType: EasyLoadingMaskType
                                                      .black);
                                              await onpressbuttun();
                                            },
                                            child: Container(
                                              height: 39,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              decoration: BoxDecoration(
                                                color: CustomColors.MainColor,
                                                borderRadius:
                                                    BorderRadius.circular(1),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  widget.servicetype == 2
                                                      ? translator.currentLanguage ==
                                                              'en'
                                                          ? "INQUIRY"
                                                          : "استعلام"
                                                      : translator.currentLanguage ==
                                                              'en'
                                                          ? "PAY"
                                                          : 'دفع',
                                                  style: const TextStyle(
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
                                        ]))))))
              ]),
            )));
  }

  Widget layoutone(BuildContext context, parameters item, int index) {
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
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
            Padding(
                padding: EdgeInsets.only(
                  top: 5,
                ),
                child: SizedBox(
                  height: 40,
                  child: CustomTextField(
                      hint: translator.currentLanguage == 'ar'
                          ? item.name_ar
                          : '${item.name_en}',
                      suffic: item.is_client_number == 1
                          ? IconButton(
                              icon: Icon(Icons.account_box),
                              onPressed: () async {
                                //final status = Permission.contacts.request();
                                //launchContacts();

                                _askPermissions('/contactsList');
                              })
                          : null,
                      changed: (var value) async {
                        if (value.isEmpty) {
                          valuetyped = null;
                        } else {
                          valuetyped = value;
                        }
                      },
                      OnTab: () {
                        //convert text to enghish numbers
                      },
                      type: TextInputType.number,
                      dense: false,
                      controller: myControllers[index],
                      Padding: EdgeInsets.only(
                          right: 16, top: 0, bottom: 0, left: 16)),
                )),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }

  Future<void> _askPermissions(String routeName) async {
    //

    PermissionStatus permissionStatus = await _getContactPermission();

    if (permissionStatus == PermissionStatus.granted) {
      Contact? contact = await _contactPicker.selectContact();
      if (contact != null) {
        setState(() async {
          _contact = contact;
          List<String>? phoneNumbers = contact.phoneNumbers;
          selectedNumber = phoneNumbers?[0] ?? '';

          onecontroller.text = selectedNumber ?? '';
        });
      }
    }
    /* } else {
      _handleInvalidPermissions(permissionStatus);
    } */
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Widget layouttwo(BuildContext context, parameters item, int index) {
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
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 40,
                  child: CustomTextField(
                      hint: translator.currentLanguage == 'ar'
                          ? item.name_ar
                          : item.name_en,
                      OnTab: () {},
                      dense: false,
                      controller: myControllers[index],
                      Padding: EdgeInsets.only(
                          right: 16, top: 0, bottom: 0, left: 16)),
                )),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }

  Widget layoutthree(BuildContext context, parameters item, int index) {
    print(index);
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
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 40,
                  child: CustomTextField(
                      hint: translator.currentLanguage == 'ar'
                          ? item.name_ar
                          : item.name_en,
                      OnTab: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: datetime,
                            firstDate: DateTime(1800),
                            lastDate: DateTime(2500));
                        if (newDate == null) return;
                        myControllers[index].text =
                            "${newDate.year}-${newDate.month}-${newDate.day}";
                      },
                      dense: false,
                      controller: myControllers[index],
                      Padding: EdgeInsets.only(
                          right: 16, top: 0, bottom: 0, left: 16)),
                )),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }

  Widget layoutfour(BuildContext context, parameters item, int index) {
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
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 70,
                  child: CustomTextField(
                      hint: translator.currentLanguage == 'ar'
                          ? item.name_ar
                          : item.name_en,
                      OnTab: () async {},
                      dense: false,
                      lines: 4,
                      controller: myControllers[index],
                      Padding: EdgeInsets.only(
                          right: 16, top: 0, bottom: 0, left: 16)),
                )),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }

  Widget layoutfive(BuildContext context, parameters item, int index) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  'الفتره',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 40,
                  child: createdropdown(item),
                )),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }

  /*void launchContacts() async {
    
    print("iii");
    try {
      await platform.invokeMethod('launch');
    } on PlatformException catch (e) {
      print("Failed to launch contacts: ${e.message}");
    }
    setState(() {});
  } */
  void launchContacts() async {
    // const platform = const MethodChannel('flutter_contacts/launch_contacts');
    final MethodChannel channel =
        const MethodChannel('flutter_contacts/launch_contacts')
          ..setMethodCallHandler((MethodCall call) async {});

    try {
      await channel.invokeMethod('launch');
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Failed to launch contacts: ${e.message}");
    }
    setState(() {});
  }

  Widget layoutsix(BuildContext context, parameters item, int index) {
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
                        title: Text(categories[index]),
                        value: categories[index],
                        groupValue: amountselect,
                        onChanged: (value) {
                          setState(() {
                            amountselect = value.toString();
                          });
                        },
                      );
                    }))));
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
                  "Amount",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 40,
                  child: CustomTextField(
                      hint: "Amount",
                      OnTab: () {},
                      dense: false,
                      controller: amountcontroller,
                      Padding: EdgeInsets.only(
                          right: 16, top: 0, bottom: 0, left: 16)),
                )),
          ],
        ));
  }

  getamount() {
    var amount = "";
    if (electricids.contains(widget.serviceid)) {
    } else {
      if (widget.acceptampount == 1) {
        amount = amountcontroller.text;
      } else if (widget.pricetype == 2) {
        amount = widget.pricevalue;
      }
    }
    return amount;
  }

  onpressbuttun() async {
    amountfromtypes.clear();
    output.clear();
    var amount = getamount();
    shouldBreak = false;

    String? identifier = await UniqueIdentifier.serial;
    if (getboolenvalue()) {
      if (widget.servicetype == 1) // pay
      {
        // output.add(amountfromtypes);
        print(amountfromtypes);
        totalamounts object = totalamounts.pareameters(
            imei: identifier,
            serviceid: widget.serviceid,
            pricevalue: amount,
            parameters: output);
        // output.add(amountmap);

        service.getamounts(object, context).then((value) {
          if (value["data"]["status"] == true) {
            EasyLoading.dismiss();

            openAlert(value['data']["amount"].toString(),
                value['data']["total_amount"].toString());
          } else {
            EasyLoading.dismiss();
            DailogAlert.openbackAlert("${value['message']}",
                translator.translate("failedmessage"), context);
          }
        });
      } else {
        //output.add(amountfromtypes);
        print(output);
        service
            .inquire(identifier, widget.serviceid, amount, output, context)
            .then((value) {
          print(value);
          if (value["status"] == true) {
            //gettoscreen

            Data inquiryformat = Data.fromJson((value['data']));
            EasyLoading.dismiss();
            Get.to(Detailsinquiry(
              parameters: listsfordetailsinquiry,
              providername: widget.providername,
              responcemodel: inquiryformat,
              service: widget.service,
              arraytosend: output,
            ));
          } else {
            EasyLoading.dismiss();
            DailogAlert.openbackAlert("${value['message']}",
                translator.translate("failedmessage"), context);
          }
        });
      }
    }
  }

  getboolenvalue() {
    int i = 0;
    for (var item in lists) {
      print(i);
      if (item.type == 1) {
        if (item.required == 1 && valuetyped == null) {
          DailogAlert.openbackAlert(translator.translate('empty'),
              translator.translate("failedmessage"), context);

          shouldBreak = true;
        } else if (valuetyped.trim().length < item.min_length! ||
            valuetyped.trim().length > item.max_length!) {
          if (item.min_length == item.max_length) {
            //    DailogAlert.openbackAlert("الحقل فارغ!", "فشل", context);
          } else {
            //    DailogAlert.openbackAlert( "الحقل فارغ!", "فشل", context);
          }
          shouldBreak = true;
        }
        amountfromtypes['key'] = item.internal_id;
        amountfromtypes['value'] = myControllers[i];
        output.add({'key': item.internal_id, 'value': myControllers[i].text});
      } else if (item.type == 2) {
        if (item.required == 1 && myControllers[i].text.isEmpty) {
          DailogAlert.openbackAlert(translator.translate('empty'),
              translator.translate("failedmessage"), context);
          shouldBreak = true;
        }
        amountfromtypes['key'] = item.internal_id;
        amountfromtypes['value'] = myControllers[i].text;

        output.add({'key': item.internal_id, 'value': myControllers[i].text});
      } else if (item.type == 3) {
        if (item.required == 1 && myControllers[i].text.isEmpty) {
          DailogAlert.openbackAlert(translator.translate('empty'),
              translator.translate("failedmessage"), context);
          shouldBreak = true;
        }
        amountfromtypes['key'] = item.internal_id;
        amountfromtypes['value'] = myControllers[i].text;
        output.add({'key': item.internal_id, 'value': myControllers[i].text});
      } else if (item.type == 4) {
        if (item.required == 1 && myControllers[i].text.isEmpty) {
          DailogAlert.openbackAlert(translator.translate('empty'),
              translator.translate("failedmessage"), context);
          shouldBreak = true;
        }
        amountfromtypes['key'] = item.internal_id;
        amountfromtypes['value'] = myControllers[i].text;
        output.add({'key': item.internal_id, 'value': myControllers[i].text});
      } else if (item.type == 5) {
        if (item.required == 1) {
          if (_category.isEmpty) {
            DailogAlert.openbackAlert(translator.translate('empty'),
                translator.translate("failedmessage"), context);
            shouldBreak = true;
          } else {
            amountfromtypes['key'] = item.internal_id.toString();
            amountfromtypes['value'] =
                getvaluefromdatatypes(_category, item).toString();
            output.add({
              'key': item.internal_id,
              'value': getvaluefromdatatypes(_category, item).toString()
            });
          }
        }
        //
      } else if (item.type == 6) {
        if (item.required == 1) {
          if (amountselect!.isEmpty) {
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
        EasyLoading.dismiss();
        return false;
      }
      i = i + 1;
    }

    return true;
  }

  createdropdown(parameters item) {
    categories.remove('o');
    return DropdownButtonFormField(
      value: _category,
      onChanged: (newValue) {
        setState(() {
          _category = newValue;
        });
      },
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
          child: Center(child: Text(category)),
        );
      }).toList(),
      isExpanded: true,
      hint: Center(child: Text(item.name_ar!)),
      decoration: InputDecoration(
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
        hintText: item.name_ar,
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

  /* askPermission() async {
    PermissionStatus status = await Permission.contacts.request();
    if (status.isDenied == true) {
      askPermission();
    } else {
      return true;
    }
  } */

  /* Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  } */

  void openAlert(String amount, String totalamount) {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: SizedBox(
        height: 230.0,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 16),
          //   decoration: boxDecorationStylealert,
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 24),
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(translator.translate("confirm"),
                    style:
                        TextStyle(fontSize: 20, color: CustomColors.MainColor)),
              ),
              SizedBox(
                height: 18,
              ),
              Center(
                child: Text(
                  "${translator.translate("amunt")}: ${amount.toString()} EGp",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: CustomColors.MainColor),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                    "${translator.translate("totalamount")}: ${totalamount.toString()} EGp ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: CustomColors.MainColor)),
              ),
              SizedBox(
                height: 25,
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
                        child: Text(
                          translator.translate("cancel"),
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
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
                          String? identifier = await UniqueIdentifier.serial;
                          paymentmodel objectmodel = paymentmodel.pareameters(
                              amount: amount,
                              imei: identifier,
                              total: totalamount,
                              serviceid: widget.serviceid,
                              parameters: output);

                          service.payment(objectmodel, context).then((value) {
                            if (value['status'] == true) {
                              Data paymentformat = Data.fromJson(value['data']);
                              print('yyy${paymentformat.clientNumber}');
                              NotificationApi()
                                  .checkinvoice(
                                      widget.service.id,
                                      paymentformat.clientNumber
                                          .toString(), // int.parse
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
                                      paymentformat.clientNumber,
                                      paymentformat,
                                      widget.service.type!);
                                } else {
                                  EasyLoading.dismiss();
                                  Get.off(fatora_details(
                                    bluknumber: 0,
                                    isbluck: false,
                                    paymentobject: paymentformat,
                                    servicetype: widget.servicetype,
                                  ));
                                }
                              });
                            } else {
                              EasyLoading.dismiss();
                              DailogAlert.openbackAlert(
                                  "${value['message']}",
                                  translator.translate("failedmessage"),
                                  context);
                            }
                          });
                        },
                        color: CustomColors.MainColor,
                        child: Text(
                          translator.translate("ok"),
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
/*final  layout  class _detailsserviceState extends State<detailsservice> {
  //radiobuttun
  String? amountselect;
  late var quantitycontroller = TextEditingController();
  // dropdown
  var _category;
  var categories = ['o'];
  bool shouldBreak = false;
  serviceApi service = serviceApi();
  List<Map> output = [];
  Map amountfromtypes = Map();
  late List<parameters> lists = [];
  late List<parameters> listsfordetailsinquiry = [];
  late List<Imageparameters> listofimages = [];
  DateTime datetime = DateTime.now();
  late var amountcontroller = TextEditingController();
  late var onecontroller = TextEditingController();
  late var twocontroller = TextEditingController();
  late var threecontroller = TextEditingController();
  late var fourcontroller = TextEditingController();
  String? namedropdown;
  var valuetyped;

  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  Contact? _contact;
  String? selectedNumber;

  List electricids = [
    3683,
    3702,
    3703,
    3704,
    3705,
    3706,
    3707,
    3708,
    3709,
    3697,
    3851,
    4062.4064,
    4065
  ];
  Future readallimages() async {
    await ImageDatabase.instance.readAllimages().then((value) {
      setState(() {
        listofimages = value
            .where((element) => element.service_id == widget.serviceid)
            .toList();
      });
    });
  }

  Future readparameters() async {
    //print(widget.serviceid);
    //this.lists = await ProviderDatabase.instance.readAllNotes();
    await ServiceDatabase.instance.readAllparameters().then((value) {
      setState(() {
         listsfordetailsinquiry = value
            .where((element) =>
                element.service_id == widget.serviceid &&
                (element.display == 1 || element.display == 3))
            .toList();
        if (widget.servicetype == 1) {
          lists = value
              .where((element) =>
                  element.service_id == widget.serviceid &&
                  (element.display == 1 || element.display == 3))
              .toList();
        }
        if (widget.servicetype == 2) {
          lists = value
              .where((element) =>
                  element.service_id == widget.serviceid &&
                  (element.display == 1 || element.display == 2))
              .toList();
        }
      });
      for (var object in lists) {
        if (object.type == 5) {
          addtypevalues(object);
        }
      }
      // print(lists[1]);
    });
  }

/*
  Future readparameters() async {
    //print(widget.serviceid);
    //this.lists = await ProviderDatabase.instance.readAllNotes();
    await ServiceDatabase.instance.readAllparameters().then((value) {
      setState(() {
       
           listsfordetailsinquiry = value
            .where((element) =>
                element.service_id == widget.serviceid &&
                (element.display == 1 || element.display == 3))
            .toList();
        
       
         lists = value
            .where((element) =>
                element.service_id == widget.serviceid &&
                (element.display == 1 || element.display == 2))
            .toList();
       
      });
      for (var object in lists) {
        if (object.type == 5) {
          addtypevalues(object);
        }
      }
      // print(lists[1]);
      print(widget.servicetype);
    });
  } */
  @override
  void initState() {
    readparameters();
    readallimages();

    super.initState();
  }

  addtypevalues(parameters item) {
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
      setState(() {
        if (translator.currentLanguage == 'ar') {
          categories.add(data[" name_ar"]);
        } else {
          categories.add(data[" name_en"]);
        }
      });
    }
  }

  var valuetypes;
  getvaluefromdatatypes(String name, parameters item) {
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
      setState(() {
        if (name.trim() == data[" name_ar"].trim()) {
          namedropdown = data[" name_ar"];
          valuetypes = (data['value'].trim());
        }
        //  categories.add(data[" name_ar"]);
      });
    }
    return valuetypes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
             scrollDirection: Axis.vertical,
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
                    padding: EdgeInsets.only(right: 30, left: 30, top: 30),
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
                      SizedBox(
                                          width:288,child: Text('    ${widget.servicename}',  softWrap: false,
                                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'ReadexPro',
                            color: Colors.white,
                             overflow: TextOverflow.fade,
                                        
                          ))),
                    ])))),
        SizedBox(
          height: 120,
        ),
        SizedBox(
            width: 440,
            //height: 340, // default   185  // one text field:255
            child: Padding(
                padding: const EdgeInsets.only(top: 9, right: 20, left: 20),
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
                            padding: const EdgeInsets.only(
                                top: 20, right: 20, left: 20, bottom: 7),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(widget.servicename,
                                            style: const TextStyle(
                                                color: CustomColors.MainColor,
                                                fontSize: 16)),
                                        Container(
                                          width: 70,
                                          height: 46,
                                          color: Colors.white,
                                          child: widget.image.isEmpty
                                              ? Image.asset('assets/logo.png')
                                              : CachedNetworkImage(
                                                  imageUrl:
                                                      "https://e-esh7nly.org/storage/${widget.image}",
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child: Image.asset(
                                                        'assets/logo.png'),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          'assets/logo.png'),
                                                ),
                                        ),
                                      ]),
                                  Text(
                                    "${widget.providername}(${widget.servicename})",
                                    style: TextStyle(
                                        color: CustomColors.MainColor,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  listofimages.isNotEmpty
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: CarouselSlider(
                                            options: CarouselOptions(),
                                            items: listofimages
                                                .map((item) => Container(
                                                      child: Center(
                                                          child: Image.network(
                                                              "https://e-esh7nly.org/storage/${item.path}",
                                                              fit: BoxFit.cover,
                                                              width: 300)),
                                                    ))
                                                .toList(),
                                          ))
                                      : SizedBox(height: 0),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  electricids.contains(widget.serviceid)
                                      ? const Text(" electric ")
                                      : SizedBox(
                                          //    250 type ==4 160 280
                                          height: double.parse(    //78
                                              (88 * (lists.length)).toString()),
                                          child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.vertical,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: lists.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SizedBox(
                                                    child: lists[index].type ==
                                                            1
                                                        ? layoutone(context,
                                                            lists[index])
                                                        : lists[index].type == 2
                                                            ? layouttwo(context,
                                                                lists[index])
                                                            : lists[index]
                                                                        .type ==
                                                                    3
                                                                ? layoutthree(
                                                                    context,
                                                                    lists[
                                                                        index])
                                                                : lists[index]
                                                                            .type ==
                                                                        4
                                                                    ? layoutfour(
                                                                        context,
                                                                        lists[
                                                                            index])
                                                                    : lists[index].type ==
                                                                            5
                                                                        ? layoutfive(
                                                                            context,
                                                                            lists[
                                                                                index])
                                                                        : layoutsix(
                                                                            context,
                                                                            lists[index]));
                                              })),
                                  widget.acceptampount == 1
                                      ? layoutamount(context)
                                      : SizedBox(
                                          height: 0,
                                        ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      EasyLoading.show(
                                          status:
                                              translator.currentLanguage == 'ar'
                                                  ? 'جاري التحميل '
                                                  : 'loading...',
                                          maskType: EasyLoadingMaskType.black);
                                      await onpressbuttun();
                                    },
                                    child: Container(
                                      height: 39,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      decoration: BoxDecoration(
                                        color: CustomColors.MainColor,
                                        borderRadius: BorderRadius.circular(1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          widget.servicetype == 2
                                              ? translator.currentLanguage ==
                                                      'en'
                                                  ? "INQUIRY"
                                                  : "استعلام"
                                              : translator.currentLanguage ==
                                                      'en'
                                                  ? "PAY"
                                                  : 'دفع',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ]))))))
      ]),
    )));
  }

  Widget layoutone(BuildContext context, parameters item) {
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
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
            Padding(
                padding: EdgeInsets.only(
                  top: 5,
                ),
                child: SizedBox(
                  height: 40,
                  child: CustomTextField(
                      hint: translator.currentLanguage == 'ar'
                          ? item.name_ar
                          : '${item.name_en}',
                      suffic: item.is_client_number == 1
                          ? IconButton(
                              icon: Icon(Icons.account_box),
                              onPressed: () async {
                                //final status = Permission.contacts.request();
                                //launchContacts();

                                _askPermissions('/contactsList');

                                //_getContactPermission();
                                /* onecontroller.value = TextEditingValue(
                                  text: selectedNumber ?? '',
                                  selection: TextSelection.fromPosition(
                                    TextPosition(
                                        offset: selectedNumber!.length),
                                  ),
                                ); */
                              }
                              /* 
                              launchContacts()
                              Contact contact = await contactPicker.selectContact();
                             if(contact != null){
                                number = contact.phoneNumber.number;
                                name = contact.fullName;
                                setState(() {
                                  
                                });
                             } await platform.invokeMethod('launch');
                                bool isShown = await Permission
                                    .contacts.shouldShowRequestRationale;
                                askPermission();
                                // Get all contacts
                                if (await Permission
                                    .speech.isPermanentlyDenied) {
                                  // The user opted to never again see the permission request dialog for this
                                  // app. The only way to change the permission's status now is to let the
                                  // user manually enable it in the system settings.
                                  openAppSettings(); }*/
                              )
                          : null,
                      changed: (var value) async {
                        if (value.isEmpty) {
                          valuetyped = null;
                        } else {
                          valuetyped = value;
                        }
                      },
                      OnTab: () {
                        //convert text to enghish numbers
                      },
                      type: TextInputType.number,
                      dense: false,
                      controller: onecontroller,
                      Padding: const EdgeInsets.only(
                          right: 16, top: 0, bottom: 0, left: 16)),
                )),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }

  Future<void> _askPermissions(String routeName) async {
    //

    PermissionStatus permissionStatus = await _getContactPermission();

    if (permissionStatus == PermissionStatus.granted) {
      Contact? contact = await _contactPicker.selectContact();
      if (contact != null) {
        setState(() async {
          _contact = contact;
          List<String>? phoneNumbers = contact.phoneNumbers;
          selectedNumber = phoneNumbers?[0] ?? '';

          onecontroller.text = selectedNumber ?? '';
        });
      }
    }
    /* } else {
      _handleInvalidPermissions(permissionStatus);
    } */
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Widget layouttwo(BuildContext context, parameters item) {
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
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 40,
                  child: CustomTextField(
                      hint: translator.currentLanguage == 'ar'
                          ? item.name_ar
                          : item.name_en,
                      OnTab: () {},
                      dense: false,
                      controller: twocontroller,
                      Padding: const EdgeInsets.only(
                          right: 16, top: 0, bottom: 0, left: 16)),
                )),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }

  Widget layoutthree(BuildContext context, parameters item) {
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
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 40,
                  child: CustomTextField(
                      hint: translator.currentLanguage == 'ar'
                          ? item.name_ar
                          : item.name_en,
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
                      controller: threecontroller,
                      Padding: const EdgeInsets.only(
                          right: 16, top: 0, bottom: 0, left: 16)),
                )),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }

  Widget layoutfour(BuildContext context, parameters item) {
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
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 70,
                  child: CustomTextField(
                      hint: translator.currentLanguage == 'ar'
                          ? item.name_ar
                          : item.name_en,
                      OnTab: () async {},
                      dense: false,
                      lines: 4,
                      controller: datecontroller,
                      Padding: const EdgeInsets.only(
                          right: 16, top: 0, bottom: 0, left: 16)),
                )),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }

  Widget layoutfive(BuildContext context, parameters item) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  'الفتره',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 40,
                  child: createdropdown(item),
                )),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }

  /*void launchContacts() async {
    
    print("iii");
    try {
      await platform.invokeMethod('launch');
    } on PlatformException catch (e) {
      print("Failed to launch contacts: ${e.message}");
    }
    setState(() {});
  } */
  void launchContacts() async {
    // const platform = const MethodChannel('flutter_contacts/launch_contacts');
    final MethodChannel channel =
        const MethodChannel('flutter_contacts/launch_contacts')
          ..setMethodCallHandler((MethodCall call) async {});

    try {
      await channel.invokeMethod('launch');
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Failed to launch contacts: ${e.message}");
    }
    setState(() {});
  }

  Widget layoutsix(BuildContext context, parameters item) {
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
                        title: Text(categories[index]),
                        value: categories[index],
                        groupValue: amountselect,
                        onChanged: (value) {
                          setState(() {
                            amountselect = value.toString();
                          });
                        },
                      );
                    }))));
  }

  Widget layoutamount(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  "Amount",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 40,
                  child: CustomTextField(
                      hint: "Amount",
                      OnTab: () {},
                      dense: false,
                      controller: amountcontroller,
                      Padding: const EdgeInsets.only(
                          right: 16, top: 0, bottom: 0, left: 16)),
                )),
          ],
        ));
  }

  getamount() {
    var amount = "";
    if (electricids.contains(widget.serviceid)) {
    } else {
      if (widget.acceptampount == 1) {
        amount = amountcontroller.text;
      } else if (widget.pricetype == 2) {
        amount = widget.pricevalue;
      }
    }
    return amount;
  }

  onpressbuttun() async {
    amountfromtypes.clear();
    output.clear();
    var amount = getamount();
    shouldBreak = false;

    String? identifier = await UniqueIdentifier.serial;
    if (getboolenvalue()) {
      if (widget.servicetype == 1) // pay
      {
        // output.add(amountfromtypes);
        print(amountfromtypes);
        totalamounts object = totalamounts.pareameters(
            imei: identifier,
            serviceid: widget.serviceid,
            pricevalue: amount,
            parameters: output);
        // output.add(amountmap);

        service.getamounts(object, context).then((value) {
          if (value["data"]["status"] == true) {
            EasyLoading.dismiss();

            openAlert(value['data']["amount"].toString(),
                value['data']["total_amount"].toString());
          } else {
            EasyLoading.dismiss();
            DailogAlert.openbackAlert("${value['message']}",
                translator.translate("failedmessage"), context);
          }
        });
      } else {
        //output.add(amountfromtypes);
        print(output);
        service
            .inquire(identifier, widget.serviceid, amount, output, context)
            .then((value) {
          print(value);
          if (value["status"] == true) {
            //gettoscreen

            Data inquiryformat = Data.fromJson((value['data']));
            EasyLoading.dismiss();
            Get.to(Detailsinquiry(
              parameters: listsfordetailsinquiry,
              providername: widget.providername,
              responcemodel: inquiryformat,
              service: widget.service,
              arraytosend: output,
            ));
          } else {
            EasyLoading.dismiss();
            DailogAlert.openbackAlert("${value['message']}",
                translator.translate("failedmessage"), context);
          }
        });
      }
    }
  }

  getboolenvalue() {
    for (var item in lists) {
      if (item.type == 1) {
        if (item.required == 1 && valuetyped == null) {
          DailogAlert.openbackAlert(translator.translate('empty'),
              translator.translate("failedmessage"), context);

          shouldBreak = true;
        } else if (valuetyped.trim().length < item.min_length! ||
            valuetyped.trim().length > item.max_length!) {
          if (item.min_length == item.max_length) {
            //    DailogAlert.openbackAlert("الحقل فارغ!", "فشل", context);
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
        amountfromtypes['value'] = threecontroller.text;
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
          if (_category.isEmpty) {
            DailogAlert.openbackAlert(translator.translate('empty'),
                translator.translate("failedmessage"), context);
            shouldBreak = true;
          } else {
            amountfromtypes['key'] = item.internal_id.toString();
            amountfromtypes['value'] =
                getvaluefromdatatypes(_category, item).toString();
            output.add({
              'key': item.internal_id,
              'value': getvaluefromdatatypes(_category, item).toString()
            });
          }
        }
        //
      } else if (item.type == 6) {
        if (item.required == 1) {
          if (amountselect!.isEmpty) {
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
        EasyLoading.dismiss();
        return false;
      }
    }

    return true;
  }

  createdropdown(parameters item) {
    categories.remove('o');
    return DropdownButtonFormField(
      value: _category,
      onChanged: (newValue) {
        setState(() {
          _category = newValue;
        });
      },
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
          child: Center(child: Text(category)),
        );
      }).toList(),
      isExpanded: true,
      hint: Center(child: Text(item.name_ar!)),
      decoration: InputDecoration(
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
        hintText: item.name_ar,
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

  /* askPermission() async {
    PermissionStatus status = await Permission.contacts.request();
    if (status.isDenied == true) {
      askPermission();
    } else {
      return true;
    }
  } */

  /* Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  } */

  void openAlert(String amount, String totalamount) {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: SizedBox(
        height: 230.0,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 16),
          //   decoration: boxDecorationStylealert,
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 24),
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(translator.translate("confirm"),
                    style:
                        TextStyle(fontSize: 20, color: CustomColors.MainColor)),
              ),
              SizedBox(
                height: 18,
              ),
              Center(
                child: Text(
                  "${translator.translate("amunt")}: ${amount.toString()} EGp",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: CustomColors.MainColor),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                    "${translator.translate("totalamount")}: ${totalamount.toString()} EGp ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: CustomColors.MainColor)),
              ),
              SizedBox(
                height: 25,
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
                        child: Text(
                          translator.translate("cancel"),
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
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
                          String? identifier = await UniqueIdentifier.serial;
                          paymentmodel objectmodel = paymentmodel.pareameters(
                              amount: amount,
                              imei: identifier,
                              total: totalamount,
                              serviceid: widget.serviceid,
                              parameters: output);

                          service.payment(objectmodel, context).then((value) {
                            if (value['status'] == true) {
                              Data paymentformat = Data.fromJson(value['data']);
                              print('yyy${paymentformat.clientNumber}');
                              NotificationApi()
                                  .checkinvoice(
                                      widget.service.id,
                                      int.parse(paymentformat.clientNumber),
                                      context)
                                  .then((value3) {
                                if (value3['status'] == true) {
                                  EasyLoading.dismiss();
                                  DailogAlert.opennotifyAlert(
                                      "Sucess",
                                      "You need to add the service to notifications",
                                      context,
                                      widget.service.id!,
                                      paymentformat.clientNumber,
                                      paymentformat,
                                      widget.service.type!);
                                } else {
                                  EasyLoading.dismiss();
                                  Get.off(fatora_details(
                                    bluknumber: 0,
                                    isbluck: false,
                                    paymentobject: paymentformat,
                                    servicetype: widget.servicetype,
                                  ));
                                }
                              });
                            } else {
                              EasyLoading.dismiss();
                              DailogAlert.openbackAlert(
                                  "${value['message']}",
                                  translator.translate("failedmessage"),
                                  context);
                            }
                          });
                        },
                        color: CustomColors.MainColor,
                        child: Text(
                          translator.translate("ok"),
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
 */
/////////////final///////////////

/*{status: true, code: 0, message: It was completed, service_update_num: 39, data: {status: true, amount: 5, service_charge: 2.1500000000000004, total_amount: 7.15, paid_amount: 7.15, system: 0, agent: 0, merchant: 0, code: 0, message: null}} */

  /* void openAlertdailouge(String amount, String totalamount) {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: Container(
        height: 230.0,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 16),
          //   decoration: boxDecorationStylealert,
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 24),
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text("CONIRMATION !",
                    style: TextStyle(
                      fontSize: 19,
                    )),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Amount: ${amount.toString()}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              Text("Total Amount: ${totalamount.toString()}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              Divider(
                color: Color(0xFF898787),
              ),
              Center(
                child: Text("Quantity"),
              ),
              SizedBox(
                height: 9,
              ),
              CustomTextField(
                  hint: "1",
                  OnTab: () {},
                  dense: true,
                  controller: quantitycontroller,
                  Padding:
                      EdgeInsets.only(right: 15, top: 5, bottom: 5, left: 10)),
              /* TextFormField(
                controller: quantitycontroller,
                // initialValue: "1",
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: CustomColors.MainColor)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: Colors.black)),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10), //Change this value to custom as you like
                    isDense: true, // and add this line
                    hintText: quantitycontroller.text,
                    hintStyle: TextStyle(
                      color: Color(0xFFF00),
                    )),
                keyboardType: TextInputType.text,
                style: TextStyle(color: Color(0xFFF00), fontSize: 14),
                maxLines: 1,
              ), */
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
                        child: Text(
                          "CANCEL",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: MaterialButton(
                        onPressed: () async {
                          String? identifier = await UniqueIdentifier.serial;
                          paymentmodel objectmodel = paymentmodel.pareameters(
                              amount: amount,
                              imei: identifier,
                              total: totalamount,
                              serviceid: widget.serviceid,
                              parameters: output);
                          print(identifier);
                          service.payment(objectmodel, context).then((value) {
                            print(value['status']);
                            if (value['status'] == true) {
                              Get.snackbar(
                                  "تم نجاح العمليه", "${value['message']}");
                              Navigator.pop(context);
                            } else {
                              Get.snackbar(
                                  "فشلت العمليه", "${value['message']}");
                              Navigator.pop(context);
                            }
                          });
                        },
                        color: CustomColors.MainColor,
                        // ignore: sort_child_properties_last
                        child: Text(
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
  } */
  /*  onPressed: () async {
                          String? identifier = await UniqueIdentifier.serial;
                          paymentmodel objectmodel = paymentmodel.pareameters(
                              amount: amount,
                              imei: identifier,
                              total: totalamount,
                              serviceid: widget.serviceid,
                              parameters: output);
                          print(identifier);
                          service.payment(objectmodel, context).then((value) {
                            print(value['status']);
                            if (value['status'] == true) {
                              Data paymentformat =
                                  Data.fromJson(({
    "id": 799,
    "integration_provider": {
      "id": 4,
      "name": "Esh7nly",
      "description": null
    },
    "service": {
      "id": 3861,
      "name": "Air Charge",
      "description": null,
      "footer_description": null,
      "powered_by": "مصاري",
      "type": 1,
      "provider": {
        "id": 26,
        "name": "Vodafone Recharge",
        "description": null,
        "logo": "service-provider/2021/10/25/JF5a90kellvcKlbbtxZIoN4uHY7mNkRvEa9gep6N.jpeg"
      },
      "category": {
        "id": 28,
        "name": "Mobile",
        "description": null,
        "icon": "service-category/2023/09/14/FBcZY1gWcMQi9lGWhbA1kS21ZO45odwskVyh7GZl.png"
      }
    },
    "merchant": {
      "id": 11,
      "store_name": "Diaa Ahmed",
      "name": "Diaa Ahmed"
    },
    "type": "2",
    "inquiry_transaction_id": null,
    "external_transaction_id": null,
    "status": 2,
    "status_code": 1,
    "message": "success",
    "client_number": "01028237267",
    "amount": 10,
    "service_charge": 4.300000000000000710542735760100185871124267578125,
    "total_amount": 14.300000000000000710542735760100185871124267578125,
    "paid_amount": 14.300000000000000710542735760100185871124267578125,
    "min_amount": null,
    "max_amount": null,
    "is_paid": null,
    "provider_transaction_id": 2062582,
    "integration_provider_amount": 10,
    "integration_provider_balance": -10,
    "integration_provider_commission": "0",
    "request_map": {
      "3452": "01028237267"
    },
    "validation_error": null,
    "request": null,
    "response": null,
    "description": "الرقم المرجعى:434215805109",
    "extra_data": [],
    "ip": "197.59.24.47",
    "user_agent": "okhttp/4.10.0",
    "request_duration": 1,
    "imei": "imei",
    "system_commission": 0,
    "extra_system_commission": "0",
    "agent_commission": 0,
    "merchant_commission": 0,
    "staff_id": 0,
    "parent_merchant_id": null,
    "first_parent_merchant_id": null,
    "settlement_type": 2,
    "is_settled": 0,
    "settlement_wallet_transaction_id": null,
    "created_at": "2023-12-08 03:00PM",
    "canceled_at": null,
    "updated_at": "2023-12-08T13:00:28.000000Z",
    "parameters": [
      {
        "internal_id": "mobile",
        "key": "رقم الموبايل",
        "value": "01028237267",
        "display_name": "01028237267"
      }
    ],
    "balance_before": "26.140",
    "balance_after": "11.840"
  }));
                                    Get.to(fatora_details(
                            bluknumber: 0,
                            isbluck: false,
                            paymentobject: paymentformat,
                            servicetype: widget.servicetype,
                          )); 
                             /* openAlertfatora("${value['message']}",
                                  "تم نجاح العمليه", context, paymentformat); */
                              Navigator.pop(context);
                            } else {
                                DailogAlert.openbackAlert(
                "${value['message']}", "فشلت العمليه", context);
                              Navigator.pop(context);
                            }
                          });
                        }, */
}
/*void openAlert(String amount, String totalamount) {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: Container(
        height: 230.0,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 16),
          //   decoration: boxDecorationStylealert,
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 24),
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text("CONIRMATION !",
                    style: TextStyle(
                      fontSize: 19,
                    )),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Amount: ${amount.toString()}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              Text("Total Amount: ${totalamount.toString()}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              Divider(
                color: Color(0xFF898787),
              ),
              Center(
                child: Text("Quantity"),
              ),
              SizedBox(
                height: 9,
              ),
              CustomTextField(
                  hint: "1",
                  OnTab: () {},
                  dense: true,
                  controller: quantitycontroller,
                  Padding:
                      EdgeInsets.only(right: 15, top: 5, bottom: 5, left: 10)),
              /* TextFormField(
                controller: quantitycontroller,
                // initialValue: "1",
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: CustomColors.MainColor)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: Colors.black)),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10), //Change this value to custom as you like
                    isDense: true, // and add this line
                    hintText: quantitycontroller.text,
                    hintStyle: TextStyle(
                      color: Color(0xFFF00),
                    )),
                keyboardType: TextInputType.text,
                style: TextStyle(color: Color(0xFFF00), fontSize: 14),
                maxLines: 1,
              ), */
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
                        child: Text(
                          "CANCEL",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: MaterialButton(
                        onPressed: () async {
                          String? identifier = await UniqueIdentifier.serial;
                          paymentmodel objectmodel = paymentmodel.pareameters(
                              amount: amount,
                              imei: identifier,
                              total: totalamount,
                              serviceid: widget.serviceid,
                              parameters: output);
                          print(identifier);
                          service.payment(objectmodel, context).then((value) {
                            print(value['status']);
                            if (value['status'] == true) {
                              Get.snackbar(
                                  "تم نجاح العمليه", "${value['message']}");
                              Navigator.pop(context);
                            } else {
                              Get.snackbar(
                                  "فشلت العمليه", "${value['message']}");
                              Navigator.pop(context);
                            }
                          });
                        },
                        color: CustomColors.MainColor,
                        // ignore: sort_child_properties_last
                        child: Text(
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
} */

/*
   "id": 3687,
                "provider_id": 27,
                "type": 2,
                "name_ar": "حكاية جديد 60",
                "name_en": "New Hekaya 60",
                "description_ar": null,
                "description_en": null,
                "powered_by_ar": null,
                "powered_by_en": null,
                "icon": "service/2022/11/13/60YULg4FHC5kUHFkOanZsUzXCdQz83j38Q6ItRtw.jpeg",
                "accept_amount_input": 1,
                "accept_change_paid_amount": 1,
                "accept_check_integration_provider_status": 0,
                "price_type": 1,
  "id": 3685,
                "provider_id": 27,
                "type": 2,
                "name_ar": "حكاية جديد 30",
                "name_en": "New Hekaya 30",
                "description_ar": null,
                "description_en": null,
                "powered_by_ar": null,
                "powered_by_en": null,
                "icon": "service/2022/11/13/60YULg4FHC5kUHFkOanZsUzXCdQz83j38Q6ItRtw.jpeg",
                "accept_amount_input": 0,for (var item in value) {
        if (item.service_id == widget.serviceid) {
          setState(() {
            lists.add(item);
          });
        }
      }
       "id": 3322,
                "service_id": 3690,
                "internal_id": "Key1",
                "name_ar": "الفتره",
                "name_en": "الفتره",
                "type": 5,
                "type_values": [
                    {
                        "value": "1",
                        "name_ar": "اسبوع",
                        "name_en": "اسبوع"
                    },
                    {
                        "value": "2",
                        "name_ar": "اسبوعين",
                        "name_en": "اسبوعين"
                    },
                    {
                        "value": "3",
                        "name_ar": "3 اسابيع",
                        "name_en": "3 اسابيع"
                    },
                    {
                        "value": "4",
                        "name_ar": "شهر",
                        "name_en": "شهر"
                    }
                ], 
                 "id": 3322,
                "service_id": 3690,
                "internal_id": "Key1",
                "name_ar": "الفتره",
                "name_en": "الفتره",
                "type": 5,
                "type_values": [
                    {
                        "value": "1",
                        "name_ar": "اسبوع",
                        "name_en": "اسبوع"
                    },
                    {
                        "value": "2",
                        "name_ar": "اسبوعين",
                        "name_en": "اسبوعين"
                    },
                    {
                        "value": "3",
                        "name_ar": "3 اسابيع",
                        "name_en": "3 اسابيع"
                    },
                    {
                        "value": "4",
                        "name_ar": "شهر",
                        "name_en": "شهر"
                    }
                ],
                */

// remind  flexible- punoneclick- enghishnumberphome
