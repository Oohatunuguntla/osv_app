import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:Offline_Signature_Verifictaion/authService.dart';
import 'package:Offline_Signature_Verifictaion/loginscreen.dart';
import 'package:Offline_Signature_Verifictaion/main.dart';
import 'package:Offline_Signature_Verifictaion/dashboard.dart';
class Imageupload extends StatefulWidget{
  @override
  _Imageuploadstate createState()=>_Imageuploadstate();
}
  
class _Imageuploadstate extends State<Imageupload> {
File _img;
  File _cam;
  bool uploaded=false;
  final ref=FirebaseDatabase.instance.reference();
  GlobalKey<FormState> _key = new GlobalKey();
 bool _autoValidate = false;
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
  void _initState(){
    super.initState();


  }

  
  @override
  Widget build(BuildContext context){
    
    Future getImage() async{
     var image=await ImagePicker.pickImage(source:ImageSource.gallery);
     setState(() {
       _img=image;
       print('Image Path $_img');
     });
    }
     void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Message for you"),
          content: new Text("Image uploaded succesfully"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
            actions: <Widget>[
              ButtonTheme(
                minWidth: 120,
                child:new RaisedButton(
                  onPressed: () { 
                    Navigator.of(context).pop();
                    },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                    child: new Text('OK',
                      style: TextStyle(fontSize:18,),
                      ),
                      color: Colors.green,)),
           
          ],
        );
      },
      
    );
  }
    Future uploadPic(BuildContext context) async{
      final _auth=FirebaseAuth.instance;
     final FirebaseUser user = await _auth.currentUser();
    var uid = user.uid;
       if(_img!=null){
       StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('$uid').child('IMG');
       StorageUploadTask uploadTask = firebaseStorageRef.putFile(_img);
       uploadTask.onComplete.then((value){
          _showDialog();
         uploaded=true;
         setState(() {
           
         });
         Navigator.push(context,MaterialPageRoute(builder: (context)=>Dashboard()));
       });
       
       }
       else{
         _showDialog1('Please upload image First');
       }
       
    }
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
    body:
      SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.all(20),
          //Form
          child:Form(
             key: _key,
            autovalidate: _autoValidate,
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: <Widget>[
            new SizedBox(height:20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //image
                 CircleAvatar(
        radius:100,
        backgroundColor: Colors.white,
        child: ClipOval(child: new SizedBox(
                       width:180.0,
                       height:180.0,
                       child:(_img!=null)?Image.file(_img,fit:BoxFit.fill):
                       Image.asset('assets/profile.png',
                       fit: BoxFit.fill,
                       )
                    ),)),
                  Padding(
                 padding:EdgeInsets.only(top:70.0),
                 child: IconButton(icon:Icon(Icons.camera,
                 size:30.0,
                 ), onPressed:(){
                 getImage();
                 }),
               ),],),
               new SizedBox(height:10.0),
      Center(child:_img!=null?ButtonTheme(
                         splashColor: Colors.green[300],
    minWidth: 100,
    child: new RaisedButton(
      elevation: 10.0,
      textColor: Colors.white,
      onPressed: ()async{
        Navigator.of(context).pop();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
      child:new Text("Cancel",
        style: TextStyle(
          fontSize: 20.0,
          letterSpacing: 1.0,
        ),
      ),
      color: Colors.green,
    ),
  ):Text('')),
    new SizedBox(height:10.0),
                       ButtonTheme(
                         splashColor: Colors.green[300],
    minWidth: 100,
    child: new RaisedButton(
      elevation: 10.0,
      textColor: Colors.white,
      onPressed: ()async{
        uploadPic(context);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
      child:new Text("Upload",
        style: TextStyle(
          fontSize: 20.0,
          letterSpacing: 1.0,
        ),
      ),
      color: Colors.green,
    ),
  ),
  new SizedBox(height:20.0),
              ButtonTheme(
                         splashColor: Colors.green[300],
    minWidth: 100,
    child: uploaded?new RaisedButton(
      elevation: 10.0,
      textColor: Colors.white,
      onPressed: ()async{
        getdata();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
      child:new Text("Get Result",
        style: TextStyle(
          fontSize: 20.0,
          letterSpacing: 1.0,
        ),
      ),
      color: Colors.green,
    ):Text(''),
  ),
]),))) );
    
  }
Future getdata() async{
    final _auth=FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    var uid = user.uid;
    var ref=FirebaseStorage.instance.ref().child('$uid').child('IMG');
    ref.getDownloadURL().then((url) {
      print(url);
     
      });
   }
 

}

