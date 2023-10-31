import 'package:flutter/material.dart';
class PrayerScreen extends StatefulWidget {

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30)
            )
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text('الظهر'),
            ],
          ),
        )

      ],
    );
  }
}


