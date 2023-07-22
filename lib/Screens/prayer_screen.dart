import 'package:femv2/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          children: [
            NextPrayerCard(width: width, height: height)

          ],
        ),

      ),
    );
  }

class NextPrayerCard extends StatelessWidget {
  const NextPrayerCard({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ,
      height: height/3,
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
        )
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(DateTime.now().toString())
            ],
          )
        ],
      )
      
      ,
    );
  }
}

class PrayerCard extends StatelessWidget {
  const PrayerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Theme.of(context).colorScheme.primary,height: 200,width: 200,);
  }
}


