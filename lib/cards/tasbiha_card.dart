import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:femv2/Screens/tasbih_calc_screen.dart';
import 'package:femv2/constants.dart';
import 'package:femv2/data/tasbiha_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasbihaCard extends StatelessWidget {
  const TasbihaCard({Key? key, required this.tasbihaData}) : super(key: key);
  final TasbihaData tasbihaData;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return GestureDetector(
      onLongPress: () {
        Get.defaultDialog(
            title: 'هل تريد حذف هذه التسبيحة',
            content: ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('user')
                      .doc(user!.uid)
                      .collection('tasbehaat')
                      .doc(tasbihaData.id)
                      .delete();
                  Get.back();
                },
                child: Text('حذف')));
      },
      onTap: () {
        tasbihaData.isCompleted == 0
            ? Get.to((){return TasbihCalcScreen();},
                transition: Transition.rightToLeft,
                duration: Duration(milliseconds: 300),
                arguments: [
                    tasbihaData.TasbihaText,
                    tasbihaData.tobeExec,
                    tasbihaData.currentExec,
                    tasbihaData.id,
                    tasbihaData.isCompleted
                  ])
            : null;
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            gradient: tasbihaData.isCompleted == 0
                ? LinearGradient(colors: [lightprimaryColor, darkgreenColor])
                : LinearGradient(
                    colors: [Colors.redAccent, superlightgreenColor])),
        child: Stack(
          children: [
            Align(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Row(
                    children: [
                      Column(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tasbihaData.TasbihaText!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${tasbihaData.currentExec}/${tasbihaData.tobeExec}',
                            style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ),
                          if (tasbihaData.isCompleted == 0)
                            Row(
                              children: [
                                Text('غير مكتملة'),
                                Icon(Icons.do_not_disturb_off)
                              ],
                            )
                          else
                            Row(
                              children: [Text('مكتملة'), Icon(Icons.done)],
                            )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
