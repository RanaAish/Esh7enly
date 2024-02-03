// ignore_for_file: deprecated_member_use, prefer_const_constructors, unnecessary_string_interpolations

import 'package:carousel_slider/carousel_slider.dart';
import 'package:esh7enly/Services/features/CategryApi.dart';
import 'package:esh7enly/Services/features/banner.dart';
import 'package:esh7enly/core/utils/colors.dart';

import 'package:esh7enly/core/widgets/customtext.dart';

import 'package:esh7enly/core/widgets/header.dart';
import 'package:esh7enly/db/providerdb.dart';
import 'package:esh7enly/db/servicedb.dart';

import 'package:esh7enly/models/skelton.dart';
import 'package:esh7enly/views/Provider/providerview.dart';
//import 'package:esh7enly/views/provider/providerview.dart';
import 'package:esh7enly/views/results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:localize_and_translate/localize_and_translate.dart';

import '../../db/categoriesdb.dart';
import '../core/widgets/customebuttunwithicon.dart';
import 'MobileCategory.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<home> {
  final CategoryApi _categoryApi = CategoryApi();
  bool search = false;
  TextEditingController controller = TextEditingController();
  bool tab = false;
  List categories = [];
  final storage = const FlutterSecureStorage();
  String? username;
  TextEditingController searchcontroller = TextEditingController();
  List searchitems = [];
  bool issearching = false;
  List items = [];
  BannerApi poster = BannerApi();
  CarouselController control = CarouselController();
  List<Widget> list = [
    Image.asset(
      'assets/Artboard.png',
    ),
    Image.asset(
      'assets/flex.jpeg',
    ),
    Image.asset('assets/img2.jpeg'),
    Image.asset(
      'assets/img3.jpeg',
    )
  ];
  filttercategories() {
    if (searchcontroller.text.isNotEmpty) {
      var filteredservices = [];
      RegExp exp = RegExp("^[a-zA-Z0-9]*");
      exp.allMatches(searchcontroller.text).forEach((match) {
        if (match.group(0) != "") {
          for (var serv in categories) {
            if (serv.name_en.contains(searchcontroller.text)) {
              filteredservices.add(serv);
            }
          }
        }
      });
      setState(() {
        searchitems = filteredservices;
      });
    }
  }

  getusername() async {
    await storage.read(key: 'name').then((value) {
      setState(() {
        username = value!;
      });
    });
  }

  List providers = [];

  Future refrescategories() async {
    //this.lists = await ProviderDatabase.instance.readAllNotes();
      await ServiceDatabase.instance.readAllservices().then((v) {
         setState(() {
        //  print('len ${value.length}');
       providers = v.toList();
      });
    });
    await categoryDatabase.instance.readAllNotes().then((value) {
      setState(() {
        //  print('len ${value.length}');
        categories = value.toList();
      });
    });
    //  print(lists.length);
  }

  @override
  void initState() {
    _categoryApi.getallcategoriess();
    refrescategories();
    poster.getimages().then((value) {
      setState(() {
        for (var obj in value) {
          items.add("https://e-esh7nly.org/storage/${obj.banner}");
        }
      });
    });
    getusername();

    /*_categoryApi.getallcategoriess().then((value) {
      setState(() {
        if (value.length == 0) {
          DailogAlert.openAlert( "Unauthenticated Login", "Faild",context);
          
        }
        categories = value;
        print('uu');
        print(value);
      });
    }); */
    searchcontroller.addListener(() {
      filttercategories();
    });
    super.initState();
  }

  void onchangedtext(String value) {
    setState(() {
      search = true;
    });

    if (value.isEmpty) {
      setState(() {
        search = false;
      });
    }
  }

  double defaultPadding = 16.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Directionality(
          textDirection:
              // ignore: unrelated_type_equality_checks
              translator.currentLanguage == 'en'
                  ? TextDirection.ltr
                  : TextDirection.rtl,
          child: Column(
            children: [
              header(
                heightcon: 220,
              ),
              const SizedBox(
                height: 20,
              ),
              translator.currentLanguage == 'en'
                  ? Text(" ${translator.translate("welcomhome")} $username ",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ReadexPro',
                          fontSize: 17,
                          color: CustomColors.MainColor))
                  : Text(" ${translator.translate("welcomhome")} $username ",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ReadexPro',
                          fontSize: 17,
                          color: CustomColors.MainColor)),
              const SizedBox(
                height: 22,
              ),
              /*  CustomButtonIcon(
                onPress: () {},
                url: "assets/icon-10(search).svg",
                w: 60,
                h: 40,
                wicon: 30,
                hicon: 55,
                color: CustomColors.MainColor,
              ), */
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                        padding: EdgeInsets.zero,
                        margin: const EdgeInsets.only(right: 10, left: 5),
                        child: Card(
                            child: SizedBox(
                                width: 230,
                                height: 40,
                                child: ListTile(
                                  onTap: () {},
                                  title: TextField(
                                    controller: searchcontroller,
                                    onTap: () {
                                      controller.selection =
                                          TextSelection.collapsed(
                                              offset: controller.text.length);
                                    },
                                    onChanged: onchangedtext,
                                    decoration: const InputDecoration(
                                        hintText: 'بحث',
                                        border: InputBorder.none),
                                  ),
                                ))))),
                CustomButtonIcon(
                  onPress: () {
                    setState(() {
                      // searchcontroller.clear();
                      // print('searchtext ${searchcontroller.text}');
                      Get.to(const Results(), arguments: searchcontroller.text);
                    });
                  },
                  url: "assets/icon-10(search).svg",
                  w: 60,
                  h: 40,
                  wicon: 30,
                  hicon: 55,
                  color: CustomColors.MainColor,
                )
                ////comment
              ]),
              SizedBox(
                height: 6,
              ),
              SizedBox(
                  height: tab == false ? 130 : 650,
                  width: 500,
                  child: FutureBuilder(
                      future: refrescategories(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (providers.isEmpty) {
                          return const Padding(
                              padding:
                                  EdgeInsets.only(right: 10, left: 25, top: 17),
                              child: Row(children: [
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Skeleton(height: 90, width: 100),
                                        SizedBox(height: 7),
                                        Skeleton(width: 100),
                                      ]),
                                ),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Skeleton(height: 90, width: 100),
                                        SizedBox(height: 7),
                                        Skeleton(width: 100),
                                      ]),
                                ),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Skeleton(height: 90, width: 100),
                                        SizedBox(height: 7),
                                        Skeleton(width: 100),
                                      ]),
                                )
                              ]));
                        } else {
                          return gethome();
                        }
                      })),
              Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Container(
                          color: Color.fromARGB(255, 228, 226, 226),
                          width: 400,
                          height: 120,
                          child: CarouselSlider(
                              carouselController: control,
                              options: CarouselOptions(),
                              items: list
                                  .map((item) => Padding(
                                        padding: EdgeInsets.all(6), //14
                                        child: item,
                                      ))
                                  .toList()))),
                  Positioned(
                    top: 80,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        control.previousPage();
                      },
                      child: SvgPicture.asset("assets/arrow2 .svg",
                          color: CustomColors.MainColor, width: 20, height: 20),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 350,
                    child: GestureDetector(
                      onTap: () {
                        control.nextPage();
                      },
                      child: SvgPicture.asset("assets/arrow .svg",
                          color: CustomColors.MainColor, width: 20, height: 20),
                    ),
                  ),
                ],
              ),
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: SizedBox(
                      width: 350,
                      height: 230,
                      child: CarouselSlider.builder(
                        itemCount: items.length,
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayCurve: Curves.decelerate,
                          aspectRatio: 2.0,
                          enlargeCenterPage: false,
                        ),
                        itemBuilder: (context, index, realIdx) {
                          return Center(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(items[index],
                                      fit: BoxFit.fill,
                                      width: 260,
                                      height: 200)));
                        },
                      ))),

              /*Container(
                  width: 500,
                  height: 150,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:  */
            ],
          )),
    ));
  }

  gethome() {
    //   print("tab $tab");
    return GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        crossAxisSpacing: 0,
        physics: NeverScrollableScrollPhysics(),

        //  childAspectRatio: 23 / 12,
        childAspectRatio: 24 / 19,
        mainAxisSpacing: 0,
        scrollDirection: Axis.vertical,
        children: List.generate(tab == false ? 3 : categories.length, (index) {
          if (index == 0) {
            // print( translator.translate(categories[index].name_ar));
            return Column(
              children: [
                CustomButtonIcon(
                  onPress: () {
                    Get.to(
                        MobileCategory(
                          categoryname: translator.currentLanguage == 'ar'
                              ? translator.translate(categories[13].name_ar)
                              : translator.translate(categories[13].name_en),
                        ),
                        arguments: 28);
                  },
                  url: "assets/icon-08.svg",
                  w: 88,
                  h: 70,
                  wicon: 80,
                  hicon: 80,
                  color: Colors.white,
                  bordercolor: CustomColors.MainColor,
                  coloricon: CustomColors.MainColor,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  translator.translate("mobile services"),
                  style: TextStyle(
                      fontFamily: 'ReadexPro',
                      color: CustomColors.MainColor,
                      fontSize: 13),
                )
              ],
            );
          }
          if (index == 1) {
            return Column(
              children: [
                CustomButtonIcon(
                  onPress: () {
                    Get.to(
                        MobileCategory(
                          categoryname: translator.currentLanguage == 'ar'
                              ? translator.translate(categories[14].name_ar)
                              : translator.translate(categories[14].name_en),
                        ),
                        arguments: 29);
                  },
                  url: "assets/icon-09.svg",
                  w: 90,
                  h: 70,
                  wicon: 80,
                  hicon: 80,
                  color: Colors.white,
                  bordercolor: CustomColors.MainColor,
                  coloricon: CustomColors.MainColor,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  translator.translate("fatoras"),
                  style: TextStyle(
                      fontFamily: 'ReadexPro',
                      color: CustomColors.MainColor,
                      fontSize: 13),
                )
              ],
            );
          }
          if (index == 2 && tab == false) {
            return Column(children: [
              CustomButtonIcon(
                onPress: () {
                  setState(() {
                    tab = true;
                  });
                },
                url: "assets/icon-07.svg",
                w: 79,
                h: 75,
                wicon: 80,
                hicon: 80,
                color: Colors.white,
                coloricon: CustomColors.MainColor,
                bordercolor: CustomColors.MainColor,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                translator.translate("others ser"),
                style: const TextStyle(
                    fontFamily: 'ReadexPro',
                    color: CustomColors.MainColor,
                    fontSize: 13),
              )
            ]);
          }
          if (tab == true) {
            if (index == 13) {
              index = 0;
            }
            if (index == 14) {
              index = 1;
            }
            return

                //10 10 10 5

                GestureDetector(
              onTap: () {
                Get.to(
                    providerview(
                      categoryname: translator.currentLanguage == 'ar'
                          ? translator.translate(categories[index].name_ar)
                          : translator.translate(categories[index].name_en),
                    ),
                    arguments: categories[index].id);
              },
              child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            top: 0, bottom: 2, right: 15, left: 15),
                        child: Card(
                            elevation: 3,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: CustomColors.MainColor),
                                borderRadius: BorderRadius.circular(7.0)),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                    providerview(
                                      categoryname:
                                          translator.currentLanguage == 'ar'
                                              ? translator.translate(
                                                  categories[index].name_ar)
                                              : translator.translate(
                                                  categories[index].name_en),
                                    ),
                                    arguments: categories[index].id);
                              },
                              child: Center(
                                  child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, right: 15, left: 15),
                                child: Image.network(
                                  "https://e-esh7nly.org/storage/${categories[index].logo}",
                                  width: 70,
                                  height: 50,
                                ),
                              )),
                            ))),
                    SizedBox(
                      height: 0,
                    ),
                    Center(
                        child: customtext(
                      text: translator.currentLanguage == 'ar'
                          ? categories[index].name_ar
                          : categories[index].name_en.length >= 18
                              ? categories[index]
                                  .name_en
                                  .toString()
                                  .substring(0, 15)
                              : '${categories[index].name_en}',
                      maxLine: 1,
                      fontSize: 15,
                      color: CustomColors.MainColor,
                      alignment: Alignment.center,
                    ))
                  ]),
            );
          }
          /* SizedBox(
            height: 0,
            width: 0,
          ); */
          return Text("");
        }));
  }

  getsearch() {
    return GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        crossAxisSpacing: 0,
        //  childAspectRatio: 23 / 12,
        childAspectRatio: 24 / 19,
        mainAxisSpacing: 0,
        scrollDirection: Axis.vertical,
        children: List.generate(searchitems.length, (index) {
          return

              //10 10 10 5
              GestureDetector(
            onTap: () {
              Get.to(
                  providerview(
                    categoryname: translator.currentLanguage == 'ar'
                        ? translator.translate(categories[index].name_ar)
                        : translator.translate(categories[index].name_en),
                  ),
                  arguments: searchitems[index].id);
            },
            child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: 0, bottom: 5, right: 15, left: 15),
                      child: Card(
                          elevation: 3,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: CustomColors.MainColor),
                              borderRadius: BorderRadius.circular(7.0)),
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, right: 15, left: 15),
                            child: Image.network(
                              "https://e-esh7nly.org/storage/${searchitems[index].icon}",
                              width: 70,
                              height: 50,
                            ),
                          )))),
                  /*
                                             
                                              
                                               */
                  SizedBox(
                    height: 0,
                  ),
                  Center(
                      child: customtext(
                    text: translator.currentLanguage == 'ar'
                        ? categories[index].name_ar
                        : categories[index].name_en.length >= 18
                            ? '${categories[index].name_en.toString().substring(0, 15)}'
                            : '${categories[index].name_en}',
                    maxLine: 1,
                    fontSize: 15,
                    color: CustomColors.MainColor,
                    alignment: Alignment.center,
                  ))
                ]),
          );
        }));
  }
}
/*   FutureBuilder(
              future: _categoryApi.getallcategoriess(),
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
                                    padding: EdgeInsets.only(
                                        right: 10,
                                        left: 10,
                                        top: 10,
                                        bottom: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(providerview(),
                                            arguments: snapshot.data[index].id);
                                      },
                                      child: Card(
                                        color: CustomColors.MainColor,
                                        elevation: 3,
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Center(
                                            child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.network(
                                                  "https://system.e-esh7nly.net/storage/${snapshot.data[index].icon}",
                                                  width: 70,
                                                  height: 50,
                                                ),
                                                SizedBox(
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
                                                  color: Colors.white,
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
                  return Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const SizedBox(
                        height: 150,
                      ),
                      const Center(
                        child: CircularProgressIndicator(
                            // color: CustomColors.MainColor,
                            ),
                      )
                    ],
                  );
                }
              }) */
