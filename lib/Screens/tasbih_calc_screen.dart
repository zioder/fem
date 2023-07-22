import 'dart:async';
import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:femv2/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TasbihCalcScreen extends StatefulWidget {
  const TasbihCalcScreen({Key? key}) : super(key: key);

  @override
  _TasbihCalcScreenState createState() => _TasbihCalcScreenState();
}

class _TasbihCalcScreenState extends State<TasbihCalcScreen> {
  late SpeechToText _speech;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speech = SpeechToText();
  }

  var data = Get.arguments;
  bool isButtonActive = true;
  bool isFirstTime = true;
  var isMicmode = true;
  bool isListenning = false;
  late String _text = data[0];

  void buttonset(double duration) {
    Timer(Duration(seconds: duration.toInt()), () {
      setState(() {
        isButtonActive = !isButtonActive;
      });
    });
  }

  double DurationCalc(String text) {
    return text.split(' ').length * 0.4;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: lightprimaryColor,
        title: Text('تسبيح'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          textDirection: TextDirection.rtl,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: !isMicmode?darkgreenColor: superlightgreenColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(data[0],
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 40)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(_text,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 40, color: lightprimaryColor)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Center(
                    child: Container(
                      width: 150.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.grey.shade200.withOpacity(0.15)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              data[2].toString(),
                              style: TextStyle(
                                  color: isMicmode
                                      ? lightgreenColor
                                      : darkgreenColor,
                                  fontSize: 80),
                            ),
                            Text('/'),
                            Text(data[1].toString())
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: GestureDetector(
                onDoubleTap: isFirstTime
                    ? () {
                        Get.snackbar('لا تتسرع', 'خذ وقتك في التسبيح',
                            snackPosition: SnackPosition.BOTTOM);
                        setState(() {
                          isFirstTime = false;
                        });
                      }
                    : null,
                onTap: isButtonActive
                    ? () {
                        FirebaseFirestore.instance
                            .collection('user')
                            .doc(user!.uid)
                            .collection('tasbehaat')
                            .doc(data[3])
                            .update({'currentExec': data[2] + 1});
                        setState(() {
                          data[2] = data[2] + 1;
                          isButtonActive = !isButtonActive;
                        });

                        buttonset(DurationCalc(data[0]));
                        _verifyifcomplete(data[1], data[2]);
                      }
                    : null,
                child: isMicmode
                    ? AnimatedContainer(
                  duration: const Duration(microseconds: 200),
                        child: Icon(Icons.add),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: .25),
                            borderRadius: BorderRadius.circular(15.0),
                            gradient: LinearGradient(
                                colors: isButtonActive
                                    ? [Colors.greenAccent, superlightgreenColor]
                                    : [lightprimaryColor, primaryColor])),
                        height: 250,
                        width: double.infinity,
                      )
                    : Center(
                        child: AvatarGlow(
                          child: FloatingActionButton(
                            child:
                                Icon(isListenning ? Icons.mic : Icons.mic_none),
                            onPressed: () {
                              _listen();
                            },
                          ),
                          endRadius: 60,
                          animate: isListenning,
                          glowColor: lightgreenColor,
                          duration:
                              Duration(seconds: DurationCalc(data[0]).toInt()),
                        ),
                      ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isMicmode = !isMicmode;
                });
              },
              child: isMicmode
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'وضع التسبيح بالصوت',
                          style: TextStyle(color: Colors.cyan),
                        ),
                        Icon(
                          Icons.mic,
                          color: Colors.cyan,
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'وضع التسبيح اليدوي الذكي',
                          style: TextStyle(color: superlightgreenColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.touch_app,
                          color: darkgreenColor,
                        )
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  void _verifyifcomplete(int tobe, int done) {
    if (tobe == done) {
      setState(() {
        data[4] = 1;
        isButtonActive = false;
      });
      FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .collection('tasbehaat')
          .doc(data[3])
          .update({'isCompleted': 1});
      Get.snackbar('مبروك', 'عمل جيد');
      Get.back(closeOverlays: true);
    }
  }

  void _listen() async {
    if (!isListenning) {
      bool available = await _speech.initialize(onError: (val) {
        if (val ==
            'SpeechRecognitionError msg: error_speech_timeout, permanent: true') {
          setState(() {
            isListenning = false;
          });
        }
      });
      if (available) {
        setState(() => isListenning = true);
        _speech.listen(
          localeId: 'ar-SA',
          listenFor: Duration(seconds: DurationCalc(data[0]).toInt() + 5),
          partialResults: false,
          onResult: (val) {
            setState(() {
              _text = val.recognizedWords;
              print(_speech.locales().toString());
              if (val.hasConfidenceRating && val.confidence > 0) {
              }
            });
            _textgetter();
            _scantext(_text);
            _listen();
          },
        );
      }
    } else {
      setState(() => isListenning = false);
      _speech.stop();
    }
  }

  void _textgetter() async {
    await FlutterClipboard.copy(_text);
  }

  void _scantext(String rawText) async {
    if (rawText.contains(data[0])) {
      print('+1');
      FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .collection('tasbehaat')
          .doc(data[3])
          .update({'currentExec': data[2] + 1});
      setState(() {
        data[2] = data[2] + 1;
        isButtonActive = !isButtonActive;
      });
      setState(() {
        _text = '';
        isButtonActive = false;
      });
      _verifyifcomplete(data[2], data[1]);
      _listen();
    } else {
      print('mismatch');
      Get.snackbar('خطأ', 'حاول عدم التسرع', duration: Duration(seconds: 1));
      setState(() {
        _text = '';
      });
      _listen();
      _verifyifcomplete(data[2], data[1]);
    }
  }
}
