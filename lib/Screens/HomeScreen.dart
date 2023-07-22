import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:femv2/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:femv2/Screens/tasbih_calc_screen.dart';
import 'package:femv2/models/aya_of_the_day.dart';
import 'package:femv2/services/api_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:femv2/data/tasbiha_data.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'add_tasbiha_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  var isHijri = false;
  var day = DateTime.now();
  var format = DateFormat('MMM ,dd , YYYY');
  var _hijri = HijriCalendar.now();
  var Ayanumber = 1;


  @override
  ApiServices _apiServices = ApiServices();
  AyaOfTheDay? data;

  Widget build(BuildContext context) {
    random(min, max) {
      var rn = new Random();
      return min + rn.nextInt(max - min);
    }

    _apiServices
        .getAyaOfTheDay(Ayanumber.toString())
        .then((value) => data = value);
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: ListView(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            colors: [primaryColor, lightprimaryColor])),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height : 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                      image: NetworkImage('https://i.ibb.co/L68XMgY/14705878-919709238135411-4494628516392943593-n.jpg')
                                  ),
                                ),
                              ),
                              Text(
                                '!أهلا زياد ',
                                style: TextStyle(fontSize: 40,fontWeight: ui.FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder<TasbihaData>(
                    stream: readLatestTasbiha(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return GestureDetector(
                          onTap: (){
                            showModalBottomSheet(
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                              context: context,
                              builder: (context) => AddTasbihaPage(),
                            );
                          },
                            child: Container(
                                margin: EdgeInsets.all(20),
                                padding: EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [
                                      lightprimaryColor,
                                      Colors.greenAccent
                                    ])),
                                child: Text('أضف تسبيحة جديدة الان'),),);
                      } else {
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () {
                                return TasbihCalcScreen();
                              },
                              transition: Transition.leftToRight,
                              duration: Duration(milliseconds: 300),
                              arguments: [
                                snapshot.data!.TasbihaText!,
                                snapshot.data!.tobeExec!,
                                snapshot.data!.currentExec!,
                                snapshot.data!.id!,
                                snapshot.data!.isCompleted!
                              ],
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(colors: [
                                  lightprimaryColor,
                                  Colors.greenAccent
                                ])),
                            child: Column(
                              children: [
                                Text('واصل اخر تسبيحة لك '),
                                Divider(
                                  thickness: 2,
                                  color: Colors.white,
                                ),
                                AutoSizeText(
                                  snapshot.data!.TasbihaText!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                      fontFamily: 'QuranSurah',
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: ClipRect(
                                    child: Center(
                                      child: Container(
                                        width: 150,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            color: Colors.white),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                snapshot.data!.currentExec!
                                                    .toString(),
                                                style: TextStyle(
                                                    color: darkgreenColor,
                                                    fontSize: 80),
                                              ),
                                              Text('/'),
                                              Text(snapshot.data!.tobeExec
                                                  .toString()),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient:
                        LinearGradient(colors: [lightprimaryColor,Theme.of(context).colorScheme.secondary,]),
                  ),
                  child: Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20) ,
                          decoration: BoxDecoration(
                            color: lightgreenColor,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topRight: Radius.circular(20))
                          ),


                            child: Column(
                              children: [
                                Text('الصلاة القادمة '),
                                Text(
                                  'الظهر',
                                  style: TextStyle(

                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'QuranSurah',
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            )),
                        Text(
                          '12',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '12',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '12',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        ADonePrayerNotif()
                        
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [lightprimaryColor, Theme.of(context).colorScheme.primary])),
                child: Column(
                  children: [
                    Text(
                      'اية اليوم',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Divider(
                      thickness: 2,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: ClipRect(
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).colorScheme.primary),
                            child: Center(
                              child: FutureBuilder<AyaOfTheDay>(
                                  future: _apiServices
                                      .getAyaOfTheDay(Ayanumber.toString()),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                        return Icon(Icons.sync_problem);
                                      case ConnectionState.waiting:
                                      case ConnectionState.active:
                                        return CircularProgressIndicator();
                                      case ConnectionState.done:
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          textDirection: ui.TextDirection.rtl,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Theme.of(context).colorScheme.secondary),

                                              child: Column(
                                                children: [
                                                  AutoSizeText(
                                                    snapshot.data!.arName!,
                                                    maxFontSize: 30,
                                                    maxLines: 1,
                                                    minFontSize: 20,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'QuranSurah',
                                                        color:
                                                            lightprimaryColor,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  Text(
                                                    snapshot.data!.surNumber!
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              Ayanumber = 1;
                                                            });
                                                          },
                                                          icon: Icon(
                                                              Icons.looks_one)),
                                                      IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              if (Ayanumber >=
                                                                  2) {
                                                                Ayanumber =
                                                                    Ayanumber -
                                                                        1;
                                                              }
                                                            });
                                                          },
                                                          icon: Icon(Icons
                                                              .fast_rewind)),
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            Ayanumber =
                                                                random(1, 6237);
                                                          });
                                                        },
                                                        icon: Icon(
                                                            Icons.restart_alt),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          if (Ayanumber <=
                                                              6237) {
                                                            setState(() {
                                                              Ayanumber =
                                                                  Ayanumber + 1;
                                                            });
                                                          }
                                                        },
                                                        icon: Icon(
                                                            Icons.fast_forward),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.all(10),
                                                    padding: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context).colorScheme.primary,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  15),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15),
                                                        )),
                                                    child: Text(
                                                        'الاية عدد: ${snapshot.data!.surNumberInSurah!.toString()}'),
                                                  )
                                                ],
                                              ),
                                            ),
                                            AutoSizeText(
                                              snapshot.data!.arText!,
                                              maxLines: 4,
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'QuranSurah'),
                                              textDirection:
                                                  ui.TextDirection.rtl,
                                            ),
                                          ],
                                        );
                                    }
                                  }),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  User? user = FirebaseAuth.instance.currentUser;

  Stream<TasbihaData> readLatestTasbiha() => FirebaseFirestore.instance
      .collection('user')
      .doc(user!.uid)
      .collection('tasbehaat')
      .orderBy('date', descending: true)
      .snapshots()
      .map((event) =>
          event.docs.map((e) => TasbihaData.fromJson(e.data())).toList()[0]);
}

class ADonePrayerNotif extends StatefulWidget {

  @override
  State<ADonePrayerNotif> createState() => _ADonePrayerNotifState();
}
enum Sizes { extraSmall, small, medium, large, extraLarge }
class _ADonePrayerNotifState extends State<ADonePrayerNotif> {
  Set<Sizes> selection = <Sizes>{Sizes.large, Sizes.extraLarge};

  @override
  Widget build(BuildContext context,) {
    var enablednotif = true;
    return SegmentedButton<Sizes>(
      segments:  <ButtonSegment<Sizes>>[
        ButtonSegment<Sizes>(value: Sizes.extraSmall, label:  Icon(Icons.notifications_active) ),
        ButtonSegment<Sizes>(value: Sizes.small, label: Text('الفجر')),
      ],
      selected: selection,
      onSelectionChanged: (Set<Sizes> newSelection) {
        setState(() {
          selection = newSelection;
          enablednotif=!enablednotif;
          print(enablednotif);
        });
      },
      multiSelectionEnabled: true,
    );
  }
}


class InfoCard extends StatefulWidget {
  final String title;
  final String body;
  final Function() onMoreTap;

  final String subInfoTitle;
  final String subInfoText;
  final Widget subIcon;

  const InfoCard(
      {required this.title,
      this.body = """يوم الثلاثاء يوم خلق المكروه""",
      required this.onMoreTap,
      this.subIcon = const CircleAvatar(
        child: Icon(
          Icons.directions,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        radius: 25,
      ),
      this.subInfoText = "545 miles",
      this.subInfoTitle = "Directions",
      Key? key})
      : super(key: key);

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              offset: Offset(0, 10),
              blurRadius: 0,
              spreadRadius: 0,
            )
          ],
          gradient: RadialGradient(
            colors: [Colors.orangeAccent, Colors.orange],
            focal: Alignment.topCenter,
            radius: .85,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: 75,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  gradient: LinearGradient(
                      colors: [Colors.white, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: GestureDetector(
                  onTap: widget.onMoreTap,
                  child: Center(
                      child: Text(
                    "More",
                    style: TextStyle(color: Colors.orange),
                  )),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            widget.body,
            style:
                TextStyle(color: Colors.white.withOpacity(.75), fontSize: 14),
          ),
          SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  widget.subIcon,
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.subInfoTitle),
                      Text(
                        widget.subInfoText,
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
