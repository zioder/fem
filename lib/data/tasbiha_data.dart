import 'package:cloud_firestore/cloud_firestore.dart';

class TasbihaData {
  String? id;
  String? TasbihaText;
  int? isCompleted;
  int? currentExec;
  int? tobeExec;
  int? remind;
  String? date;
 TasbihaData(
  {
    this.id,
    this.TasbihaText,
    this.isCompleted,
    this.currentExec,
    this.remind,
    this.tobeExec,
    this.date,
}
     );

 Map<String,dynamic> toJson() => {
  'TasbihaText':TasbihaText,
  'isCompleted':isCompleted,
  'currentExec':currentExec,
  'Tobexec':tobeExec,
   'date':date,


  };
 static TasbihaData fromJson(Map<String,dynamic> json )=> TasbihaData(
   id: json['id'],
TasbihaText: json['TasbihaText'],
   isCompleted: json['isCompleted'],
   currentExec: json['currentExec'],
   tobeExec: json['Tobexec'],
   date: json['date'],
 );


 static Future insertTasbiha(Map<String,dynamic> json,DocumentReference<Map<String, dynamic>> instance ) async {
   try{
     await instance.set(json) ;
     print(instance.id);

   }catch(e){
     print(e);
   }

 }
}
