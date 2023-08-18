import 'package:femv2/Screens/sign_up/sign_up_page.dart';
import 'package:femv2/constants.dart';
import 'package:femv2/services/authservice.dart';
import 'package:femv2/tasbih.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static String routeName = "/sign_in";

  @override
  State<SignInScreen> createState() {
    Firebase.initializeApp();
    return _SignInScreenState();

  }
}



class _SignInScreenState extends State<SignInScreen> {
  var loading=false;
  final _formkey=GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  Future <void> signInwithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleuser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth= await googleuser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    
  }



  @override
  Widget build(BuildContext context) {
    return initWidget();
  }


  Widget initWidget() {
    final AuthService authService = AuthService();
    return Scaffold(
      body: Form(
        key:_formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                decoration:  BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90)),
                  color: Theme.of(context).colorScheme.primary,
                  gradient: LinearGradient(
                    colors: [primaryColor, lightprimaryColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 300,
                        width: 400,
                        child: Image.asset('assets/images/Llogom.png'),
                      ),
                    ],
                  ),
                ),
              ),
              loading? Center(
                child: CircularProgressIndicator(),
              ):Container(),
              Container(
                alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  validator: _emailValidator,
                  controller: emailcontroller,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: lightprimaryColor,
                    ),
                    hintText: "Enter Email here",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  validator: _allvalidator,
                  controller: passwordcontroller,
                  obscureText: true,
                  cursorColor: primaryColor,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.vpn_key_sharp,
                      color: lightprimaryColor,
                    ),
                    hintText: "Enter Password here",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GradientButtonFb1(
                text: 'Login',
                onPressed: () {

                  if(_formkey.currentState!=null && _formkey.currentState!.validate()){
                    _signin();
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't Have an Account ? "),
                    GestureDetector(
                      child: Text(
                        "Create One",
                        style: TextStyle(color: lightprimaryColor,fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Get.to((){return SignUpScreen();}, transition: Transition.circularReveal);
                      },
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignInButton.mini(buttonType: ButtonType.googleDark, onPressed: ()  async {
                   authService.handleSignIn();


                  }),
                  SignInButton.mini(buttonType: ButtonType.facebookDark, onPressed: (){}),
                ],
              )
            ],
          ),
        ),
      ),
    );

  }
  Future _signin() async{
    setState(() {
      loading=true;
    });
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text);
      setState(() {
        loading=false;
      });
      Get.to((){return Tasbih();});
    } on FirebaseAuthException catch(e){
      Get.snackbar('Error', e.toString());
      setState(() {
        loading=false;
      });

    }
  }

  String? _allvalidator(String? text){
    if(text!.trim().isEmpty||text==null){
      return 'This field is required';
    }
  }
}

class GradientButtonFb1 extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const GradientButtonFb1(
      {required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff4338CA);
    const secondaryColor = Color(0xff6D28D9);
    const accentColor = Color(0xffffffff);

    const double borderRadius = 50;

    return DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient:
                const LinearGradient(colors: [primaryColor, secondaryColor])),
        child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              alignment: Alignment.center,
              padding: MaterialStateProperty.all(const EdgeInsets.only(
                  right: 75, left: 75, top: 15, bottom: 15)),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius)),
              )),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(color: accentColor, fontSize: 16),
          ),
        ));
  }



}
String? _emailValidator(String? email){
  if(!GetUtils.isEmail(email!)){
    return 'Enter A valid email';
  }
}

