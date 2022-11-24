import 'dart:convert';

import 'package:deidine/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'const/pref.dart';
class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key, this.title, this.prefs}) : super(key: key);

  final SharedPreferences? prefs;
  final String? title;

  @override
  State createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  bool _autoValidate = false;
  bool _loadingVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
Future _reg()async  {
  
    if (_formKey.currentState!.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      
   var url = 'http://192.168.252.71/flutter/add.php';
   var response = await http.post(url,body: {
        'username' : nameController.text,
        'password' : passwordController.text
      });
    var data = json.decode(response.body);
    if (data == "Error") {
      AlertDialog alertDialog = AlertDialog(
                title: Text('Response'),
                content: Text("le nom  exist"),
                actions: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: <Widget>[
                           FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text('Ok', textScaleFactor: 1.5),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginPage(
                                            prefs: widget.prefs,
                                          )));
                            },
                          ),
                        ],
                      ))
                ]);

            showDialog(context: context, builder: (_) => alertDialog);
          } else {
            AlertDialog alertDialog = AlertDialog(
                title: Text('Response'),
                content: Text("les information on enregistrer succes')"),
                actions: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: <Widget>[
                           FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text('Ok', textScaleFactor: 1.5),
                            onPressed: () {
                              _loadingVisible = false;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          RegisterPage(
                                            prefs: widget.prefs,
                                          )));
                            },
                          ),
                        ],
                      ))
                ]);

            showDialog(context: context, builder: (_) => alertDialog);
          }
      } catch (e) {
        print("Sign Up Error: $e");
      }
    }}

  @override
  Widget build(BuildContext context) {
    void showAlertDialog({String? message}) {}

    final nameField = TextFormField(
      obscureText: false,
      style: style,
      keyboardType: TextInputType.text,
      autofocus: true,
      controller: nameController,validator: (value){
        if( value==null||value.isEmpty )
{
  return "error il vaux remplir les champs";
      }},
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          )),
    );
    final passwordField = TextFormField(
      obscureText: true,
      style: style,
      autofocus: false,
      controller: passwordController,validator: (value){
        if (value == null || value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final confirmPasswordField = TextFormField(
      obscureText: true,
      style: style,
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: confirmPasswordController,validator: (value) {
        if (value == null || value.isEmpty || confirmPasswordController.text!=passwordController.text) {
                                                  return 'Please enter some text';
                                                }
                                                return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Confirm Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01286D),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          _reg();
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final backButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xffFAB904),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Back To Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    Form form =  Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Color(0xffF6F6F6),
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 155.0,
                      child: Image.asset(
                        "assets/images/bus_booking.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    nameField,
                    SizedBox(height: 20.0),
                    passwordField,
                    SizedBox(height: 20.0),
                    confirmPasswordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    registerButton,
                    SizedBox(height: 25.0),
                    backButton,
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));

    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      body: form
      );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
}




/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RegPage extends StatefulWidget {
   @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password= TextEditingController();
  String msg='';
Future _reg()async  {
      var url = 'http://192.168.28.71/flutter/add.php';
   var response = await http.post(url,body: {
        'username' : username.text,
        'password' : password.text
      });
    var data = json.decode(response.body);
    if (data == "Error") {
      
    } else {
      
  }

    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text("REGISTRATION", style: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold
      )),
      elevation:0,
    backgroundColor:Color.fromRGBO(143, 148, 251, .6),  
      
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      	child: Container(
	        child: Column(
	          children: <Widget>[
	            Container(
	              height: 200,
	              decoration: BoxDecoration(
	                image: DecorationImage(
	                  image: AssetImage('images/background.png'),
	                  fit: BoxFit.fill
	                )
	              ),
	              child: Stack(
	                children: <Widget>[
	                  Positioned(
	                    left: 30,
	                    width: 80,
	                    height: 200,
	                    child: Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('images/light-1.png')
	                        )
	                      ),
	                    ),
	                  ),
	                  Positioned(
	                    left: 140,
	                    width: 80,
	                    height: 150,
	                    child: Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('images/light-2.png')
	                        )
	                      ),
	                    ),
	                  ),
	                  Positioned(
	                    left: 20,
	                    top: 40,
	                    width: 80,
	                    height: 150,
	                    child:Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('images/clock.png')
	                        )
	                      ),
	                    ),
	                  ),
	                  
	                ],
	              ),
	            ),
	            Padding(
	              padding: EdgeInsets.all(30.0),
	              child: Column(
	                children: <Widget>[
	                   Container(
	                    padding: EdgeInsets.all(5),
	                    decoration: BoxDecoration(
	                      color: Colors.white,
	                      borderRadius: BorderRadius.circular(10),
	                      boxShadow: [
	                        BoxShadow(
	                          color: Color.fromRGBO(143, 148, 251, .2),
	                          blurRadius: 20.0,
	                          offset: Offset(0, 10)
	                        )
	                      ]
	                    ),
	                    child: Column(
	                      children: <Widget>[
	                        Container(
	                          padding: EdgeInsets.all(8.0),
	                          decoration: BoxDecoration(
	                            border: Border(bottom: BorderSide(color: Colors.grey))
	                          ),
	                          child: TextFormField(
                              controller:username,
	                            decoration: InputDecoration(
                                                  labelText: "Username",

                               prefixIcon: const Icon(Icons.person , color: Colors.black,),
                                enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(25.0),
                                                      borderSide: BorderSide(color:Color.fromRGBO(143, 148, 251, .6))
                                                  ),
	                              border: InputBorder.none,
	                              hintText: "Email or telephone number",
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        ),
	                        Container(
	                          padding: EdgeInsets.all(8.0),
	                          child: TextFormField(
                              controller: password,
                              obscureText: true,
	                            decoration: InputDecoration(
                                labelText: "password",

                                        enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Color.fromRGBO(143, 148, 251, .6))
                                ),
                              prefixIcon: const Icon(Icons.remove_red_eye ,color: Colors.black,),

	                              border: InputBorder.none,
	                              hintText: "Password",
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        )
	                      ],
	                    ),
	                  ),
	                  SizedBox(height: 30,),
	                   Container(
	                    child: Center(
                        child: Container(
	                    height: 50,
                        child:ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          padding:EdgeInsets.only(left:90.0,right: 90.0),
                          primary:Color.fromRGBO(143, 148, 251, .6),
                          textStyle: const TextStyle(
                          color: Colors.white, fontSize: 15, fontStyle: FontStyle.normal),
                          ),
                          onPressed: () {                           
                            _reg(); },
                          child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => home(),),);


                        )
	                  )),
	                  SizedBox(height: 70,),
	                  Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.red),),

                    
                     ],
	              ),
	            )
	          ],
	        ),
	      ),
      )
    );
  }
}*/