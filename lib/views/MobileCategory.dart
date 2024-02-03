// ignore_for_file: unnecessary_import, deprecated_member_use, prefer_const_constructors, unnecessary_string_interpolations, file_names

import 'package:esh7enly/db/providerdb.dart';
import 'package:esh7enly/models/provider.dart';
import 'package:esh7enly/views/Service/serviceview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esh7enly/Services/features/CategryApi.dart';
import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/core/widgets/customtext.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class MobileCategory extends StatefulWidget {
  final String  categoryname;
  const MobileCategory({super.key,required this.categoryname});

  @override
  State<MobileCategory> createState() => _MobileCategoryState();
}

class _MobileCategoryState extends State<MobileCategory> {
  late List<Provider> lists = [];
  int categoryid = Get.arguments;

  Future refreshproviders() async {
   
    //this.lists = await ProviderDatabase.instance.readAllNotes();
    await ProviderDatabase.instance.readAllNotes().then((value) {
      setState(() {
        lists = value
            .where((element) => element.category_id == categoryid)
            .toList();
      });
    });
 
  }

  Future createprovider() async {

   /* Provider obj = Provider(
      name_ar: "ee",
      name_en: "ll",
      description_ar: "4",
      description_en: "//",
      logo: ';;',
      sort: 2,
    );
    ProviderDatabase.instance.create(obj); */
  }

  CategoryApi categoryApi = CategoryApi();
  readdata() async {
    await categoryApi.getallcategoriess().then((value) {
     
    });
  }

  @override
  void initState() {
   
    //createprovider();
    //readdata();
    refreshproviders();
    super.initState();
  }

//ists[index].name_ar.toString()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SingleChildScrollView(
          scrollDirection: Axis.vertical,
           // height: 1200,
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
              child:Directionality(
                          textDirection: translator.currentLanguage == 'ar'
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          child: Padding(
                            padding: EdgeInsets.only(right: 30, left: 30,top:30),
                            child: Row(children: <Widget>[
              SizedBox(
                   width: 30,
                 
                    child:IconButton(icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 26,
                      ), onPressed: () {   Get.back(); },)
                    ),
                    Center(child:  Text(
                      '   ${widget.categoryname}',
                      style: TextStyle(
                        fontSize: 21,
                        fontFamily: 'ReadexPro',
                        color: Colors.white,
                      
                    )))
           ,
              ])))), SizedBox(
                    height: lists.isEmpty ? 0 :double.parse((lists.length*70).toString()),
                    child: Scrollbar(
                        child: GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            crossAxisSpacing: 0,
                           physics: NeverScrollableScrollPhysics(),
                            //  childAspectRatio: 23 / 12,
                            childAspectRatio: 24 / 16,
                            mainAxisSpacing: 0,
                            scrollDirection: Axis.vertical,
                            children: List.generate(lists.length, (index) {
                              return SizedBox(
                                  width: 50,
                                  height: 60,
                                  child: Padding(
                                     
                                      padding: EdgeInsets.only(
                                          right: 10,
                                          left: 10,
                                          top: 10,
                                          bottom: 5),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(serviceview(),
                                              arguments: lists[index]);
                                        },
                                        child: Card(
                                          //color: CustomColors.MainColor,
                                          elevation: 3,
                                          clipBehavior: Clip.antiAlias,
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color:
                                                      CustomColors.MainColor),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Center(
                                              child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 19, bottom: 10),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 70,
                                                    height: 39,
                                                    child: lists[index]
                                                            .logo!
                                                            .isEmpty
                                                        ? Image.asset(
                                                            'assets/logo.png')
                                                        : CachedNetworkImage(
                                                            imageUrl:
                                                                "https://e-esh7nly.org/storage/${lists[index].logo}",
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
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  customtext(
                                                    text: translator
                                                                .currentLanguage ==
                                                            'ar'
                                                        ? lists[index].name_ar!
                                                        : translator.currentLanguage ==
                                                                'ar'
                                                            ? lists[index]
                                                                .name_ar!
                                                            : lists[index]
                                                                        .name_en!
                                                                        .length >=
                                                                    18
                                                                ? '${lists[index].name_en.toString().substring(0, 15)}'
                                                                : '${lists[index].name_en}',
                                                    maxLine: 1,
                                                    fontSize: 14,
                                                    color:
                                                        CustomColors.MainColor,
                                                    fontweight: FontWeight.bold,
                                                  )
                                                ]),
                                          )),
                                        ),
                                      )));
                            }))))])));
  }
}
