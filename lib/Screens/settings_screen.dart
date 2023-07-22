import 'package:femv2/Screens/sign_in/sign_in_page.dart';
import 'package:femv2/Screens/splash_screen.dart';
import 'package:femv2/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

User? user = FirebaseAuth.instance.currentUser;
int hasanet = 200;

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.13,
                decoration: BoxDecoration(
                    color: lightgreenColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    )),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.08,
                top: MediaQuery.of(context).size.height * 0.03,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://i.ibb.co/L68XMgY/14705878-919709238135411-4494628516392943593-n.jpg')),
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      )),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: 100,
                ),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.3,
                top: MediaQuery.of(context).size.height * 0.03,
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          user!.displayName!,
                          style: TextStyle(fontSize: 40),
                        ),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Text('${hasanet}',style: TextStyle(
                                color: lightprimaryColor,
                                fontSize: 20
                            ),),
                            Text('حسنة ',style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),),
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
         SizedBox(
           height: MediaQuery.of(context).size.height*0.1,
         ),
         Padding(
           padding: EdgeInsets.all(15),
           child: Card(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10),
               side: BorderSide(color: superlightgreenColor,width: 5)
             ),
             child: Column(
               children: [
                 Directionality(
                   textDirection : TextDirection.rtl,
                   child: ExpansionTile(title: Text('الصلاة'),children: [
                     ListTile(title: Text('الإعدادات'),
                     subtitle: Container(),)
                   ],),
                 ),Directionality(
                   textDirection: TextDirection.rtl,
                   child: ExpansionTile(title: Text('test'),children: [
                     ListTile(title: Text('test'))
                   ],),
                 ),ExpansionTile(title: Text('test'),children: [
                   ListTile(title: Text('test'))
                 ],),
               ],
             ),
            ),
         ),
          Text(FirebaseAuth.instance.currentUser!.email!),
          GradientButtonFb1(
              text: 'تسجيل الخروج',
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.offAll((){return Splashscreen();});
              }),
        ],
      ),
    );
  }
}

class LikeListTile extends StatelessWidget {
  const LikeListTile(
      {Key? key,
      required this.title,
      required this.likes,
      required this.subtitle,
      required this.imgUrl,
      this.color = Colors.grey})
      : super(key: key);
  final String title;
  final String likes;
  final String subtitle;
  final Color color;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Container(
        width: 50,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      imgUrl,
                    ))),
          ),
        ),
      ),
      title: Text(title),
      subtitle: Row(
        children: [
          Icon(Icons.favorite, color: Colors.orange, size: 20),
          SizedBox(
            width: 3,
          ),
          Text(likes),
          Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(width: 4, height: 4),
              )),
          Text(subtitle)
        ],
      ),
      trailing: LikeButton(onPressed: () {}, color: Colors.orange),
    );
  }
}

class LikeButton extends StatefulWidget {
  const LikeButton(
      {Key? key, required this.onPressed, this.color = Colors.black12})
      : super(key: key);
  final Function onPressed;
  final Color color;

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
      icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border,
          color: widget.color),
      onPressed: () {
        setState(() {
          isLiked = !isLiked;
        });
        widget.onPressed();
      },
    ));
  }
}
