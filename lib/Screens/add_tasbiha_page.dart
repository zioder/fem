


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:femv2/Screens/sign_in/sign_in_page.dart';
import 'package:femv2/constants.dart';
import 'package:femv2/data/tasbiha_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTasbihaPage extends StatefulWidget {
  const AddTasbihaPage({Key? key}) : super(key: key);

  @override
  _AddTasbihaPageState createState() => _AddTasbihaPageState();
}

int Tobexec = 0;
String _selectedTasbiha = 'سبحان الله';

class _AddTasbihaPageState extends State<AddTasbihaPage> {
  final _formkey=GlobalKey<FormState>();
  final TextEditingController _Tobexeccontroller = TextEditingController();
  final TasbehaatList = [
    'سبحان الله',
    'الله أكبر',
    'سبحان الله وبحمده عدد خلقه ، ورضا نفسه،وزنة عرشه،ومداد كلماته ',
    ' اللّهُمَّ إنّي أسألُكَ الْيُسْرَ بَعْدَ الْعُسْرِ ، وَ الْفَرَجَ بَعْدَ الْكَرْبِ ، وَ الرَّخاءَ بَعْدَ الشِّدَةِ ، اللّهُمَّ ما بِنا مِنْ نِعْمَةٍ فَمِنْكَ ، لا إله إلّا أنتَ ، أَسْتَغْفِرُكَ وَ أتُوبُ إلَيْكَ',


  ];
  User? user=FirebaseAuth.instance.currentUser;
  @override

  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: Get.back, icon: Icon(Icons.exit_to_app)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                Text('أضف تسبيحة جديدة')
              ],
            ),
            EmailInputFb2(
              list: TasbehaatList,
              isDrpodwon: false,
              inputController: _Tobexeccontroller,
              title: 'Tasbeeha',
              hint: 'Example 25',
              type: TextInputType.number,
            ),
            EmailInputFb2(
              list: TasbehaatList,
              isDrpodwon: true,
              inputController: _Tobexeccontroller,
              title: 'Number of Tasbehat',
              hint: 'Example 25',
              type: TextInputType.number,
            ),
            SizedBox(height: 60,),
            Align(
              alignment: Alignment.bottomCenter,
              child: GradientButtonFb1(text: 'إضافة', onPressed: (){
                var timestamp =  DateTime.now().millisecondsSinceEpoch;
                final       instance =FirebaseFirestore.instance.collection('user').doc(user!.uid).collection('tasbehaat').doc();
                if(_formkey.currentState!=null && _formkey.currentState!.validate()){ final json= {
                  'id': instance.id,
                  'TasbihaText': _selectedTasbiha,
                  'Tobexec': int.parse(_Tobexeccontroller.text.trim()),
                  'isCompleted':0,
                  'currentExec':0,
                  'date':  DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).toString(),
                };

                  TasbihaData.insertTasbiha(json,instance);
                Get.back();
                }


              }),
            ),
          ],
        ),
      ),
    );
  }



}

class EmailInputFb2 extends StatefulWidget {
  final List<String> list;
  final bool isDrpodwon;
  final TextEditingController inputController;
  final String hint;
  final String title;
  final TextInputType type;

  const EmailInputFb2(
      {Key? key,
      required this.inputController,
      required this.hint,
      required this.title,
      required this.type,
      required this.isDrpodwon,
      required this.list})
      : super(key: key);

  @override
  State<EmailInputFb2> createState() => _EmailInputFb2State();
}

class _EmailInputFb2State extends State<EmailInputFb2> {
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff4338CA);
    const secondaryColor = Color(0xff6D28D9);
    const accentColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);

    return Column(
      children: [
        Text(
          widget.title,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white.withOpacity(.9)),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.1)),
          ]),
          child: widget.isDrpodwon
              ? TextFormField(
            validator: _allvalidator ,
                  cursorColor: primaryColor,
                  controller: widget.inputController,
                  onChanged: (value) {
                   setState(() {
                     Tobexec=int.parse(value);
                   });
                  },
                  keyboardType: widget.type,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  decoration: InputDecoration(
                    label: Text(widget.title),
                    labelStyle: const TextStyle(color: primaryColor),
                    // prefixIcon: Icon(Icons.email),
                    filled: true,
                    fillColor: accentColor,
                    hintText: widget.hint,
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20.0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: secondaryColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: errorColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        offset: const Offset(12, 26),
                        blurRadius: 50,
                        spreadRadius: 0,
                        color: Colors.grey.withOpacity(.1)),
                  ]),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      label: Text(
                        widget.title,
                        textDirection: TextDirection.rtl,
                      ),
                      labelStyle: const TextStyle(color: primaryColor),
                      // prefixIcon: Icon(Icons.email),
                      fillColor: accentColor,
                      hintStyle:
                          TextStyle(color: Colors.grey.withOpacity(.75)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 20.0),
                      border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: primaryColor, width: 1.0),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: secondaryColor, width: 1.0),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: errorColor, width: 1.0),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: primaryColor, width: 1.0),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    icon: const Icon(Icons.arrow_downward_outlined),
                    dropdownColor: lightprimaryColor,
                    value: _selectedTasbiha,
                    items: widget.list
                        .map(
                          (value) => DropdownMenuItem<String>(
                              value: value,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                textDirection: TextDirection.rtl,
                                children: [
                                  Text(value,overflow: TextOverflow.fade,textDirection: TextDirection.rtl,),
                                  Divider(height: 10, color: Colors.white)
                                ],
                              )),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedTasbiha = value!;
                      });
                      print(Tobexec);
                      print(_selectedTasbiha);
                    },
                  ),
                ),
        ),
      ],
    );
  }

  String? _allvalidator(String? text){
    if(text!.trim().isEmpty||text==''){
      return 'This field is required';
    }
    else if (int.parse(text)>=100){
      return "You can't go over 100 this is a premium feature";
    }
  }
}





