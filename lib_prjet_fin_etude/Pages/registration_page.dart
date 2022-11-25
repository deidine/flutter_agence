import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awn_stage2/common/theme_helper.dart';
import 'package:awn_stage2/pages/widgets/header_widget.dart';
import '../Pages1/home.dart';
import '../domain/request.dart';


class RegistrationPage extends  StatefulWidget{
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
     return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage>{

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

  savePref(
      {required String username,
        required String tel,
        required String id,
        required String img,
        required String password,
        required String lastname}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id", id);
    preferences.setString("username", username);
    preferences.setString("tel", tel);
    preferences.setString("img", img);
    preferences.setString("password", password);
    preferences.setString("lastname", lastname);
  }
  

  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  TextEditingController username = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confermpas = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController id = TextEditingController();

  File? file ;

  Future pickerCamera() async {
    final myFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      file = File(myFile!.path);
    });
  }
  Future pickerFille() async {
    final myFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      file = File(myFile!.path);
    });
  }

  GlobalKey<FormState> formstatesigin = GlobalKey<FormState>();
  GlobalKey<FormState> formstatesiginup = GlobalKey<FormState>();
  siginup() async {
    if(file == null) return;
    String base64 = base64Encode(file!.readAsBytesSync());
    String imagename = file!.path.split("/").last;
      var data = {
        "tel": tel.text,
        "password": password.text,
        "username": username.text,
        "lastname": lastname.text,
        "imagepost" : imagename,
        "image64" : base64
      };
      var response = await http.post(
          Uri.parse(urlBase+'signup.php'),
          body: data);
      var respnsebody = jsonDecode(response.body);
      if (respnsebody['status'] == "success") {
        var dat = {"tel": tel.text, "password": password.text};
        var respons = await http.post(
            Uri.parse(urlBase+'login.php'),
            body: dat);
        var respnsebod = jsonDecode(respons.body);
        if (respnsebod['status'] == "success") {
          savePref(
              username: respnsebody['username'], password: respnsebody['password'],tel: respnsebody['tel'].toString(), id: respnsebody['id'].toString(), img: respnsebody['img'], lastname: respnsebody['lastname']);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const HomeScreen()
              ),
                  (Route<dynamic> route) => false
          );

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
      return "Le longuer min c'est 4 characteur";
    }
    if (val.trim().length > 100) {
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
  String pattern = r'[0-9]{8}$';

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
              height: 300,
              child: HeaderWidget(300, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              padding: const EdgeInsets.only(top: 100),
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
                        const SizedBox(height: 90,),
                        Container(
                          child: buildFormFieldAll(false,
                              username, validname, 'Nom', 'Entre votre nom',const Icon(Icons.person), null),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          child: buildFormFieldAll(false,
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

                        const SizedBox(height: 30.0),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
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
                        const SizedBox(height: 40.0),
                        //const Text("Or create account using social media",  style: TextStyle(color: Colors.grey),),
                        //const SizedBox(height: 25.0),
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