// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import '../constants.dart';
import '../domain/request.dart';



class Modifier extends StatefulWidget {
  final String id;
  final String fistname;
  final String lastname;
  final String phone;
  final String pawd;

  const Modifier(
      {Key? key, required this.id,
        required this.fistname,
        required this.lastname,
        required this.phone,
        required this.pawd}) : super(key: key);



  @override
  _ModifierState createState() => _ModifierState();

}
class _ModifierState extends State<Modifier> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pawd = TextEditingController();
var img;
var id;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    img = preferences.getString("img");
    id = preferences.getString("id");
    if (id != null) {
      setState(() {
        img = preferences.getString("img");
        id = preferences.getString("id");

      });
    }
  }

  bool editMode = false;
  /*
  Modifier_user() {
    if(editMode) {
      var url = 'http://192.168.11.93/web/edit.php';
      http.post(Uri.parse(url), body: {
        'id': widget.id.toString(),
        'fistname': firstName.text,
        'lastname': lastName.text,
        'phone': phone.text,
        'pawd': pawd.text,
        'img': img.text
      });
    }
  }*/
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


  showAlertNew(TextEditingController _Tchainge, String colname) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Dialog Title',
            textAlign: TextAlign.center,
          ),
          titleTextStyle: const TextStyle(
            fontSize: 16.0,
            color: kPrimaryColor,//Theme.of(context).textTheme.titleMedium.backgroundColor,
            fontWeight: FontWeight.w800,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),

          ),
          actions: <Widget>[
            FlatButton(color: Colors.red.shade400,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'.toUpperCase()),
            ),
            FlatButton(color: Colors.blue.shade400,
              onPressed: () {
              setState(() {
                firstName = _Tchainge;
                Modifier_user(_Tchainge, colname);
                Navigator.of(context).pop();
              });

                //Navigator.of(context).pop();
              },
              child: Text('OK'.toUpperCase()),
            ),
          ],
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: _Tchainge,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    //labelText: 'Localisation',
                  ),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    //FocusScope.of(context).requestFocus(_nodePassword);
                  },
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  Modifier_user(TextEditingController _Con, String colname) async {
    var data = {
      "colname": colname,
      "username": _Con.text,
      "id" : id.toString(),
    };
    var response = await http.post(
        Uri.parse(urlBase+'getEdit.php'),
        body: data);
    var respnsebody = jsonDecode(response.body);
    if (respnsebody['status'] == "success") {
        savePref(
            username: respnsebody['username'], tel: respnsebody['tel'].toString(),id: respnsebody['id'].toString(), password: respnsebody['password'],img: respnsebody['img'], lastname: respnsebody['lastname']);
        SweetAlert.show(context,title: "Just show a message",
            subtitle: "Sweet alert is pretty",
            style: SweetAlertStyle.success);
    }else{
      SweetAlert.show(context,
          title: "Just show a message",
          subtitle: "Sweet alert is pretty",
          style: SweetAlertStyle.error);
    }

  }
  Modifier_photo() async {

    String base64 = base64Encode(file!.readAsBytesSync());
    String imagename = file!.path.split("/").last;
    if(file != null) {
      var data = {
        "imagepost": imagename,
        "id": id.toString(),
        "image64": base64
      };
      var response =
          await http.post(Uri.parse(urlBase + 'getEditPhoto.php'), body: data);
      var respnsebody = jsonDecode(response.body);
      if (respnsebody['status'] == "success") {
        savePref(
            username: respnsebody['username'],
            tel: respnsebody['tel'].toString(),
            id: respnsebody['id'].toString(),
            password: respnsebody['password'],
            img: respnsebody['img'],
            lastname: respnsebody['lastname']);
        Navigator.of(context).pop();
        SweetAlert.show(context,
            title: "Just show a message",
            subtitle: "Sweet alert is pretty",
            style: SweetAlertStyle.success);
      } else {
        SweetAlert.show(context,
            title: "Just show a message",
            subtitle: "Sweet alert is pretty",
            style: SweetAlertStyle.error);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
    if(widget.id != null){
      editMode = true;
      firstName.text = widget.fistname;
      lastName.text = widget.lastname;
      phone.text = widget.phone;
      pawd.text = widget.pawd;
    }

  }

  void Modifier_message(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text("L'enregistrement a été modifié avec succès"),
        action: SnackBarAction(
            label: 'Annuler', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier'),
      ),
      body: Container(margin: const EdgeInsets.symmetric(horizontal: 20,),
        padding: const EdgeInsets.only(top: 30,),
        child: ListView(
          children: <Widget>[
            Center(
              child: file == null ?  img == null
                  ? GestureDetector(
                    child: Stack(
                      children: [
                      Container(
                       decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blueGrey, width: 3.0),
                          borderRadius: BorderRadius.circular(100)),
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
                            padding: const EdgeInsets.fromLTRB(87, 65, 0, 0),
                            child:
                            RawMaterialButton(
                              elevation: 10,
                              fillColor: Colors.blueGrey,
                              padding: const EdgeInsets.all(1.0),
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.edit,
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
                    height: 138,
                    width: 138,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: kPrimaryColor, width: 4.0),
                        borderRadius: BorderRadius.circular(100)),
                    child: CircleAvatar(
                      radius: null,
                      child: ClipRRect(
                        child: Image.network(
                          urlBaseImg + img,
                          fit: BoxFit.cover,
                          height: 138,
                          width: 138,
                        ),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  ),
                     Container(
                         padding: const EdgeInsets.fromLTRB(87, 65, 0, 0),
                         child:
                         RawMaterialButton(
                           elevation: 10,
                           fillColor: Colors.blueGrey,
                           padding: const EdgeInsets.all(1.0),
                           shape: const CircleBorder(),
                           child: const Icon(
                             Icons.edit,
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
                        padding: const EdgeInsets.fromLTRB(87, 65, 0, 0),
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
            ),
            TextButton(onPressed: (){
              Modifier_photo();
            }, child: const Text('Modifier Image')),
            const SizedBox(
              height: 50,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(left:10.0, top: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black12, width: 2.0),
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(onTap: (){
                    showAlertNew(firstName, 'username');
                    },
                  child: Row(
                    children: [
                      Text(firstName.text, style: const TextStyle(fontSize: 18.0),),
                      const Spacer(),
                      const Icon(Icons.edit,),
                      const Icon(Icons.arrow_forward_ios,),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(left:10.0, top: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black12, width: 2.0),
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  onTap: (){
                    showAlertNew(lastName, 'lastname');
                  },
                  child: Row(
                    children: [
                      Text(lastName.text, style: const TextStyle(fontSize: 18.0),),
                      const Spacer(),
                      const Icon(Icons.edit,),
                      const Icon(Icons.arrow_forward_ios,),

                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(left:10.0, top: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black12, width: 2.0),
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  onTap: (){
                    showAlertNew(phone, 'tel');
                  },
                  child: Row(
                    children: [
                      Text(phone.text, style: const TextStyle(fontSize: 18.0),),
                      const Spacer(),
                      const Icon(Icons.edit,),
                      const Icon(Icons.arrow_forward_ios,),

                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(left:10.0, top: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black12, width: 2.0),
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  onTap: (){
                    showAlertNew(pawd, 'password');
                  },
                  child: Row(
                    children: [
                      Text(pawd.text, style: const TextStyle(fontSize: 18.0),),
                      const Spacer(),
                      const Icon(Icons.edit,),
                      const Icon(Icons.arrow_forward_ios,),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*

            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    onPrimary: Colors.white,
                    shadowColor: Colors.blueAccent,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    minimumSize: const Size(100, 40),
                  ),
                  onPressed: () {
                    Modifier_user();

                  },
                  child: const Text('Modifier'),
                )),
 */