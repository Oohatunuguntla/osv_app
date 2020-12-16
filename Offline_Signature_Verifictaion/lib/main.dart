import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:Offline_Signature_Verifictaion/Setup/Pages/welcome.dart';
// import 'package:Offline_Signature_Verifictaion/Setup/Signin.dart';
import 'package:Offline_Signature_Verifictaion/authService.dart';
void main()=>runApp(MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title:'Offine Signature Verification',
      theme: ThemeData(
        primarySwatch:Colors.blue,
      ),
     // home: WelcomePage(),
     home:AuthService().handleAuth(),
    );
  }
}
