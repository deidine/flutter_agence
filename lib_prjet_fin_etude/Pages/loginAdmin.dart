import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/request.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

showdialog(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: const [Text("Lodin ..."), CircularProgressIndicator()],
          ),
        );
      });
}

showdialogall(context, String mytitle, String mycontent) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            mytitle,
            style: const TextStyle(fontSize: 22, color: Colors.red),
          ),
          content: Text(mycontent),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("done")),
          ],
        );
      });
}

class User {
  const User(this.id,this.name);

  final String name;
  final int id;
}

class _LoginState extends State<LoginAdmin> {
  late User selectedUser;
  List<User> users = <User>[const User(1,'Item 1'), const User(2,'Item 2'), const User(3,'Item 3'),const User(4,'Item 4'),
    const User(5,'Item 6')];


  String valueChoose = "";
  List listItem = [
    "Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"
  ];
  //var mytoken;
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confermpas = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController categorie = TextEditingController();
  TextEditingController des = TextEditingController();

  GlobalKey<FormState> formstatesigin = GlobalKey<FormState>();
  GlobalKey<FormState> formstatesiginup = GlobalKey<FormState>();

  savePref(String username, String tel, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id", id);
    preferences.setString("username", username);
    preferences.setString("tel", tel);
  }

  String pattern = r'[0-9]{8}$';

  String validglobal(String val) {
    return "field can't empty";
  }

  siginup() async {
    if(file == null) return;
    String base64 = base64Encode(file!.readAsBytesSync());
    String imagename = file!.path.split("/").last;

    var formdata = formstatesiginup.currentState;
    if (formdata!.validate()) {
      showdialog(context);
      formdata.save();
      var data = {
        "tel": tel.text,
        "password": password.text,
        "username": username.text,
        "catedorie": selectedUser.id.toString(),
        "des": des.text,
        "imagepost" : imagename,
        "image64" : base64
      };
      var response = await http.post(
          Uri.parse(urlBaseAdmin+'signupAdmin.php'),
          body: data);
      var respnsebody = jsonDecode(response.body);
      if (respnsebody['status'] == "success") {
        var dat = {"tel": tel.text, "password": password.text};
        var respons = await http.post(
            Uri.parse(urlBaseAdmin+'loginAdmin.php'),
            body: dat);
        var respnsebod = jsonDecode(respons.body);
        if (respnsebod['status'] == "success") {
          savePref(respnsebod['username'], respnsebod['tel'].toString(), respnsebod['id'].toString());
          Navigator.of(context).pushNamed("home");

        }
        //Navigator.of(context).pushNamed("home");
      } else {
        Navigator.of(context).pop();
        showdialogall(context, "Erreur", "Numéro de télephone existe déjà ");
      }
    }
  }

  String? validname(String val) {
    if (val.trim().isEmpty) {
      return "Le nom ne peut pas être vide";
    }
    if (val.trim().length < 4) {
      return "Le longuer min c'est 4 characteur";
    }
    if (val.trim().length > 100) {
      return "Le longuer max c'est 100 characteur";
    } else {
      return null;
    }
  }
  String? validDec(String val) {
    if (val.trim().isEmpty) {
      return "Le nom ne peut pas être vide";
    }
    if (val.trim().length < 10) {
      return "Le longuer min c'est 4 characteur";
    }
    if (val.trim().length > 250) {
      return "Le longuer max c'est 100 characteur";
    } else {
      return null;
    }
  }

  String? validpass(String val) {
    if (val.trim().isEmpty) {
      return "Le mot de passe ne peut pas être vide";
    }
    if (val.trim().length < 6) {
      return "Le longuer min c'est 6 characteur ";
    }
    if (val.trim().length > 100) {
      return "Le longuer max c'est 100 characteur";
    } else {
      return null;
    }
  }

  String? validconfpass(String val) {
    if (val != password.text) {
      return "le mot de passe n'est pas identique";
    }
    return null;
  }

  String? validTEL(String val) {
    RegExp regex = RegExp(pattern);
    if (val.trim().isEmpty) {
      return "Ce champ  ne peut pas être vide";
    } else if (val.trim().length < 8) {
      return "Le longuer min c'est 8 nombre ";
    } else if (val.trim().length > 13) {
      return "Le longuer max c'est 13 nombre";
    }
    if (!regex.hasMatch(val)) {
      return "Le numero tel n'est pas valide";
    }
    return null;
  }

  sigin() async {
    var formdata = formstatesigin.currentState;
    if (formdata!.validate()) {
      formdata.save();

      showdialog(context);
      var data = {"tel": tel.text, "password": password.text};
      var response = await http
          .post(Uri.parse(urlBaseAdmin+'loginAdmin.php'), body: data);
      var respnsebody = jsonDecode(response.body);
      if (respnsebody['status'] == "success") {
        savePref(
            respnsebody['username'], respnsebody['tel'].toString(), respnsebody['id'].toString());
        Navigator.of(context).pushNamed("HomeScreenFournisseur");
      } else {
        Navigator.of(context).pop();
        showdialogall(context, "Erreur :",
            "Numéro de télephone ou le mot de passe est faux");
      }
    }
  }

  late TapGestureRecognizer _changesign;
  bool showsignin = true;

  @override
  void initState() {
    selectedUser=users[0];
    _changesign = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          showsignin = !showsignin;
          if (kDebugMode) {
            print(showsignin);
          }
        });
      };
    /*_firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      setState(() {
        mytoken = token;
      });
      print(mytoken);
    });*/
    // TODO: implement initState
    super.initState();
  }
  File? file ;

  Future pickerCamera() async {
    final myFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      file = File(myFile!.path);
    });

  }
  //_firebaseMessaging.getToken().then(String token) {    }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return Scaffold(backgroundColor: Colors.white38,
      body: Stack(
        children: [
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
          buildPositinedTop(mdw, showsignin),
          buildPositinedBottom(mdw, showsignin),
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: Text(
                          showsignin ? "Se Connecter" : "Cree un compte",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        ))),
                const Padding(
                    padding: EdgeInsets.only(
                      top: 18,
                    )),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: showsignin ? Colors.blue : Colors.grey[700],
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 4,
                          spreadRadius: 0.4),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showsignin = !showsignin;
                      });
                    },
                    child: Stack(
                      children: const [
                        Positioned(
                          child: Icon(
                            Icons.person_outline,
                            size: 50,
                            color: Colors.white,
                          ),
                          top: 25,
                          right: 25,
                        ),
                        Positioned(
                          child: Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          ),
                          top: 35,
                          right: 50,
                        ),
                      ],
                    ),
                  ),
                ),
                showsignin
                    ? buildFormBoxSignin(mdw)
                    : buildFormBoxSigninUp(mdw),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      showsignin
                          ? InkWell(
                          onTap: () {},
                          child: const Text(
                            "Avesz-vous oublié le mot de passe?",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ))
                          : const SizedBox(),
                      const SizedBox(
                        height: 24,
                      ),
                      RaisedButton(
                        color: showsignin ? Colors.blue : Colors.grey[700],
                        elevation: 10,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 40),
                        onPressed: showsignin ? sigin : siginup,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              showsignin ? "Se Connecter" : "Cree un compte",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            const Icon(
                              Icons.arrow_right,
                              size: 40,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: RichText(
                    text: TextSpan(
                        style:
                        const TextStyle(color: Colors.black, fontSize: 17),
                        children: [
                          TextSpan(
                              text: showsignin
                                  ? "Si vous n'avez pas de compte"
                                  : "Si vous avez un compte"),
                          TextSpan(
                              recognizer: _changesign,
                              text: showsignin
                                  ? "  Cree un compte Ici "
                                  : "  Se Connecter Ici",
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w700))
                        ]),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Positioned buildPositinedBottom(double mdw, bool showsignin) {
    return Positioned(
      top: 300,
      right: mdw / 1.5,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: mdw,
        width: mdw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(mdw),
          color: showsignin
              ? Colors.blue.withOpacity(0.2)
              : Colors.grey.withOpacity(0.4),
        ),
      ),
    );
  }

  Positioned buildPositinedTop(double mdw, bool showsignin) {
    return Positioned(
      child: Transform.scale(
        scale: 1.3,
        child: Transform.translate(
          offset: Offset(0, -mdw / 1.7),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: mdw,
            width: mdw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(mdw),
              color: showsignin ? Colors.grey[800] : Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  Center buildFormBoxSignin(double mdw) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutBack,
        margin: const EdgeInsets.only(top: 40),
        height: 250,
        width: mdw / 1.2,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                spreadRadius: -2,
                blurRadius: 2,
                offset: Offset(1.5, 1.5)),
          ],
        ),
        child: Form(
          key: formstatesigin,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //start user name
                  const Text(
                    "Numéro de télephone",
                    style: TextStyle(fontSize: 22, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildFormFieldAlltel(
                      "Entrez Numéro de télephone", false, tel, validTEL),
                  //End user ENd
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Le mot de passe",
                    style: TextStyle(fontSize: 22, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildFormFieldAll(
                      "Entrez le mot de passe", true, password, validpass),
                  //End user ENd
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center buildFormBoxSigninUp(double mdw) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutBack,
        margin: const EdgeInsets.only(top: 40),
        height: 600,
        width: mdw / 1.2,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                spreadRadius: -2,
                blurRadius: 2,
                offset: Offset(1.5, 1.5)),
          ],
        ),
        child: Form(
          key: formstatesiginup,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //start user name
                  const Text(
                    "Nom Utilusateur",
                    style: TextStyle(fontSize: 22, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildFormFieldAll(
                      "Entrez Nom Utilusateur", false, username, validname),
                  //End user ENd
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Le mot de passe",
                    style: TextStyle(fontSize: 22, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildFormFieldAll(
                      "Entrez le mot de passe", true, password, validpass),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Confirmez Le mot de passe",
                    style: TextStyle(fontSize: 22, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildFormFieldAll("Entrez le mot de passe 2éme fois", true,
                      confermpas, validconfpass),
                  //End user ENd
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Numéro de télephone",
                    style: TextStyle(fontSize: 22, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildFormFieldAlltel(
                      "Entrez le numéro de télephone", false, tel, validTEL),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 22, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildFormFieldAlltel(
                      "Entrez vo Description", false, des, validDec),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Categories",
                    style: TextStyle(fontSize: 22, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<User>(//dropdownColor: Colors.white38,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        isExpanded: true,
                        style: const TextStyle(color: Colors.blue, fontSize: 20),
                        value: selectedUser,
                        underline: Container(
                          height: 2,
                          color: Colors.blue,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedUser = newValue!;
                          });
                        },
                        items: users.map((User user) {
                          return DropdownMenuItem<User>(
                            value: user,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              child: Text(
                                user.name,

                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      child: const Text('Get Image'),
                      onPressed: pickerCamera),
                  //Text("selected user name is ${selectedUser.name} : and Id is : ${selectedUser.id}"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildFormFieldAll(String myhinttext, bool pass,
      TextEditingController mycontroller, myvalid) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: myvalid,
      controller: mycontroller,
      obscureText: pass,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(4),
          hintText: myhinttext,
          filled: true,
          fillColor: Colors.grey[200],
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blueGrey, style: BorderStyle.solid, width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blue, style: BorderStyle.solid, width: 1),
          )),
    );
  }

  TextFormField buildFormFieldAlltel(String myhinttext, bool pass,
      TextEditingController mycontroller, myvalid) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      validator: myvalid,
      controller: mycontroller,
      obscureText: pass,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(4),
          hintText: myhinttext,
          filled: true,
          fillColor: Colors.grey[200],
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blueGrey, style: BorderStyle.solid, width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blue, style: BorderStyle.solid, width: 1),
          )),
    );
  }
}
