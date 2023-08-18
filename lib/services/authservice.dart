
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
 FirebaseAuth _auth = FirebaseAuth.instance;
 final GoogleSignIn _googleSignIn= GoogleSignIn();

 Future<void> handleSignIn()async {
  try {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if (googleUser != null){
      GoogleSignInAuthentication googleAuth= = await googleUser.authentication;
     AuthCredential credential= GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
    }
  }
  catch(e){};

 }

}