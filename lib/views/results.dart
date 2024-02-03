import 'package:cached_network_image/cached_network_image.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:lottie/lottie.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../Services/features/ServiceApi.dart';
import '../core/utils/colors.dart';
import '../core/widgets/CustomTextField.dart';
import '../core/widgets/customtext.dart';
import '../db/servicedb.dart';
import '../models/TotalAmounts.dart';
import '../models/inquiryobject.dart';
import '../models/payment.dart';
import '../models/services.dart';
import 'Service/Fatora_details.dart';
import 'Service/details_service.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  late List<Services> lists = [];
  final searchtext = Get.arguments;

  final serviceApi _serviceapi = serviceApi();

  Future refreshproviders() async {
    //this.lists = await ProviderDatabase.instance.readAllNotes();
    await ServiceDatabase.instance.readAllservices().then((value) {
      setState(() {
        lists = value
            .where((element) =>
                element.name_en.toString().contains(
                searchtext))
            .toList();
       
      });
    });
    return lists;
  }

  @override
  void initState() {
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SizedBox(
                height: 900,
                child: FutureBuilder(
                    future: refreshproviders(),
                    builder: (context, AsyncSnapshot snapshot) {
                      //   print("len ${lists.length}");
                      if (lists.isNotEmpty) {
                        return Directionality(
                            textDirection:
                                // ignore: unrelated_type_equality_checks, deprecated_member_use
                                translator.currentLanguage == 'en'
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      height: 100,
                                      decoration: const BoxDecoration(
                                          color: CustomColors.MainColor,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(40),
                                              bottomLeft: Radius.circular(40))),
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 48,
                                            // ignore: deprecated_member_use
                                            left: translator.currentLanguage ==
                                                    'en'
                                                ? 30
                                                : 340,
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: const Icon(
                                                Icons.arrow_back,
                                                color: Colors.white,
                                                size: 26,
                                              ),
                                            )),
                                        Positioned(
                                            top: 50,
                                            // ignore: deprecated_member_use
                                            left: translator.currentLanguage ==
                                                    'en'
                                                ? 65
                                                : 200,
                                            child: Text(
                                              // ignore: deprecated_member_use
                                              translator.translate("result"),
                                              style: const TextStyle(
                                                fontSize: 22,
                                                fontFamily: 'ReadexPro',
                                                color: Colors.white,
                                              ),
                                            )),
                                      ])),
                                  Scrollbar(
                                      child: SizedBox(
                                          height: lists.isEmpty ? 0 : 800,
                                          child: Scrollbar(
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: lists.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return SizedBox(
                                                        width: 80,
                                                        height: 108,
                                                        child: Padding(
                                                            // ignore: prefer_const_constructors
                                                            padding:
                                                                const EdgeInsets.only(
                                                                    right: 10,
                                                                    left: 10,
                                                                    top: 8,
                                                                    bottom: 0),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () async {
                                                              
                                                                if (lists[index]
                                                                        .type ==
                                                                    3) {
                                                                  String?
                                                                      identifier =
                                                                      await UniqueIdentifier
                                                                          .serial;
                                                                  totalamounts object = totalamounts(
                                                                      imei:
                                                                          identifier,
                                                                      serviceid:
                                                                          lists[index]
                                                                              .id,
                                                                      pricevalue:
                                                                          lists[index]
                                                                              .price_value);
                                                                  // ignore: use_build_context_synchronously
                                                                  _serviceapi
                                                                      .getamounts(
                                                                          object,context)
                                                                      .then(
                                                                          (value) {
                                                                    if (value["data"]
                                                                            [
                                                                            "status"] ==
                                                                        true) {
                                                                      openAlert(
                                                                          value['data']["amount"]
                                                                              .toString(),
                                                                          value['data']["total_amount"]
                                                                              .toString(),
                                                                          lists[index]
                                                                              .id!,
                                                                          lists[index]
                                                                              .type!);
                                                                     
                                                                    } else {
                                                                       DailogAlert.openbackAlert(
                                value['message'], "Failed", context);
                                                                     
                                                                    }
                                                                  });
                                                                } else {
                                                                  Get.to(detailsservice(
                                                                      service:
                                                                          lists[
                                                                              index],
                                                                      pricetype:
                                                                          lists[index]
                                                                              .price_type,
                                                                      pricevalue:
                                                                          lists[index]
                                                                              .price_value,
                                                                      acceptampount:
                                                                          lists[index]
                                                                              .accept_amount_input,
                                                                      providername:
                                                                          searchtext,
                                                                      servicetype:
                                                                          lists[index]
                                                                              .type,
                                                                      servicename:
                                                                          lists[index]
                                                                              .name_ar,
                                                                      serviceid:
                                                                          lists[index]
                                                                              .id,
                                                                      image: lists[
                                                                              index]
                                                                          .icon));
                                                                }
                                                              },
                                                              child: Card(
                                                                elevation: 3,
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                shape: RoundedRectangleBorder(
                                                                    side: const BorderSide(
                                                                        color: CustomColors
                                                                            .MainColor),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                child: Center(
                                                                    child:
                                                                        Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              14,
                                                                          bottom:
                                                                              10,
                                                                          left:
                                                                              8),
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              70,
                                                                          height:
                                                                              35,
                                                                          child: lists[index].icon!.isEmpty
                                                                              ? Image.asset('assets/logo.png')
                                                                              : CachedNetworkImage(
                                                                                  imageUrl: "https://system.e-esh7nly.net/storage/${lists[index].icon}",
                                                                                  placeholder: (context, url) => Center(
                                                                                    child: Image.asset('assets/logo.png'),
                                                                                  ),
                                                                                  errorWidget: (context, url, error) => Image.asset('assets/logo.png'),
                                                                                ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              6,
                                                                        ),
                                                                        customtext(
                                                                          // ignore: deprecated_member_use
                                                                          text: translator.currentLanguage == 'ar'
                                                                              ? lists[index].name_ar!
                                                                              : lists[index].name_en!,
                                                                          maxLine:
                                                                              1,
                                                                          fontSize:
                                                                              17,
                                                                          color:
                                                                              CustomColors.MainColor,
                                                                          fontweight:
                                                                              FontWeight.bold,
                                                                        )
                                                                      ]),
                                                                )),
                                                              ),
                                                            )));
                                                  }))))
                                ]));
                      } 
                      else if(lists.isEmpty)
                      {
                        return Center(
                          child: Lottie.asset('assets/animation_lmga1r6c.json')
                        );
                      }
                      else {
                        return const Center(
                            child: CircularProgressIndicator(
                                color: CustomColors.MainColor));
                      }
                    }))));
  }

  void openAlert(String amount, String totalamount, int id, int type) {
    late var quantitycontroller = TextEditingController(text: "1");
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: SizedBox(
        height: 230.0,
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          //   decoration: boxDecorationStylealert,
          width: 230,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text("CONIRMATION !",
                    style: TextStyle(
                      fontSize: 19,
                    )),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Amount: ${amount.toString()}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4,
              ),
              Text("Total Amount: ${totalamount.toString()}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                color:  Color(0xFF898787),
              ),
              const Center(
                child:Text("Quantity"),
              ),
              const SizedBox(
                height: 9,
              ),
              CustomTextField(
                  OnTab: () {},
                  dense: true,
                  controller: quantitycontroller,
                  Padding:
                      const EdgeInsets.only(right: 15, top: 5, bottom: 5, left: 10)),
              const SizedBox(
                height: 9,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:const EdgeInsets.only(left: 5, right: 5),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: CustomColors.MainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child:  const Text(
                          "CANCEL",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: MaterialButton(
                        onPressed: () async {
                          // ignore: non_constant_identifier_names
                          bool ISBLUK = false;
                          String? identifier = await UniqueIdentifier.serial;
                       
                          paymentmodel objectmodel = paymentmodel(
                              amount: amount,
                              imei: identifier,
                              total: totalamount,
                              serviceid: id);
                          // ignore: use_build_context_synchronously
                          _serviceapi.payment(objectmodel,context).then((value) {
                           
                            // ==true
                            if (value['status'] != true) {
                             DailogAlert.openbackAlert(
                                value['message'], "Successful", context);
                              Navigator.pop(context);
                              //value['data]
                              Data paymentformat = Data.fromJson(value['data']);
                              if (int.parse(quantitycontroller.text) > 1) {
                                ISBLUK = true;

                                //Get.to(fatora_details());
                                //totalamount , paymentobject,serivcetype
                              } else {
                                //paymentobject,serivcetype
                                Get.to(fatora_details(
                                  paymentobject: paymentformat,
                                  servicetype: type,
                                  isbluck: ISBLUK,
                                  bluknumber:
                                      int.parse(quantitycontroller.text),
                                ));
                              }
                            } else {
                               DailogAlert.openbackAlert(
                                // ignore: deprecated_member_use
                                value['message'],translator.translate(""), context);
                           
                              Navigator.pop(context);
                            }
                          });
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
}
