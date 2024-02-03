// ignore_for_file: unnecessary_import, prefer_typing_uninitialized_variables, non_constant_identifier_names, unused_local_variable, deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace, unnecessary_brace_in_string_interps

import 'package:esh7enly/core/loader/providerloader.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:unique_identifier/unique_identifier.dart';
import '../Services/features/BankApi.dart';
import '../Services/features/xpayintegrate.dart';
import '../core/utils/colors.dart';
import '../core/widgets/CustomTextField.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Addbalance extends StatefulWidget {
  const Addbalance({Key? key}) : super(key: key);

  @override
  State<Addbalance> createState() => _AddbalanceState();
}

class _AddbalanceState extends State<Addbalance> {
  late var balancecontroller = TextEditingController();
  late var phonecontroller = TextEditingController();
  XPAY xpayobj = XPAY();
  final storage = const FlutterSecureStorage();
  var totalamount = "";
  var fees = "";
  BankApi object = BankApi();
  var uidtransaction;
  bool pressbank = false;
  bool presswallet = false;
  bool presscash = false;
  bool tab = true;
  String? message;

  @override
  void initState() {
    // Alert();
    super.initState();
  }

  // ignore: annotate_overrides
  void dispose() {
    Alert();

    super.dispose();
    //...
  }

  Future<void> Alert() async {
    // var uid = await storage.read(key: 'uid');
    // print(uid);
    var id = await storage.read(key: 'id');

    if (uidtransaction != null) {
      xpayobj.gettransaction(uidtransaction).then((value) {
        Map data = {
          "id": int.parse(id!),
          "amount": balancecontroller.text,
          "card_id": value['id'],
          "uuid": value['uuid'],
          "member_id": value['member_id'],
          "total_amount": value['total_amount'],
          "total_amount_currency": value['total_amount_currency'],
          "payment_for": value['payment_for'],
          "quantity": value['quantity'],
          "status": value['status'],
          "total_amount_piasters": value['total_amount_piasters']
        };

        object.payamount(data, context).then((value) {
          storage.delete(key: 'uid');
          storage.delete(key: 'id');
          EasyLoading.dismiss();
          openAlert(
            value['status'],
            value['message'],
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Alert();
    final modelhud = Provider.of<providerloader>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
            inAsyncCall: Provider.of<providerloader>(context).isloading,
            child: SingleChildScrollView(
                child: Directionality(
                    textDirection:
                        // ignore: unrelated_type_equality_checks
                        translator.currentLanguage == 'en'
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                    child: Form(
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
                                        },
                                      )),
                                  Text(
                                    '   ${translator.translate("addbalance")}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'ReadexPro',
                                      color: Colors.white,
                                    ),
                                  ),
                                ]),
                              )),
                          SizedBox(
                            height: 150,
                          ),
                          Container(
                              width: 380,
                              height: 270,
                              child: Card(
                                  color: Colors.white,
                                  elevation: 3,
                                  clipBehavior: Clip.antiAlias,
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 1, right: 23, left: 23),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: CustomColors.MainColor,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(
                                      1.0,
                                    ),
                                  ),
                                  child: SizedBox(
                                      height: 1000,
                                      child: Column(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30,
                                                  right:40,
                                                  left: 40,
                                                  bottom: 7),
                                              child: CustomTextField(
                                                hint: translator
                                                    .translate("enter money"),
                                                w: 60,
                                                type: TextInputType.number,
                                                controller: balancecontroller,
                                                OnTab: () {},
                                              )),
                                          Container(
                                              height: 48,
                                              width: 280,
                                              margin: const EdgeInsets.only(
                                                  top: 18, right: 13, left: 14),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: CustomColors.MainColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 2, left: 0),
                                                  child: Row(children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          pressbank = true;

                                                          presscash = false;
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 128, //133
                                                        height: 50,
                                                        color: pressbank
                                                            ? CustomColors
                                                                .MainColor
                                                            : Colors.white,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/bank-wallet icon -02.svg",
                                                            ),
                                                            Text(
                                                                translator
                                                                    .translate(
                                                                        "bank"),
                                                                style:
                                                                    TextStyle(
                                                                       color:pressbank
                                                           ? Colors.white:Colors.black,
                                                                  fontFamily:
                                                                      'ReadexPro',
                                                                  fontSize: 15,
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 2), //26
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          presscash = true;
                                                          pressbank = false;
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 146, //125
                                                        height: 50,
                                                        color: presscash
                                                            ? CustomColors
                                                                .MainColor
                                                            : Colors.white,
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/bank-wallet icon -01.svg",
                                                              width: 15,
                                                              height: 15,
                                                            ),
                                                            Text(
                                                              translator
                                                                  .translate(
                                                                      "mofaz"),
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                 color: presscash
                                                           ? Colors.white:Colors.black,
                                                                fontFamily:
                                                                    'ReadexPro',
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ]))),
                                          SizedBox(
                                            height: 24,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              if (pressbank == true) {
                                                EasyLoading.show(
                                                    status: translator
                                                                .currentLanguage ==
                                                            'ar'
                                                        ? 'جاري التحميل '
                                                        : 'loading...',
                                                    maskType:
                                                        EasyLoadingMaskType
                                                            .black);
                                                object
                                                    .getamount(
                                                        double.parse(
                                                            balancecontroller
                                                                .text
                                                                .toString()),
                                                        context,
                                                        "visa")
                                                    .then((value) {
                                                  setState(() {
                                                    totalamount =
                                                        value['amount']
                                                            .toString();

                                                    fees = value['fees']
                                                        .toString();
                                                  });
                                                  getbodybank("visa");
                                                });
                                              }
                                              if (presscash == true) {
                                                object
                                                    .getamount(
                                                        double.parse(
                                                            balancecontroller
                                                                .text
                                                                .toString()),
                                                        context,
                                                        "wallet")
                                                    .then((value) {
                                                  setState(() {
                                                    totalamount =
                                                        value['amount']
                                                            .toString();

                                                    fees = value['fees']
                                                        .toString();
                                                  });
                                                  getbodybank("wallet");
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: 50,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 48),
                                              decoration: BoxDecoration(
                                                color: CustomColors.MainColor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  translator.translate("pay"),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'ReadexPro',
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )))),
                        ]))))));
  }

  void openAlert(String statuss, String mess) {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: Container(
        height: 150.0,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 16),
          //   decoration: boxDecorationStylealert,
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(statuss == "success" ? "Success" : "Failed",
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 14,
              ),
              Center(
                child: Text(
                  mess,
                ),
              ),
              SizedBox(
                height: 9,
              ),
              Center(
                child: Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 0),
                    child: MaterialButton(
                      onPressed: () async {
                        if (statuss == "success") {
                          Get.back();
                          Get.back();
                        } else {
                          Get.back();
                        }
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
                ),
              )
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  PaymentSdkConfigurationDetails generateConfig(
      String name, String email, String mobile) {
    var billingDetails = BillingDetails(
        name, email, mobile, "Egypt", "eg", "Egypt", "Egypt", "12345");
    var shippingDetails = ShippingDetails(
        name, email, mobile, "Egypt", "eg", "Egypt", "Egypt", "1245");

    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.AMAN);
    final configuration = PaymentSdkConfigurationDetails(
        profileId: "122125",
        serverKey: "SBJNKTLW6J-J6KZMHHZW2-JHBHTJRDZD",
        clientKey: "C6KM7G-T7DK6G-K9NHH9-QMN6HV",
        cartId: "1",
        cartDescription: "ادفع الان مع اشحنلي",
        merchantName: "اشحنلي",
        screentTitle: translator.currentLanguage == 'en'
            ? "Pay now with esh7enly"
            : "ادفع الان مع اشحنلي",
        amount: double.parse(totalamount),
        showBillingInfo: false,
        forceShippingInfo: false,
        currencyCode: "EGP",
        merchantCountryCode: "EG",
        billingDetails: billingDetails,
        shippingDetails: shippingDetails,
        alternativePaymentMethods: apms,
        locale: translator.currentLanguage == 'en'
            ? PaymentSdkLocale.EN
            : PaymentSdkLocale.AR,
        linkBillingNameWithCardHolderName: true);

    final theme = IOSThemeConfigurations();
    theme.logoImage = "assets/logo.png";
    theme.secondaryColor = "bc3827"; // Color hex value
    theme.buttonColor = "bc3827";

    configuration.iOSThemeConfigurations = theme;
    //configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
    return configuration;
  }

  Future<void> payPressed(
      String name, String email, String mobile, int id) async {
    FlutterPaytabsBridge.startCardPayment(generateConfig(name, email, mobile),
        (event) {
      setState(() {
        Map transactionDetails = new Map();
        Map Result = new Map();
        print(event);
        if (event["status"] == "success") {
          // Handle transaction details here.

          transactionDetails = event["data"];

          if (transactionDetails["isSuccess"]) {
            /*
Authorization: **

{
  "amount": "50",
  "card_id": "1698051218",
  "cartDescription": "Add esh7enly balance",
  "id": 646,
  "isAuthorized": false,
  "isOnHold": false,
  "isPending": false,
  "isProcessed": true,
  "isSuccess": false,
  "payResponseReturn": "3DSecure authentication rejected",
  "payment_method_type": "paytabs",
  "responseCode": "310",
  "responseMessage": "3DSecure authentication rejected",
  "responseStatus": "D",
  "status": "FAILED",
  "total_amount": "52.55",
  "transactionReference": "PTE2402848588439",
  "transactionTime": "2024-01-28T21:07:02Z",
  "transactionType": "Sale",
  "transaction_type": "visa"
}
 */
            
            Result.addAll({
               'amount': balancecontroller.text,
              'status': 'SUCCESSFUL',
              'id': id,
              'totalamount': event['data']['cartAmount'],
              "payment_method_type": "paytabs",
              "transaction_type": 'visa',
              "card_id": event['data']['cartID'],
              "cartDescription": event['data']['cartDescription'],
              "isAuthorized": event['data']['isAuthorized'],
              "isOnHold": event['data']['isOnHold'],
              "isPending": event['data']['isPending'],
              "isProcessed": event['data']['isProcessed'],
              "isSuccess": event['data']['isSuccess'],
              "payResponseReturn": event['data']['payResponseReturn'],
              "responseCode": event['data']['paymentResult']['responseCode'],
              "responseMessage": event['data']['paymentResult']
                  ['responseMessage'],
              "responseStatus": event['data']['paymentResult']
                  ['responseStatus'],
              "transactionReference": event['data']['transactionReference'],
              "transactionTime": event['data']['paymentResult']
                  ['transactionTime'],
              "transactionType": event['data']['transactionType'],
            });

            object.payamount(Result, context).then((value) {
              // storage.delete(key: 'uid');
              //storage.delete(key: 'id');
              EasyLoading.dismiss();
              print(Result);
              openAlert(
                "success",
                'تم اضافه الرصيد لحسابك',
              );
              print('uuu${event['data']['cartAmount']}');
            });
            print("successful transaction");
          } else {
            // transactionDetails.add({'status': 'FAILED'});
             Result.addAll({
                 'amount': balancecontroller.text,
              'status': 'FAILED',
              'id': id,
              'totalamount': event['data']['cartAmount'],
              "payment_method_type": "paytabs",
              "transaction_type": 'visa',
              
              "card_id": event['data']['cartID'],
              "cartDescription": event['data']['cartDescription'],
              "isAuthorized": event['data']['isAuthorized'],
              "isOnHold": event['data']['isOnHold'],
              "isPending": event['data']['isPending'],
              "isProcessed": event['data']['isProcessed'],
              "isSuccess": event['data']['isSuccess'],
              "payResponseReturn": event['data']['payResponseReturn'],
              "responseCode": event['data']['paymentResult']['responseCode'],
              "responseMessage": event['data']['paymentResult']
                  ['responseMessage'],
              "responseStatus": event['data']['paymentResult']
                  ['responseStatus'],
              "transactionReference": event['data']['transactionReference'],
              "transactionTime": event['data']['paymentResult']
                  ['transactionTime'],
              "transactionType": event['data']['transactionType'],
            });

            object.payamount(transactionDetails, context).then((value) {
              // storage.delete(key: 'uid');
              print(transactionDetails);
              EasyLoading.dismiss();
              openAlert(
                "Failed",
                " Sorry failed transaction",
              );
            });
            print("failed transaction");
          }
        } else if (event["status"] == "error") {
          // Handle error here.
          transactionDetails.addAll({
            'status': 'FAILED',
            'id': id,
            'amount': balancecontroller.text,
            "payment_method_type": "paytabs",
            "transaction_type": 'visa'
          });

          object.payamount(transactionDetails, context).then((value) {
            // storage.delete(key: 'uid');
            EasyLoading.dismiss();
            openAlert(
              "Failed",
              event['message'],
            );
          });

          print('erroe');
        } else if (event["status"] == "event") {
          // Handle events here.
          // transactionDetails.add({'status': 'FAILED'});
          transactionDetails = ({
            'status': 'CANCELLED',
            'id': id,
            'amount': balancecontroller.text,
            "payment_method_type": "paytabs",
            "transaction_type": 'visa',
            "errorMsg": "canceled",
            "errorCode": "401"
          });

          object.payamount(transactionDetails, context).then((value) {
            // storage.delete(key: 'uid');
            EasyLoading.dismiss();
            openAlert(
              "Failed",
              event['message'],
            );
            print(transactionDetails);
          });
          print("canceled transaction");
        }
      });
    });
  }

  getbodybank(String type) {
    EasyLoading.dismiss();
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
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(translator.translate("confirm"),
                    style: TextStyle(
                        color: CustomColors.MainColor,
                        fontSize: 19,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 7,
              ),
              Center(
                  child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 15, left: 30),
                      child: Row(
                        children: [
                          Text(
                            "Service cost  :  ",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'ReadexPro',
                                fontWeight: FontWeight.bold),
                          ),
                          Text("${balancecontroller.text} EGP")
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 15, left: 30),
                      child: Row(
                        children: [
                          Text(
                            "Service Fees  :  ",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'ReadexPro',
                                fontWeight: FontWeight.bold),
                          ),
                          Text("${fees} EGP")
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 15, bottom: 12),
                    child: Row(
                      children: [
                        Text(
                          "Total Amount :  ",
                          style: TextStyle(
                              color: CustomColors.MainColor,
                              fontFamily: 'ReadexPro',
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text("${totalamount} EGP")
                      ],
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: 9,
              ),
              Center(
                  child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 0),
                      child: MaterialButton(
                        onPressed: () async {
                          EasyLoading.show(
                              status: translator.currentLanguage == 'ar'
                                  ? 'جاري التحميل '
                                  : 'loading...',
                              maskType: EasyLoadingMaskType.black);
                          object
                              .startsession(
                                  double.parse(totalamount),
                                  double.parse(balancecontroller.text),
                                  context,
                                  type)
                              .then((value) async {
                            if (value['status'] == true) {
                              print('test');
                              var id = value['data']['id'];
                              storage.write(
                                  key: 'id',
                                  value: value['data']['id'].toString());
                              //goto paytabs
                              Get.back();

                              var name = await storage.read(key: 'name');
                              var mobile = await storage.read(key: 'mobile');
                              var email = await storage.read(key: 'email');
                              if (type.trim() == "visa") {
                                await payPressed(name!, email!, mobile!,
                                    value['data']['id']);
                              } else {
                                await payPressedwallet(name!, email!, mobile!,
                                    value['data']['id']);
                              }
                            } else {
                              EasyLoading.dismiss();
                              DailogAlert.openbackAlert(
                                  value['message'], 'Failed', context);
                            }
                          });
                        },
                        color: CustomColors.MainColor,
                        // ignore: sort_child_properties_last
                        child: Text(
                          translator.translate('ok'),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 0),
                      child: MaterialButton(
                        onPressed: () async {
                          Get.back();
                        },
                        color: CustomColors.MainColor,
                        // ignore: sort_child_properties_last
                        child: Text(
                          translator.translate("cancel"),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

   PaymentSdkConfigurationDetails generateConfigwallet (
      String name, String email, String mobile) {
    var billingDetails = BillingDetails(
        name, email, mobile, "Egypt", "eg", "Egypt", "Egypt", "12345");
    var shippingDetails = ShippingDetails(
        name, email, mobile, "Egypt", "eg", "Egypt", "Egypt", "1245");

    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.MEEZA_QR);
    final configuration = PaymentSdkConfigurationDetails(
        profileId: "135102"
,
        serverKey: "S6JNKTLWMN-JHMWN69W6T-LGBM26GMDW",
        clientKey: "CKKM7G-T7DK6H-NVQGPV-79P22K",
        cartId: "2",
        cartDescription: "ادفع الان مع اشحنلي",
        merchantName: "اشحنلي",
        screentTitle: translator.currentLanguage == 'en'
            ? "Pay now with esh7enly"
            : "ادفع الان مع اشحنلي",
        amount: double.parse(totalamount),
        showBillingInfo: false,
        forceShippingInfo: false,
        currencyCode: "EGP",
        merchantCountryCode: "EG",
        billingDetails: billingDetails,
        shippingDetails: shippingDetails,
        alternativePaymentMethods: apms,
        locale: translator.currentLanguage == 'en'
            ? PaymentSdkLocale.EN
            : PaymentSdkLocale.AR,
        linkBillingNameWithCardHolderName: true);

    final theme = IOSThemeConfigurations();
    theme.logoImage = "assets/logo.png";
    theme.secondaryColor = "bc3827"; // Color hex value
    theme.buttonColor = "bc3827";

    configuration.iOSThemeConfigurations = theme;
    //configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
    return configuration;
  }

 Future<void>  payPressedwallet(String name, String email, String mobile, int id) async {
    FlutterPaytabsBridge.startAlternativePaymentMethod(
       await generateConfigwallet(name, email, mobile), (event) {
      setState(() {
        Map transactionDetails = new Map();
         Map Result = new Map();
        print(event);
       if (event["status"] == "success") {
          // Handle transaction details here.

          transactionDetails = event["data"];

          if (transactionDetails["isSuccess"]) {
            /*
Authorization: **

{
  "amount": "50",
  "card_id": "1698051218",
  "cartDescription": "Add esh7enly balance",
  "id": 646,
  "isAuthorized": false,
  "isOnHold": false,
  "isPending": false,
  "isProcessed": true,
  "isSuccess": false,
  "payResponseReturn": "3DSecure authentication rejected",
  "payment_method_type": "paytabs",
  "responseCode": "310",
  "responseMessage": "3DSecure authentication rejected",
  "responseStatus": "D",
  "status": "FAILED",
  "total_amount": "52.55",
  "transactionReference": "PTE2402848588439",
  "transactionTime": "2024-01-28T21:07:02Z",
  "transactionType": "Sale",
  "transaction_type": "visa"
}
 */
            
            Result.addAll({
               'amount': balancecontroller.text,
              'status': 'SUCCESSFUL',
              'id': id,
              'totalamount': event['data']['cartAmount'],
              "payment_method_type": "paytabs",
              "transaction_type": 'visa',
              "card_id": event['data']['cartID'],
              "cartDescription": event['data']['cartDescription'],
              "isAuthorized": event['data']['isAuthorized'],
              "isOnHold": event['data']['isOnHold'],
              "isPending": event['data']['isPending'],
              "isProcessed": event['data']['isProcessed'],
              "isSuccess": event['data']['isSuccess'],
              "payResponseReturn": event['data']['payResponseReturn'],
              "responseCode": event['data']['paymentResult']['responseCode'],
              "responseMessage": event['data']['paymentResult']
                  ['responseMessage'],
              "responseStatus": event['data']['paymentResult']
                  ['responseStatus'],
              "transactionReference": event['data']['transactionReference'],
              "transactionTime": event['data']['paymentResult']
                  ['transactionTime'],
              "transactionType": event['data']['transactionType'],
            });

            object.payamount(Result, context).then((value) {
              // storage.delete(key: 'uid');
              //storage.delete(key: 'id');
              EasyLoading.dismiss();
              print(Result);
              openAlert(
                "success",
                'تم اضافه الرصيد لحسابك',
              );
              print('uuu${event['data']['cartAmount']}');
            });
            print("successful transaction");
          } else {
            // transactionDetails.add({'status': 'FAILED'});
             Result.addAll({
                 'amount': balancecontroller.text,
              'status': 'FAILED',
              'id': id,
              'totalamount': event['data']['cartAmount'],
              "payment_method_type": "paytabs",
              "transaction_type": 'visa',
              
              "card_id": event['data']['cartID'],
              "cartDescription": event['data']['cartDescription'],
              "isAuthorized": event['data']['isAuthorized'],
              "isOnHold": event['data']['isOnHold'],
              "isPending": event['data']['isPending'],
              "isProcessed": event['data']['isProcessed'],
              "isSuccess": event['data']['isSuccess'],
              "payResponseReturn": event['data']['payResponseReturn'],
              "responseCode": event['data']['paymentResult']['responseCode'],
              "responseMessage": event['data']['paymentResult']
                  ['responseMessage'],
              "responseStatus": event['data']['paymentResult']
                  ['responseStatus'],
              "transactionReference": event['data']['transactionReference'],
              "transactionTime": event['data']['paymentResult']
                  ['transactionTime'],
              "transactionType": event['data']['transactionType'],
            });

            object.payamount(transactionDetails, context).then((value) {
              // storage.delete(key: 'uid');
              print(transactionDetails);
              EasyLoading.dismiss();
              openAlert(
                "Failed",
                " Sorry failed transaction",
              );
            });
            print("failed transaction");
          }
        } else if (event["status"] == "error") {
          // Handle error here.
          transactionDetails.addAll({
            'status': 'FAILED',
            'id': id,
            'amount': balancecontroller.text,
            "payment_method_type": "paytabs",
            "transaction_type": 'visa'
          });

          object.payamount(transactionDetails, context).then((value) {
            // storage.delete(key: 'uid');
            EasyLoading.dismiss();
            openAlert(
              "Failed",
              event['message'],
            );
          });

          print('erroe');
        } else if (event["status"] == "event") {
          // Handle events here.
          // transactionDetails.add({'status': 'FAILED'});
          transactionDetails = ({
            'status': 'CANCELLED',
            'id': id,
            'amount': balancecontroller.text,
            "payment_method_type": "paytabs",
            "transaction_type": 'visa',
            "errorMsg": "canceled",
            "errorCode": "401"
          });

          object.payamount(transactionDetails, context).then((value) {
            // storage.delete(key: 'uid');
            EasyLoading.dismiss();
            openAlert(
              "Failed",
              event['message'],
            );
            print(transactionDetails);
          });
          print("canceled transaction");
        }
      });
    });
  }
}
/*getbodyvodafonecache(name, email, mobile) {
    payPressedwallet(name, email, mobile);
  } */
/*  GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      presswallet = true;
                                                      pressbank = false;
                                                      presscash = false;
                                                    });
                                                  },
                                                  child: Container(
                                                    color: presswallet
                                                        ? CustomColors.MainColor
                                                        : Colors.white,
                                                    width: 80,
                                                    height: 50,
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            "assets/bank-wallet icon -01.svg"),
                                                        SizedBox(width: 3),
                                                        Text(
                                                            translator
                                                                .translate(
                                                                    "mofaz"),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'ReadexPro',
                                                              fontSize: 13,
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ), */
//add balance with xpay
/*// ignore_for_file: unnecessary_import, prefer_typing_uninitialized_variables, non_constant_identifier_names, unused_local_variable, deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace, unnecessary_brace_in_string_interps

import 'package:esh7enly/core/loader/providerloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:unique_identifier/unique_identifier.dart';
import '../Services/features/BankApi.dart';
import '../Services/features/xpayintegrate.dart';
import '../core/utils/colors.dart';
import '../core/widgets/CustomTextField.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Addbalance extends StatefulWidget {
  const Addbalance({Key? key}) : super(key: key);

  @override
  State<Addbalance> createState() => _AddbalanceState();
}

class _AddbalanceState extends State<Addbalance> {
  late var balancecontroller = TextEditingController();
  late var phonecontroller = TextEditingController();
  XPAY xpayobj = XPAY();
  final storage = const FlutterSecureStorage();
  var totalamount = "";
  var fees = "";
  BankApi object = BankApi();
  var uidtransaction;
  bool pressbank = false;
  bool presswallet = false;
  bool presscash = false;
  bool tab = true;
  String? message;

  @override
  void initState() {
    
    Alert();
    super.initState();
  }

  // ignore: annotate_overrides
  void dispose() {
    Alert();
    
    super.dispose();
    //...
  }

  Future<void> Alert() async {
   
      
    // var uid = await storage.read(key: 'uid');
    // print(uid);
    var id = await storage.read(key: 'id');

   
    if (uidtransaction != null) {
     
      xpayobj.gettransaction(uidtransaction).then((value) {
        
       
        Map data = {
          "id": int.parse(id!),
          "amount": balancecontroller.text,
          "card_id": value['id'],
          "uuid": value['uuid'],
          "member_id": value['member_id'],
          "total_amount": value['total_amount'],
          "total_amount_currency": value['total_amount_currency'],
          "payment_for": value['payment_for'],
          "quantity": value['quantity'],
          "status": value['status'],
          "total_amount_piasters": value['total_amount_piasters']
        };
       
        object.payamount(data, context).then((value) {
         
          storage.delete(key: 'uid');
          storage.delete(key: 'id');
 EasyLoading.dismiss();
          openAlert( value['status'],value['message'],);

           
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Alert();
    final modelhud = Provider.of<providerloader>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
            inAsyncCall: Provider.of<providerloader>(context).isloading,
            child: SingleChildScrollView(
                child: Directionality(
                    textDirection:
                        // ignore: unrelated_type_equality_checks
                        translator.currentLanguage == 'en'
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                    child: Form(
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
                              child:Padding(
                                     padding: EdgeInsets.only(right: 30, left: 30,top:30),
                                child: Row(children: <Widget>[
                           
                                SizedBox(
                                width: 30,
                                          child:IconButton(icon:  Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                            size: 26,
                                          ), onPressed: () {  Get.back(); },)),Text(
                                     '   ${ translator.translate("addbalance")}',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: 'ReadexPro',
                                        color: Colors.white,
                                      ),
                                    ), 
                              ]),
                              )),
                          SizedBox(
                            height: 150,
                          ),
                          Container(
                              width: 380,
                              height: presscash == true ?  330:270 ,
                              child: Card(
                                  color: Colors.white,
                                  elevation: 3,
                                  clipBehavior: Clip.antiAlias,
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 1, right: 23, left: 23),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: CustomColors.MainColor,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(
                                      1.0,
                                    ),
                                  ),
                                  child: SizedBox(
                                      height: 1000,
                                      child: Column(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30,
                                                  right: 20,
                                                  left: 20,
                                                  bottom: 7),
                                              child: CustomTextField(
                                                hint: translator
                                                    .translate("enter money"),
                                                w: 60,
                                                type: TextInputType.number,
                                              
                                                controller: balancecontroller,
                                                OnTab: () {},
                                              )),
                                          Container(
                                              height: 42,
                                              width: 259,
                                              margin: const EdgeInsets.only(
                                                  top: 18, right: 13, left: 14),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: CustomColors.MainColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 2, left: 0),
                                                  child: Row(children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          pressbank = true;

                                                          presscash = false;
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 115, //133
                                                        height: 50,
                                                        color: pressbank
                                                            ? CustomColors
                                                                .MainColor
                                                            : Colors.white,
                                                        child: Row(
                                                          mainAxisAlignment:MainAxisAlignment.center,
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/bank-wallet icon -02.svg",
                                                            ),
                                                            Text(
                                                                translator
                                                                    .translate(
                                                                        "bank"),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'ReadexPro',
                                                                  fontSize: 15,
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 8), //26
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          presscash = true;
                                                          pressbank = false;
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 131, //125
                                                        height: 50,
                                                        color: presscash
                                                            ? CustomColors
                                                                .MainColor
                                                            : Colors.white,
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/vodafon cash.svg",
                                                              width: 5,
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              translator.translate(
                                                                  "vodavonecash"),
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'ReadexPro',
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ]))),
                                          presscash == true
                                              ? getbodyvodafonecache()
                                              : SizedBox(height: 0, width: 0),
                                          SizedBox(
                                            height: 24,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              if (pressbank == true) {
                                                  object
                                                      .getamount(
                                                          double.parse(
                                                              balancecontroller
                                                                  .text
                                                                  .toString()),
                                                          context)
                                                      .then((value) {
                                                  
                                                    setState(() {
                                                      totalamount =
                                                          value['amount']
                                                              .toString();

                                                      fees = value['fees']
                                                          .toString();
                                                   

                                                    });
                                                     getbodybank();

                                                  });
                                               
                                              }
                                              if (presscash == true) {
                                                String? identifier =
                                                    await UniqueIdentifier
                                                        .serial;
                                                //await modelhud  .changeisloading(true);
                                                // await modelhud.chngechannel();
                                                // ignore: use_build_context_synchronously
                                                await object
                                                    .totalamountvodavonecache(
                                                        identifier!,
                                                        balancecontroller.text,
                                                        phonecontroller.text,
                                                        context);
                                                //    await modelhud.changeisloading(false);
                                              }
                                            },
                                            child: Container(
                                              height: 50,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 48),
                                              decoration: BoxDecoration(
                                                color: CustomColors.MainColor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  translator.translate("pay"),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'ReadexPro',
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )))),
                        ]))))));
  }

  void openAlert(bool statuss, String mess) {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: Container(
        height: 150.0,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 16),
          //   decoration: boxDecorationStylealert,
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(statuss == true ? "Success" : "Failed",
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 14,
              ),
              Center(
                child: Text(
                  mess,
                ),
              ),
              SizedBox(
                height: 9,
              ),
              Center(
                child: Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 0),
                    child: MaterialButton(
                      onPressed: () async {
                        if (statuss ==true) {
                          Get.back();
                          Get.back();
                           
                        } else {
                          Get.back();
                          
                        }
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
                ),
              )
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  _launchURL(double amount) async {
    xpayobj.getiframe(amount).then((val) async {
  
                  final Uri url = Uri.parse(val['data']["iframe_url"]);
      if (await canLaunch(val['data']["iframe_url"])) {
        await (launchUrl(url));
       
    
        await Future.delayed(Duration(milliseconds: 100));
        while (WidgetsBinding.instance.lifecycleState !=
            AppLifecycleState.resumed) {
          await Future.delayed(Duration(milliseconds: 100));
        }
     
        setState(() {
          uidtransaction = val["data"]["transaction_uuid"];
        });
      } else {
        throw 'Could not launch $url';
      }

/* 
if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      } else {
        setState(() {
          Future.delayed(Duration(seconds: 2), () {
  uidtransaction = val["data"]["transaction_uuid"];
          });

        
        });
      }
    });
    /*
    

    final Uri url = Uri.parse(
        "https://staging-payment.xpay.app/bank_ahly/direct_iframe/39961/");*/
    setState(() {
      tab = true;
    }); */
    });
  }

  getbodybank() { 
                                                

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
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(translator.translate("confirm"),
                    style: TextStyle(
                        color: CustomColors.MainColor,
                        fontSize: 19,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 7,
              ),
              Center(
                  child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 15, left: 30),
                      child: Row(
                        children: [
                          Text(
                            "Service cost  :  ",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'ReadexPro',
                                fontWeight: FontWeight.bold),
                          ),
                          Text("${balancecontroller.text} EGP")
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 15, left: 30),
                      child: Row(
                        children: [
                          Text(
                            "Service Fees  :  ",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'ReadexPro',
                                fontWeight: FontWeight.bold),
                          ),
                          Text("${fees} EGP")
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 15, bottom: 12),
                    child: Row(
                      children: [
                        Text(
                          "Total Amount :  ",
                          style: TextStyle(
                              color: CustomColors.MainColor,
                              fontFamily: 'ReadexPro',
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text("${totalamount} EGP")
                      ],
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: 9,
              ),
              Center(
                  child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 0),
                      child: MaterialButton(
                        onPressed: () async {
                          EasyLoading.show(
                              status: translator.currentLanguage == 'ar'
                                  ? 'جاري التحميل '
                                  : 'loading...',
                              maskType: EasyLoadingMaskType.black);
                          object
                              .startsession(double.parse(totalamount),
                                  double.parse(balancecontroller.text), context)
                              .then((value) async {
                            if (value['status'] == true) {
                              var id = value['data']['id'];
                              storage.write(
                                  key: 'id',
                                  value: value['data']['id'].toString());
                              //xpayobj.gettransaction(val["data"]["transaction_uuid"]);
                              await _launchURL(double.parse(balancecontroller.text));
                              Get.back();

                              /* if (uidtransaction != null) {
                                                  xpayobj
                                                      .gettransaction(
                                                          uidtransaction)
                                                      .then((value) {
                                                    print('reult $value');
                                                    storage.write(
                                                        key: 'id',
                                                        value: value['data']
                                                            ['id']);
                                                    Map data = {
                                                      "id": id,
                                                      "amount":
                                                          balancecontroller
                                                              .text,
                                                      "card_id": value['id'],
                                                      "uuid": value['uuid'],
                                                      "member_id":
                                                          value['member_id'],
                                                      "total_amount":
                                                          value['total_amount'],
                                                      "total_amount_currency":
                                                          value[
                                                              'total_amount_currency'],
                                                      "payment_for":
                                                          value['payment_for'],
                                                      "quantity":
                                                          value['quantity'],
                                                      "status": value['status'],
                                                      "total_amount_piasters":
                                                          value[
                                                              'total_amount_piasters']
                                                    };
                                                    object
                                                        .payamount(data)
                                                        .then((value) {
                                                      print('test');

                                                      print(value);

                                                      /*  openAlert(
                                                          value['message']); */
                                                    });
                                                  });
                                                } */
                            }
                          });
                        },
                        color: CustomColors.MainColor,
                        // ignore: sort_child_properties_last
                        child: Text(
                          translator.translate('ok'),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 0),
                      child: MaterialButton(
                        onPressed: () async {
                          Get.back();
                        },
                        color: CustomColors.MainColor,
                        // ignore: sort_child_properties_last
                        child: Text(
                          translator.translate("cancel"),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
    /*return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(top: 30, left: 30),
            child: Row(
              children: [
                Text(
                  "Service cost:",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'ReadexPro',
                      fontWeight: FontWeight.bold),
                ),
                Text(balancecontroller.text)
              ],
            )),
        Padding(
            padding: EdgeInsets.only(top: 25, left: 30),
            child: Row(
              children: [
                Text(
                  "Service Fees  :",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'ReadexPro',
                      fontWeight: FontWeight.bold),
                ),
                Text(fees)
              ],
            )),
        Padding(
          padding: EdgeInsets.only(left: 30, top: 22, bottom: 12),
          child: Row(
            children: [
              Text(
                "Total Amount :",
                style: TextStyle(
                    color: CustomColors.MainColor,
                    fontFamily: 'ReadexPro',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Text(totalamount)
            ],
          ),
        ),
      ],
    ); */
  }

  Widget getbodyvodafonecache() {
    return Padding(
        padding: const EdgeInsets.only(top: 25, right: 20, left: 20, bottom: 7),
        child: CustomTextField(
          bordercolor: CustomColors.MainColor,
          hint: translator.translate("enter phone"),
          w: 60,
          type: TextInputType.number,
          completetext: () {
          
          },
          controller: phonecontroller,
          OnTab: () {},
        ));
  }
}

/*  GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      presswallet = true;
                                                      pressbank = false;
                                                      presscash = false;
                                                    });
                                                  },
                                                  child: Container(
                                                    color: presswallet
                                                        ? CustomColors.MainColor
                                                        : Colors.white,
                                                    width: 80,
                                                    height: 50,
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            "assets/bank-wallet icon -01.svg"),
                                                        SizedBox(width: 3),
                                                        Text(
                                                            translator
                                                                .translate(
                                                                    "mofaz"),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'ReadexPro',
                                                              fontSize: 13,
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ), */
 */


/*PaymentSdkConfigurationDetails generateConfigg() {
    var billingDetails = BillingDetails("John Smith", "email@domain.com",
        "+97311111111", "st. 12", "eg", "dubai", "dubai", "12345");
    var shippingDetails = ShippingDetails("John Smith", "email@domain.com",
        "+97311111111", "st. 12", "eg", "dubai", "dubai", "12345");
    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.AMAN);
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "122125",
        serverKey: "SBJNKTLW6J-J6KZMHHZW2-JHBHTJRDZD",
        clientKey: "C6KM7G-T7DK6G-K9NHH9-QMN6HV",
        cartId: "cart id",
        merchantName: "merchant name",
        locale: PaymentSdkLocale
            .AR, //PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
        amount: double.parse(totalamount), //amount in double
        currencyCode: "EGP",
        merchantCountryCode: "EG",
        billingDetails: billingDetails,
        shippingDetails: shippingDetails
        //2 chars iso country code
        );

    final theme = IOSThemeConfigurations();
    theme.logoImage = "assets/logo.png";
    theme.backgroundColor = "e0556e"; // Color hex value
    configuration.iOSThemeConfigurations = theme;
    configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
    return configuration;
  } */