// ignore_for_file: no_logic_in_create_state, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awn_stage2/constants.dart';
import 'package:awn_stage2/domain/request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:awn_stage2/pages/widgets/header_widget.dart';

import 'login.dart';

class ProfilePage extends StatefulWidget {
  final id_D;
  final username_D;
  final lastname_D;
  final tel_D;
  final password_D;
  final id_cat_D;
  final img_D;
  final des_D;
  final isFavorite;
  final cat_name_D;

   const ProfilePage(
      {Key? key, this.id_D,
      this.username_D,
      this.isFavorite,
      this.lastname_D,
      this.tel_D,
      this.password_D,
      this.id_cat_D,
      this.img_D,
      this.cat_name_D,
      this.des_D}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ProfilePageState(
      des: des_D,
      id: id_D,
      isFavorite: isFavorite,
      id_cat: id_cat_D,
      img: img_D,
      password: password_D,
      tel: tel_D,
      cat_name: cat_name_D,
      username: username_D,
      lastname: lastname_D);
}

class _ProfilePageState extends State<ProfilePage> {
  final id;
  final username;
  final lastname;
  final tel;
  final password;
  final id_cat;
  final img;
  final des;
  var isFavorite;
  final cat_name;

  _ProfilePageState(
      {required this.id,
      required this.username,
      required this.isFavorite,
      required this.lastname,
      required this.cat_name,
      required this.tel,
      required this.password,
      required this.id_cat,
      required this.img,
      required this.des});


  var usernm;
  var iduser;


  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    usernm = preferences.getString("username");
    iduser = preferences.getString("id");

    if (usernm != null) {
      setState(() {
        iduser = preferences.getString("id");

      });
    }
  }
  final TextEditingController _descripon = TextEditingController();
  final TextEditingController _localisation = TextEditingController();

  AddCommande() async {
    var dat = {
      "des": _descripon.text,
      "id_user": iduser,
      "id_fourni": id,
      "loc": _localisation.text
    };
    var respons = await http.post(
        Uri.parse(urlBase+'addcommade.php'),
        body: dat);
    var respnsebod = jsonDecode(respons.body);
    if (respnsebod['status'] == "success add") {
      Navigator.of(context).pop();

    }else{

      showdialogall(context, "Erreur", "Numéro de télephone existe déjà ");
    }
    //Navigator.of(context).pushNamed("home");


  }
  showAlertNew() {
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
                AddCommande();
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
                  controller: _localisation,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Localisation',
                  ),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    //FocusScope.of(context).requestFocus(_nodePassword);
                  },
                ),
                TextField(
                  controller: _descripon,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future deleteFavorite({required String Uid, required String Aid}) async{
    if(isFavorite){
     // Future deleteFavorite({required String Uid, required String Aid}) async{

        var data = {"user_id": Uid, "admin_id": Aid};
        var response = await http
            .post(Uri.parse(urlBase+'delete.php'), body: data);
        setState(() {
          isFavorite = !isFavorite;
        });
     // }
    }else
    {
      var data = {"admin_id": Aid, "user_id": Uid, "fav": '1'};
      var response =
          await http.post(Uri.parse(urlBase + 'addcomment.php'), body: data);
      var respnsebody = jsonDecode(response.body);

      if (respnsebody['status'] == "success add") {
        setState(() {
          isFavorite = !isFavorite;
        });
      } else {
        //showAlert(context, id);
        print("errer");
      }
    }
  }

  @override
  initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.1,
        iconTheme: const IconThemeData(color: Colors.black),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
              ])),
        ),

      ),
      /*drawer: Drawer(
        child: Container(
          decoration:BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 1.0],
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).accentColor.withOpacity(0.5),
                  ]
              )
          ) ,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 1.0],
                    colors: [ Theme.of(context).primaryColor,Theme.of(context).accentColor,],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text("FlutterTutorial.Net",
                    style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.screen_lock_landscape_rounded, size: _drawerIconSize, color: Theme.of(context).accentColor,),
                title: Text('Splash Screen', style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen(title: "Splash Screen")));
                },
              ),
              ListTile(
                leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Login Page', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.person_add_alt_1, size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Registration Page',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.password_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Forgot Password Page',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.verified_user_sharp, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Verification Page',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => const ForgotPasswordVerificationPage()), );
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.login, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Admin Page',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  Navigator.of(context).pushNamed('loginAdminPage');
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.list, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('List User',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  Navigator.of(context).pushNamed('listUsers');
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Logout',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ), */

      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(
              height: 100,
              child: HeaderWidget(100, false, Icons.house_rounded),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: img == null
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
                            ],
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    username + ' ' + lastname,
                    style: const TextStyle(
                        fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    height: 2,
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(//padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          child:  isFavorite ? const Icon(Icons.favorite,color: kPrimaryColor, size: 42,) :
                          const Icon(Icons.favorite_border,color: kPrimaryColor, size: 38,),
                          onTap: (){
                            setState(()  {
                              getPref();
                              deleteFavorite(Aid: id, Uid: iduser);

                              // print(id);
                            });
                          },
                        ),
                      ),
                        Container(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "Information de Fournisseur ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(1),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        const ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          leading: Icon(Icons.my_location),
                                          title: Text("Location"),
                                          subtitle: Text("USA"),
                                        ),
                                        ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 4),
                                          leading: const Icon(Icons.category),
                                          title: const Text("Categorie"),
                                          subtitle: Text(cat_name),
                                        ),

                                        ListTile(
                                          leading: const Icon(Icons.person),
                                          title: const Text("About Me"),
                                          subtitle: Text(des),
                                        ),
                                      /*  FlatButton(
                                          focusColor: kPrimaryColor,
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () => showAlert(
                                              context, tel.toString()),
                                          child: ListTile(
                                            leading: const Icon(Icons.phone),
                                            title: const Text("Phone"),
                                            subtitle: Text(tel.toString()),
                                          ),
                                        ),*/
                                        FlatButton(
                                          focusColor: kPrimaryColor,
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () => showAlertNew(),
                                          child: const ListTile(
                                            leading:  Icon(Icons.phone),
                                            title:  Text("Contacter"),
                                            subtitle: Text("Submit"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


showAlert(BuildContext context, String phoneNumber) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 8.0,
        contentPadding: const EdgeInsets.all(18.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => launch('tel:' + phoneNumber),
                child: Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  child: const Text('Call'),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () => launch('sms:' + phoneNumber),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: const Text('Message'),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () => launch('https://wa.me/' + phoneNumber),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: const Text('WhatsApp'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
