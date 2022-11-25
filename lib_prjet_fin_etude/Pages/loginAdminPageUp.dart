// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awn_stage2/common/theme_helper.dart';
import 'package:awn_stage2/pages/widgets/header_widget.dart';

import '../domain/request.dart';

class User {
  const User(this.id,this.name);

  final String name;
  final int id;
}

class LoginAdminPageUp extends  StatefulWidget{
  const LoginAdminPageUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<LoginAdminPageUp>{

  showdialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: const [Text("Loadin..."), CircularProgressIndicator()],
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
  late User selectedUser;
  List<User> users = <User>[const User(5,'Select Categorie'),const User(1,'Plombier'), const User(2,'Electriciens'), const User(3,'Peindre'),const User(4,'Menuiser')];


  String valueChoose = "";
  List listItem = [
    "Plombier ", "Electriciens", "Peindre", "Menuiser"
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
  TextEditingController lastname = TextEditingController();

  GlobalKey<FormState> formstatesigin = GlobalKey<FormState>();
  GlobalKey<FormState> formstatesiginup = GlobalKey<FormState>();

  savePref(
      {required String username,
        required String lastname,
        required String password,
        required String img,
        required String tel,
        required String id}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id", id);
    preferences.setString("username", username);
    preferences.setString("lastname", lastname);
    preferences.setString("password", password);
    preferences.setString("img", img);
    preferences.setString("tel", tel);

  }

  String pattern = r'[0-9]{8}$';



  siginup() async {
    if(file == null) return;
    String base64 = base64Encode(file!.readAsBytesSync());
    String imagename = file!.path.split("/").last;


      var data = {
        "tel": tel.text,
        "password": password.text,
        "username": username.text,
        "lastname": lastname.text,
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
          savePref(id: respnsebod['id'].toString(), lastname: respnsebod['lastname'].toString(), tel: respnsebod['tel'].toString(), img: respnsebod['img'], username: respnsebod['username'], password: respnsebod['password']);
          Navigator.of(context).pushNamed("HomeScreenFournisseur");

        }
        //Navigator.of(context).pushNamed("home");
      } else {
        Navigator.of(context).pop();
        showdialogall(context, "Erreur", "Numéro de télephone existe déjà ");
      }

  }

  String? validname(String val) {
    if (val.trim().isEmpty) {
      return "Le nom ne peut pas être vide";
    }
    if (val.trim().length < 4) {
      return "Le longueur min c'est 4 characteur";
    }
    if (val.trim().length > 100) {
      return "Le longueur max c'est 100 characteur";
    } else {
      return null;
    }
  }
  String? validDec(String val) {
    if (val.trim().isEmpty) {
      return "Le nom ne peut pas être vide";
    }
    if (val.trim().length < 10) {
      return "Le longueur min c'est 10 characteur";
    }
    if (val.trim().length > 250) {
      return "Le longueur max c'est 100 characteur";
    } else {
      return null;
    }
  }

  String? validpass(String val) {
    if (val.trim().isEmpty) {
      return "Le mot de passe ne peut pas être vide";
    }
    if (val.trim().length < 6) {
      return "Le longueur min c'est 6 characteur ";
    }
    if (val.trim().length > 100) {
      return "Le longueur max c'est 100 characteur";
    } else {
      return null;
    }
  }

  String? validconfpass(String val) {
    if (val != password.text) {
      return "le mot de passe C'est pas identique";
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



  bool showsignin = true;

  @override
  void initState() {
    selectedUser= users[0];
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
    final myFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      file = File(myFile!.path);
    });

  }
  Future pickerFille() async {
    final myFil = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(myFil!.path);
    });

  }

  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  bool isOPscure = false;
  bool isOPscur = false;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded,),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        file == null ?
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.blueGrey,
                                        width: 3.0
                                    ),
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        width: 5, color: Colors.white),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20,
                                        offset: Offset(5, 5),
                                      ),
                                    ],
                                  ),
                                  child: SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.grey.shade300,
                                      size: 80.0,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.fromLTRB(65, 65, 0, 0),
                                  child:
                                  RawMaterialButton(
                                    elevation: 10,
                                    fillColor: Colors.blueGrey,
                                    padding: const EdgeInsets.all(1.0),
                                    shape: const CircleBorder(),
                                    child: const Icon(
                                      Icons.add_a_photo,
                                      color: Colors.indigo,
                                      size: 22.0,
                                    ),
                                      onPressed: () {
                                        showDialog(context: context, builder: (BuildContext context) {
                                        return  AlertDialog(
                                          title: const Text('Choisie une option',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                                          ),
                                          content: SingleChildScrollView(
                                            child: SingleChildScrollView(
                                              child: ListBody(
                                                children: [
                                                   InkWell(
                                                     onTap: () {
                                                       pickerCamera();
                                                       Navigator.of(context).pop();
                                                     },
                                                    splashColor: Colors.blueGrey,
                                                    child: Row(
                                                      children: const [
                                                        Padding(
                                                          padding: EdgeInsets.all(8.0),
                                                          child: Icon(
                                                            Icons.camera,
                                                            color: Colors.indigo,
                                                          ),
                                                        ),
                                                        Text("Camera",
                                                          style: TextStyle(fontSize: 18, color: Colors.blueGrey, fontWeight: FontWeight.w500),),
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                     onTap: () {
                                                       pickerFille();
                                                       Navigator.of(context).pop();
                                                     },
                                                    splashColor: Colors.blueGrey,
                                                    child: Row(
                                                      children: const [
                                                        Padding(
                                                          padding: EdgeInsets.all(8.0),
                                                          child: Icon(
                                                            Icons.image,
                                                            color: Colors.indigo,
                                                          ),
                                                        ),
                                                        Text("Gallerie",
                                                          style: TextStyle(fontSize: 18, color: Colors.blueGrey, fontWeight: FontWeight.w500),),
                                                      ],
                                                    ),
                                                  ),
                                               ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                      //pickerCamera();
                                    },
                                  )
                              ),
                            ],
                          ),
                        )
                        : Stack(
                          children: [
                              Container(
                                height: 118,
                                width: 118,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.indigo,
                                        width: 3.0
                                    ),
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: CircleAvatar(
                                  radius: null,
                                  child: ClipRRect(child: Image.file(file!, fit: BoxFit.cover,
                                    height: 112,
                                    width: 112,
                                  ),
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(65, 65, 0, 0),
                                child:
                                RawMaterialButton(
                                  elevation: 10,
                                  fillColor: Colors.blueGrey,
                                  padding: const EdgeInsets.all(1.0),
                                  shape: const CircleBorder(),
                                  child: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.indigo,
                                    size: 22.0,
                                  ),
                                  onPressed: () {
                                    showDialog(context: context, builder: (BuildContext context) {
                                      return  AlertDialog(
                                        title: const Text('Choisie une option',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                                        ),
                                        content: SingleChildScrollView(
                                          child: SingleChildScrollView(
                                            child: ListBody(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    pickerCamera();
                                                  },
                                                  splashColor: Colors.blueGrey,
                                                  child: Row(
                                                    children: const [
                                                      Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Icon(
                                                          Icons.camera,
                                                          color: Colors.indigo,
                                                        ),
                                                      ),
                                                      Text("Camera",
                                                        style: TextStyle(fontSize: 18, color: Colors.blueGrey, fontWeight: FontWeight.w500),),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    pickerFille();
                                                  },
                                                  splashColor: Colors.blueGrey,
                                                  child: Row(
                                                    children: const [
                                                      Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Icon(
                                                          Icons.image,
                                                          color: Colors.indigo,
                                                        ),
                                                      ),
                                                      Text("Gallerie",
                                                        style: TextStyle(fontSize: 18, color: Colors.blueGrey, fontWeight: FontWeight.w500),),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      file = null;
                                                    });
                                                  },
                                                  splashColor: Colors.blueGrey,
                                                  child: Row(
                                                    children: const [
                                                      Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Icon(
                                                          Icons.remove_circle_sharp,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      Text("Suprimé",
                                                        style: TextStyle(fontSize: 18, color: Colors.redAccent, fontWeight: FontWeight.w500),),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                    //pickerCamera();
                                  },
                                )
                            ),
                          ],
                        ),
                        const SizedBox(height: 30,),
                        Container(
                          child: buildFormFieldAll(false,
                            username, validname, 'Nom', 'Entre votre nom',const Icon(Icons.person), null),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          child:  buildFormFieldAll(false,
                              lastname, validname, 'Prenom', 'Entre votre prenom', const Icon(Icons.person), null),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: buildFormFieldAlltel(false,
                              tel, validTEL, 'Numero de Tel', 'Entre votre numero de tel'),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: buildFormFieldAll(isOPscure,
                              password, validpass, 'Mots de passe*', 'Entre votre numero mots de passe', const Icon(Icons.vpn_key),InkWell(
                                child: isOPscure ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                                onTap: (){
                                  setState(() {
                                    isOPscure = !isOPscure;
                                  });
                                },
                              )
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: buildFormFieldAll(isOPscur,
                              confermpas, validconfpass, 'Confirme le mots de passe', 'Confirme mots de passe'
                              , const Icon(Icons.vpn_key),InkWell(
                                child: isOPscur ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                                onTap: (){
                                  setState(() {
                                    isOPscur = !isOPscur;
                                  });
                                },
                              )
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Center(
                          child:  Padding(
                                padding: const EdgeInsets.only(right:2.0, left: 2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blueGrey,
                                  width: 0.8
                                ),
                                borderRadius: BorderRadius.circular(15.0)
                              ),
                              child: DropdownButton<User>(//dropdownColor: Colors.white38,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 37,
                                hint: const Text('Select Categorie'),
                                elevation: 1,
                                isExpanded: true,
                                style: const TextStyle(color: Colors.black38, fontSize: 20),
                                value: selectedUser,
                                underline: const SizedBox(),

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
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: buildFormFieldDes(false,
                              des, validDec, 'Description', 'Enter your Description'),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        /*
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    const Text("I accept all terms and conditions.", style: TextStyle(color: Colors.grey),),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Theme.of(context).errorColor,fontSize: 12,),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),

                         */
                        const SizedBox(height: 40.0),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Register".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                siginup();

                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 30.0),

                        const SizedBox(height: 25.0),
                        /*
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.googlePlus, size: 35,
                                color: HexColor("#EC2D2F"),),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog("Google Plus","You tap on GooglePlus social icon.",context);
                                    },
                                  );
                                });
                              },
                            ),
                            const SizedBox(width: 30.0,),
                            GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(width: 5, color: HexColor("#40ABF0")),
                                  color: HexColor("#40ABF0"),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.twitter, size: 23,
                                  color: HexColor("#FFFFFF"),),
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog("Twitter","You tap on Twitter social icon.",context);
                                    },
                                  );
                                });
                              },
                            ),
                            const SizedBox(width: 30.0,),
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.facebook, size: 35,
                                color: HexColor("#3E529C"),),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog("Facebook",
                                          "You tap on Facebook social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                        */
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}


TextFormField buildFormFieldAll(bool pass,
    TextEditingController mycontroller, myvalid, String s1, String s2, Icon? icon, Widget? wd) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: myvalid,
    controller: mycontroller,
    obscureText: pass,
    decoration: ThemeHelper().textInputDecoration(s1, s2, icon, wd),
  );
}
TextFormField buildFormFieldDes(bool pass,
    TextEditingController mycontroller, myvalid, String s1, String s2) {
  return TextFormField(
    maxLines: 3,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: myvalid,
    controller: mycontroller,
    obscureText: pass,
    decoration: ThemeHelper().textInputDecoration(s1, s2, const Icon(Icons.description)),
  );
}

TextFormField buildFormFieldAlltel(bool pass,
    TextEditingController mycontroller, myvalid, String s1, String s2) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: myvalid,
    controller: mycontroller,
    obscureText: pass,
    keyboardType: TextInputType.phone ,
    decoration: ThemeHelper().textInputDecoration(s1, s2, const Icon(Icons.phone_android)),
  );
}

/*
(val) {
                              if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                return "Enter a valid email address";
                              }
 */