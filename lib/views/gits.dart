
// ignore_for_file: deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace

import 'package:esh7enly/Services/features/points.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/core/widgets/customtext.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  PointApi obj = PointApi();
  String? points = "0";
  @override
  void initState() {
    getpoints();
     _controller = VideoPlayerController.asset('assets/animation_lnr9tf6n.mp4');
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();
    // Use the controller to loop the video.
    _controller.setLooping(true);
    setState(() {
      _controller.play();
    });

    super.initState();
  }

  getpoints() {
    obj.getpoints().then((value) {
      if (value == false) {
        DailogAlert.openAlert(translator.translate("unauth"), translator.translate( "failedmessage"), context);
      }
      setState(() {
        points = value;
      });
    });
  }

  @override
  void dispose() {
// Ensure disposing of the VideoPlayerController to free up resources.
    _controller.pause();
    _controller.dispose();

    super.dispose();
  }

//ists[index].name_ar.toString()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:  Directionality(
            textDirection:
                // ignore: unrelated_type_equality_checks
                translator.currentLanguage == 'en'
                    ? TextDirection.ltr
                    : TextDirection.rtl,child:Column(
          children: [
            Container(
              // height 100
                height: 90,width: 400,
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
                    //top 50
                      padding: EdgeInsets.only(right: 50, left: 50, top: 45),child:
                   Text(
                        translator.translate("gift"),
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'ReadexPro',
                          color: Colors.white,
                        ),
                      )))),
                 
                
            Padding(
              padding: EdgeInsets.only(top: 50, right: 20, left: 15),
              child: Container(
                  width: 380,
                  height: 190,
                  child: Card(
                    color: Colors.white,
                    elevation: 3,
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 1, right: 23, left: 23),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(
                        7,
                      ),
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 40,
                      ),
                      customtext(
                        maxLine: 2,
                        color: CustomColors.MainColor,
                        fontSize: 22,
                        fontfamily: 'ReadexPro',
                        text: translator.currentLanguage == 'en'
                    ?  'you have  $points  Point':' لديك $points نقطه ',
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () async {
                          EasyLoading.show(
                              status: translator.currentLanguage == 'ar'
                                  ? 'جاري التحميل '
                                  : 'loading...',
                              maskType: EasyLoadingMaskType.black);
                          await obj.replacepoints().then((value) {
                            EasyLoading.dismiss();
                        
                            openAlert(value['message'],
                                value['status'] == false ? translator.translate("failedmessage") : translator.translate("suceessmessage"));
                          });
                        },
                        child: Container(
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 47),
                          decoration: BoxDecoration(
                            color: CustomColors.MainColor,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Center(
                            child: Text(
                              translator.currentLanguage == 'en'
                    ? 'Replace Points':"استبدل النقاط",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'ReadexPro',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ]),
                  )),
            ),
            Container(
              //color: Colors.white,
              alignment: Alignment.center,
              child: SizedBox(
                height: 330,
                width: 330,
                child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    );
                  },
                ),
              ),
            )
          ],
        )));
  }

  void openAlert(String mess, String status) {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: Container(
        height: 140.0,
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
                child: Text(status,
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 9,
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
                        Get.back();
                      },
                      color: CustomColors.MainColor,
                      // ignore: sort_child_properties_last
                      child: Text(
                       translator.currentLanguage=='en'?'OK':'موافق',
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
}

/* FutureBuilder(
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
                        children: List.generate(snapshot.data.length, (index) {
                          return Padding(
                              // ignore: prefer_const_constructors
                              padding: EdgeInsets.only(
                                  right: 10, left: 10, top: 10, bottom: 5),
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
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
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
                                            text: translator.currentLanguage ==
                                                    'ar'
                                                ? snapshot.data[index].name_ar
                                                : snapshot.data[index].name_en
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
        }); */

        /////real///
        ///
        /*import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esh7enly/Services/features/CategryApi.dart';
import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/core/widgets/customtext.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Provider> lists = [];
  int categoryid = Get.arguments;

  Future refreshproviders() async {
    print("db $categoryid");
    //this.lists = await ProviderDatabase.instance.readAllNotes();
    await ProviderDatabase.instance.readAllNotes().then((value) {
      setState(() {
        lists = value
            .where((element) => element.category_id == categoryid)
            .toList();
      });
    });
    print(lists.length);
  }

  Future createprovider() async {
    // ignore: prefer_const_constructors

    // ignore: prefer_const_constructors
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
      print(value.length);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    //createprovider();
    //readdata();
    refreshproviders();
    super.initState();
  }

//ists[index].name_ar.toString()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: 800,
            child: Scrollbar(
                child: SizedBox(
                    height: lists.length == 0 ? 0 : 600,
                    child: Scrollbar(
                        child: GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            crossAxisSpacing: 0,
                            //  childAspectRatio: 23 / 12,
                            childAspectRatio: 24 / 16,
                            mainAxisSpacing: 0,
                            scrollDirection: Axis.vertical,
                            children: List.generate(lists.length, (index) {
                              return SizedBox(
                                  width: 50,
                                  height: 60,
                                  child: Padding(
                                      // ignore: prefer_const_constructors
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
                                          color: CustomColors.MainColor,
                                          elevation: 3,
                                          clipBehavior: Clip.antiAlias,
                                          shape: RoundedRectangleBorder(
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
                                                  Container(
                                                    width: 70,
                                                    height: 39,
                                                    child: lists[index]
                                                            .logo!
                                                            .isEmpty
                                                        ? Image.asset(
                                                            'assets/logo.png')
                                                        : CachedNetworkImage(
                                                            imageUrl:
                                                                "https://system.e-esh7nly.net/storage/${lists[index].logo}",
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
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontweight: FontWeight.bold,
                                                  )
                                                ]),
                                          )),
                                        ),
                                      )));
                            })))))));
  }
}
 */