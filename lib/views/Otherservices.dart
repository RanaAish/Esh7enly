// ignore_for_file: unused_import, deprecated_member_use, unnecessary_string_interpolations, file_names
import 'package:esh7enly/models/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../Services/features/CategryApi.dart';
import '../core/utils/colors.dart';
import '../core/widgets/customtext.dart';
import 'Provider/providerview.dart';

class OtherServices extends StatefulWidget {
  const OtherServices({super.key});

  @override
  State<OtherServices> createState() => _OtherServicesState();
}

class _OtherServicesState extends State<OtherServices> {
  late List<Categorymodel> lists = [];
  final CategoryApi _categoryApi = CategoryApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _categoryApi.getcategoriess(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                    height: snapshot.data.length == 0 ? 0 : 600,
                    child: Scrollbar(
                        child: GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            crossAxisSpacing: 0,
                            //  childAspectRatio: 23 / 12,
                            childAspectRatio: 24 / 16,
                            mainAxisSpacing: 0,
                            scrollDirection: Axis.vertical,
                            children:
                                List.generate(snapshot.data.length, (index) {
                              return Padding(
                                  // ignore: prefer_const_constructors
                                  //10 10 10 5
                                  padding: const EdgeInsets.only(
                                      right: 16, left: 16, top: 20, bottom: 2),
                                  child: GestureDetector(
                                    onTap: () {
                                    /*  Get.to(providerview(),
                                          arguments: snapshot.data[index].id); */
                                    },
                                    child: Card(
                                      elevation: 3,
                                          clipBehavior: Clip.antiAlias,
                                          shape: RoundedRectangleBorder(
                                              side:  BorderSide(
                                                  color:
                                                      CustomColors.MainColor),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/logo.png",
                                                width: 70,
                                                height: 50,
                                              ),
                                              /*Image.network(
                                                "https://system.e-esh7nly.net/storage/${snapshot.data[index].icon}",
                                                width: 70,
                                                height: 50,
                                              ), */
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Center(
                                                  child: customtext(
                                                text: translator
                                                            .currentLanguage ==
                                                        'ar'
                                                    ? snapshot
                                                        .data[index].name_ar
                                                    : snapshot
                                                                .data[index]
                                                                .name_en
                                                                .length >=
                                                            18
                                                        ? '${snapshot.data[index].name_en.toString().substring(0, 15)}'
                                                        : '${snapshot.data[index].name_en}',
                                                maxLine: 1,
                                                fontSize: 17,
                                                color: CustomColors.MainColor,
                                                fontweight: FontWeight.bold,
                                                alignment: Alignment.center,
                                              ))
                                            ]),
                                      )),
                                    ),
                                  ));
                            }))));
              } else {
                // ignore: prefer_const_literals_to_create_immutables
                return const Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    Center(
                      child: CircularProgressIndicator(
                          // color: CustomColors.MainColor,
                          ),
                    )
                  ],
                );
              }
            }));
  }
}
