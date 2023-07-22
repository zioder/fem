import 'dart:async';

import 'package:femv2/Screens/Componnents/bodysp.dart';
import 'package:femv2/Screens/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);
static String routeName= "/SignInScreen";

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }
  startTime() async {
    var duration = Duration(seconds: 4);
    return  Timer(duration, route);
  }

  route() {
      Get.to((){
        return SignInScreen();
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
