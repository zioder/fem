import 'package:femv2/tasbih.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();

}

class InitState extends State<SignUpScreen> {
  final _formkey=GlobalKey<FormState>();
var loading=false;
  final _nameController=TextEditingController();
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) => initWidget();

  Widget initWidget() {
    return Scaffold(
        body: Form(
          key: _formkey,
          child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                      color: lightprimaryColor,
                      gradient: LinearGradient(colors: [primaryColor, lightprimaryColor],
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
                              margin: EdgeInsets.only(top: 30),
                              child: Image.asset(
                                "assets/images/Llogom.png",
                                height: 200,
                                width: 200,
                              ),
                            ),
                          ],
                        )
                    ),
                  ),

                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: _allvalidator,
                      controller: _nameController,
                      cursorColor: lightprimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: lightprimaryColor,
                        ),
                        hintText: "Full Name",
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
                      validator: _emailValidator,
                      controller: _emailController,
                      cursorColor: lightprimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: lightprimaryColor,
                        ),
                        hintText: "Email",
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
                      controller: _passwordController,
                      obscureText: true,
                      cursorColor: lightprimaryColor,
                      decoration: InputDecoration(
                        focusColor: Theme.of(context).colorScheme.primary,
                        icon: Icon(
                          Icons.vpn_key,
                          color: lightprimaryColor,
                        ),
                        hintText: "Enter Password",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ), Container(
                     alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: _confirmPasswordValidator,
                      controller: _confirmPasswordController,
                      obscureText: true,
                      cursorColor: lightprimaryColor,
                      decoration: InputDecoration(
                        focusColor: lightprimaryColor,
                        icon: Icon(
                          Icons.vpn_key,
                          color: lightprimaryColor,
                        ),
                        hintText: "Confirm Password",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  if(loading)...[
                    Center(
            child: CircularProgressIndicator(),
        )
                  ],
                  GestureDetector(
                    onTap: () {
                      if(_formkey.currentState!=null && _formkey.currentState!.validate()){
_signUp();
                      }
                    },
                    child: Container(
                       alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [(lightprimaryColor), new Color(0xffF2861E)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight
                        ),
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: lightprimaryColor
                          ),
                        ],
                      ),
                      child: Text(
                        "REGISTER",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Have Already Member?  "),
                        GestureDetector(
                          child: Text(
                            "Login Now",
                            style: TextStyle(
                                color: lightprimaryColor
                            ),
                          ),
                          onTap: () {
                            // Write Tap Code Here.
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  )
                ],
              )
          ),
        )
    );

  }


  String? _confirmPasswordValidator(String? confirmPassword){
    if(confirmPassword==null|| confirmPassword.trim().isEmpty){
      return 'This field is required';
    }
    if(_passwordController.text!=confirmPassword){
      return "Passwords don't match ";
    }
    return null;
  }
  String? _emailValidator(String? email){
    if(!GetUtils.isEmail(email!)){
      return 'Enter A valid email';
    }
    return null;
  }
  String? _allvalidator(String? text){
    if(text!.trim().isEmpty){
      return 'This field is required';
    }
    return null;
  }
  Future _signUp() async{
    setState(() {
      loading=true;
    });
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
      await FirebaseAuth.instance.currentUser?.updateDisplayName(_nameController.text);
      await Get.snackbar('تم صناعة حسابك بنجاح', 'مرحبا بك ${_nameController.text.split(' ')[0]}');
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

}
