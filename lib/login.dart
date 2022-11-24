import 'package:deidine/home.dart';
import 'package:deidine/set_ip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'const/pref.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {

  final String? title;
  final SharedPreferences? prefs;
  LoginPage({Key? key, this.title, this.prefs}) : super(key: key);

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  bool _autoValidate = false;
  bool _loadingVisible = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernamectr = TextEditingController();
  TextEditingController passwordctr= TextEditingController();
  Future<List> _login() async {
      var url = 'http://192.168.252.71/flutter/add.php';
      final response = await http.post(url,body: {
        'username' : usernamectr.text,
        'password' : passwordctr.text
      });
  var message = jsonDecode(response.body);
       try {
    if(message=="login"){
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
          widget.prefs?.setBool(PrefConstants.ISLOGGEDIN, true);
         Navigator.push(context, MaterialPageRoute(builder: (context) => home(prefs: widget.prefs,),),);
    }
    else {  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text('error login'),
        actions: <Widget>[
         Visibility(
          visible: true, 
          child: Column(
            children:[
           Container(margin: EdgeInsets.only(left: 30),child:Text("le nom ou le mots de pass est fausse")),
          ]))
        ],
);});    
           usernamectr.clear();
           }
  } catch (e) {
        print("Sign Up Error: $e");
      }
    return message;
    }

  

  @override
  Widget build(BuildContext context) {
    final username = TextFormField(
        validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
      obscureText: false,
      style: style,
      // keyboardType: TextInputType.number,
      autofocus: false,
      controller: usernamectr,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "username",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          )),
    );

    final passwordField = TextFormField(
        validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
      obscureText: true,
      style: style,
      autofocus: false,
      controller: passwordctr,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01286D),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          setState(() {
            _login();
          });
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xffFAB904),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => RegisterPage(
                        // prefs: widget.prefs,
                      )));
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final setIPAddress = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xffFAaaa4),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => SetIpPage(),),);

        },
        child: Text("Set IP Address",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    Form form =Form(
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
                      height: 200.0,
                      width: 400.0,
                      child: Image.asset(
                        "images/bus.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    username,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    loginButton,
                    SizedBox(height: 25.0),
                    registerButton,
                   SizedBox(height: 25.0),
                   setIPAddress,
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
      body:  form,
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
