// ignore_for_file: no_logic_in_create_state, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:awn_stage2/constants.dart';
import 'package:awn_stage2/domain/request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:awn_stage2/pages/widgets/header_widget.dart';
import '../Pages/login.dart';


class ProfilePageAdmin extends StatefulWidget {

  const ProfilePageAdmin({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ProfilePageAdminState();
}

class _ProfilePageAdminState extends State<ProfilePageAdmin> {

  var username;
  var tel;
  var lastname;
  var img;
  var id;
  var pawd;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString("username");

    if (username != null) {
      setState(() {
        username = preferences.getString("username");
        tel = preferences.getString("tel");
        img = preferences.getString("img");
        lastname = preferences.getString("lastname");
        id = preferences.getString("id");
        pawd = preferences.getString("password");
      });
    }
  }

  final TextEditingController _descripon = TextEditingController();
  final TextEditingController _localisation = TextEditingController();

  AddCommande() async {
    var dat = {
      "des": _descripon.text,
      "id_user": 'iduser',
      "id_fourni": 'id',
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
  Future getAdmin() async {
    var data = {"id": id};
    var response = await http
        .post(Uri.parse(urlBase + 'getAdmin.php'), body: data);
    var respnsebody = jsonDecode(response.body);
    return respnsebody;
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
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        elevation: 0,
        //iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,

      ),
      body: FutureBuilder(
        future: getAdmin(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (context, i) {
          return SingleChildScrollView(
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
                      snapshot.data[i]['username'] + ' ' + snapshot.data[i]['lastname'],
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
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:
                            const EdgeInsets.only(left: 8.0, bottom: 4.0),
                            alignment: Alignment.topLeft,
                            child: const Text(
                              "User Information",
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
                                            subtitle: Text(snapshot.data[i]['lastname'],),
                                          ),

                                           ListTile(
                                            leading: const Icon(Icons.person),
                                            title: const Text("About Me"),
                                            subtitle: Text(snapshot.data[i]['des'],),
                                          ),

                                          ListTile(
                                            leading:  const Icon(Icons.phone),
                                            title:  const Text("Phone"),
                                            subtitle: Text(snapshot.data[i]['tel'].toString(),),
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
        );
        },
        );
        }
        return const Center(
        child: CircularProgressIndicator(),
        );
        },
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
