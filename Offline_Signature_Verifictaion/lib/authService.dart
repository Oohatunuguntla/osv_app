import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Offline_Signature_Verifictaion/landingpage.dart';
import 'package:Offline_Signature_Verifictaion/loginscreen.dart';
import 'package:Offline_Signature_Verifictaion/imageupload.dart';
import 'package:Offline_Signature_Verifictaion/main.dart';
import 'package:Offline_Signature_Verifictaion/dashboard.dart';
class AuthService {
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Dashboard ();
            //return LandingPage();
          } else {
            //return Dashboard ();
            return LoginPage();
          }
        });
  }

  //Sign out
  Future<void> signOut() async{
    return FirebaseAuth.instance.signOut();
    
  }

  //SignIn
  Future<void> signIn(AuthCredential authCreds) async{
   return  FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  Future<void> signInWithOTP(smsCode, verId) async {
    print(smsCode);
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
        
    return signIn(authCreds);
  }
}