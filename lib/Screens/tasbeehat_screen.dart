
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:femv2/cards/tasbiha_card.dart';
import 'package:femv2/constants.dart';
import 'package:femv2/data/tasbiha_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'add_tasbiha_page.dart';

class TabssehatScreen extends StatefulWidget {
  const TabssehatScreen({Key? key}) : super(key: key);

  @override
  _TabssehatScreenState createState() => _TabssehatScreenState();
}

class _TabssehatScreenState extends State<TabssehatScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text('تسبيحاتك',style: TextStyle(
          fontSize: 30
        ),),
        centerTitle: true,
      ),
      body: StreamBuilder<List<TasbihaData>>(
        stream: readTasbehat(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return ListView(
              children: snapshot.data!.map((e) => Padding(
                padding: EdgeInsets.all(10),
                  child: TasbihaCard(tasbihaData: e))).toList(),
            );
          }else if (snapshot.connectionState==ConnectionState.waiting){
            return Center(child: const CircularProgressIndicator());
          }else if(!snapshot.hasData) {
            return Center(
              child: Text('لا توجد أي تسبيحة بحسابك الرجاء إضافة واحدة عن طريق الزر أسفله'),
            );
          }else {
            return Center(child: const CircularProgressIndicator());
          }
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: primaryColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightprimaryColor,
        child: new Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            context: context,
            builder: (context) => AddTasbihaPage(),
          );
        },
      ),
    );
  }
  User? user=FirebaseAuth.instance.currentUser;
  Stream<List<TasbihaData>> readTasbehat() => FirebaseFirestore.instance.collection('user').doc(user!.uid).collection('tasbehaat').orderBy('date',descending: true)
      .snapshots().map((event) => event.docs.map((e) => TasbihaData.fromJson(e.data())).toList());






  Column buildColumn() {
    return Column(
      children: [
        Text('test'),
      ],
    );
  }
}

/*if (snapshot.hasData) {
                  return Column(
                    children: [
                      const Center(
                        child: Text(
                          'تسبيحاتك',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Expanded(
                          child: TasbihaCard(
                            tasbihaData: TasbihaData(
                                TasbihaText: 'بسم الله',
                                remind: 0,
                                id: 1,
                                isCompleted: 0,
                                currentExec: 30,
                                tobeExec: 50),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Expanded(
                          child: TasbihaCard(
                            tasbihaData: TasbihaData(
                                TasbihaText: 'الحمد لله والله اكبر',
                                remind: 0,
                                id: 1,
                                isCompleted: 1,
                                currentExec: 20,
                                tobeExec: 50),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Expanded(
                          child: TasbihaCard(
                            tasbihaData: TasbihaData(
                                TasbihaText: 'سبحان الله وبحمده عدد خلقه ، ورضا نفسه،وزنة عرشه،ومداد كلماته ',

                                remind: 0,
                                id: 1,
                                isCompleted: 1,
                                currentExec: 20,
                                tobeExec: 50),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Expanded(
                          child: TasbihaCard(
                            tasbihaData: TasbihaData(
                                TasbihaText: 'اللّهُمَّ إنّي أسألُكَ الْيُسْرَ بَعْدَ الْعُسْرِ ، وَ الْفَرَجَ بَعْدَ الْكَرْبِ ، وَ الرَّخاءَ بَعْدَ الشِّدَةِ ، اللّهُمَّ ما بِنا مِنْ نِعْمَةٍ فَمِنْكَ ، لا إله إلّا أنتَ ، أَسْتَغْفِرُكَ وَ أتُوبُ إلَيْكَ',
                                remind: 0,
                                id: 1,
                                isCompleted: 1,
                                currentExec: 20,
                                tobeExec: 50),
                          ),
                        ),
                      ),
                    ],
                  ); */
