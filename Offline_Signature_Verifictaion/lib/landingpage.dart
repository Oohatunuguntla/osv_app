import 'package:flutter/material.dart';
import 'package:Offline_Signature_Verifictaion/authService.dart';
import 'package:Offline_Signature_Verifictaion/loginscreen.dart';
import 'package:Offline_Signature_Verifictaion/imageupload.dart';
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}
class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('verify your sinature'),
        backgroundColor: Colors.green,
        actions: <Widget>[
            Padding(padding: EdgeInsets.all(10.0),
            child: IconButton(icon: Icon(Icons.power_settings_new,color: Colors.white,), onPressed:(){
               AuthService().signOut();
              Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));
            }),
            )
        ],
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            onPressed : navigatetoimageupload,
            child:Text('Sign in')
            ),
        ],
      )
    );
  }
void navigatetoimageupload(){
   Navigator.push(context,MaterialPageRoute(builder: (context)=>Imageupload(),fullscreenDialog:true));
}

}