import 'package:Offline_Signature_Verifictaion/imageupload.dart';
import 'package:Offline_Signature_Verifictaion/img2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:Offline_Signature_Verifictaion/authService.dart';
import 'package:Offline_Signature_Verifictaion/loginscreen.dart';
import 'package:Offline_Signature_Verifictaion/main.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
class Dashboard extends StatefulWidget{
  @override
  _Dashboardstate createState()=>_Dashboardstate();
}
class _Dashboardstate extends State<Dashboard>{
  bool _isbase=false;
  void _showDialog1(String x) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!!!!",),
          content: new Text("$x"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
            actions: <Widget>[
              ButtonTheme(
                minWidth: 120,
                child:new RaisedButton(
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                    },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                    child: new Text('OK',
                      style: TextStyle(fontSize:18,),
                      //color:Colors.white,
                      ),
                      color: Colors.green,)),
           
          ],
        );
      },
    );
  }
  @override
  //  void _initState() async{
  //   final _auth=FirebaseAuth.instance;
  //   final FirebaseUser user = await _auth.currentUser();
  //   var uid = user.uid;
  //   print('hii');
  //   try{
  //   var file=FirebaseStorage.instance.ref().child('$uid').child('IMG');
  //   }catch(e){
  //     print('hii');
  //     _isbase=true;
  //   }
   
  //}
   Widget build(BuildContext context){
          //isbasesignature();
        final basesignature = new RaisedButton(
            elevation: 10.0,
            textColor: Colors.white,
            onPressed: (){ 
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Imageupload()));
              },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
            child: Center(child: Text("Upload base signature",
                                        style: TextStyle(
                                        fontSize: 20.0,
                                        letterSpacing: 1.0,
                                        ),
                                        )
                                        ),
                                        color: Colors.green,
        );
      
         final  signature_to_be_verified = new RaisedButton(
            elevation: 10.0,
            textColor: Colors.white,
            onPressed: (){ 
              //getImage();
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Imageupload2()));
              },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
            child: Center(child:new Text("Signature to be verified",
                                        style: TextStyle(
                                        fontSize: 20.0,
                                        letterSpacing: 1.0,
                                        ),
                                        )
                                        ),
                                        color: Colors.green,
        );
        final  predict = new RaisedButton(
            elevation: 10.0,
            textColor: Colors.white,
            onPressed: (){ 
              getdata();
              //getImage();
              //Navigator.push(context,MaterialPageRoute(builder: (context)=>Imageupload2()));
              },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
            child: Center(child:new Text("Verify",
                                        style: TextStyle(
                                        fontSize: 20.0,
                                        letterSpacing: 1.0,
                                        ),
                                        )
                                        ),
                                        color: Colors.green,
        );
        
       return Scaffold(
      appBar: new AppBar(
    
        title: new Text('Signature verification'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
            Padding(padding: EdgeInsets.all(10.0),
            child: IconButton(icon: Icon(Icons.power_settings_new,color: Colors.white,), onPressed:(){
               AuthService().signOut();
              Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()));
            }),
            )
        ],
      ),

      body:Center(
        child:Container(
          color:Colors.white,
          child:Padding(
            padding : const EdgeInsets.all(36.0),
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 45.0),
                  basesignature,
                  SizedBox(height: 45.0),
                  signature_to_be_verified,
                  SizedBox(height: 45.0),
                  predict
                
                  
                ],
            )
          )
        )
      ),
    );
   }

  void getdata() async{
    final _auth=FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    var uid = user.uid;
    var ref=FirebaseStorage.instance.ref().child('$uid').child('IMG');
    var ref2=FirebaseStorage.instance.ref().child('$uid').child('IMG2');
    var url1= await  ref.getDownloadURL();
    var url2= await  ref2.getDownloadURL();
    Map<String, String> queryParams={'base':url1,'sig':url2};
    try{
    var x='http://192.168.0.108:5000';
   var params={'base':1,'sig':2};
   String querystring=Uri(queryParameters:queryParams).query;
   var requestedurl=x+'?'+querystring;
   print(requestedurl);
   var resp=await http.get(requestedurl); 

   // var bodyEncoded = convert.jsonEncode(params);
    // final resp = await http.get(x,quer);
     //print(x);
    //var uri=Uri.http('C:5000');
    //  print(uri);
    //  var resp = await http.get(uri);
     ///var jsonresponse=convert.jsonDecode(resp.body);
     print(resp.body);
    // print('$jsonresponse'); 
     var out=resp.body;
     _showDialog1("The signature is $out");
    }catch(e){
      print(e);
    }
    // http.Response resp=await http.get('http:/8:/192.168.0.105000/',queryParameters);
    // print(resp.body);
    // if(resp.statusCode==200){
    //   print('sucess');
    // }
    // else{
    //   print('fail');
    // }
   }
}