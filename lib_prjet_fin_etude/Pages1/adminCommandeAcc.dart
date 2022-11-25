// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../domain/request.dart';



class AdminCommandeAcc extends StatefulWidget {

  const AdminCommandeAcc({Key? key}) : super(key: key);

  @override
  State<AdminCommandeAcc> createState() => _AdminCommandeAccState();
}

class _AdminCommandeAccState extends State<AdminCommandeAcc> {

  Future getCommande() async {
    var data = {"id": id, "stus": 'Terminer'};
    var response = await http
        .post(Uri.parse(urlBase + 'getcommandeadmin.php'), body: data);
    var respnsebody = jsonDecode(response.body);
    return respnsebody;
  }
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

  DeleteCommand({required String id_c, required String stus}) async {
    var data = {"id_c": id_c, "stus": stus};
    var response = await http
        .post(Uri.parse(urlBase+'refisecommande.php'), body: data);
    var respnsebody = jsonDecode(response.body);
    if (respnsebody['status'] == "success delete") {
      setState(()  {
        if (kDebugMode) {
          print('true');
        }
      });
    }
  }
  showAlertWaring({required String id_c, required String stus}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: const[
              Icon(Icons.warning_amber_outlined,size: 60,
                color: Colors.red,
              ),
              Text('Vous avez sur', style: TextStyle(
                fontSize: 25,
                color: Colors.red,
              ),)
            ],
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
            Row(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(color: Colors.red.shade400,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'.toUpperCase()),
                ),
                FlatButton(color: Colors.blue.shade400,
                  onPressed: () {
                    DeleteCommand(id_c: id_c, stus: stus);
                    Navigator.of(context).pop();
                    //Navigator.of(context).pop();
                  },
                  child: Text('OK'.toUpperCase()),
                ),
              ],
            )
          ],
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 2,
                  color: Colors.red,
                  margin: const EdgeInsets.only(top: 4, bottom: 20),
                ),
                const Text('Vous avez sur'),
              ],
            ),
          ),
        );
      },
    );
  }
  var cardTextStyle = const TextStyle(
      fontFamily: "Montserrat Regular",
      fontSize: 23,
      color: Colors.black);
  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Commandes Accepter',
          style: cardTextStyle,),
      ),
      body: Container(height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: FutureBuilder(
          future: getCommande(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 13.0, horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        SizedBox(height: 26,),
                                        Text('Date', style: TextStyle(fontSize: 17, ),),SizedBox(height: 3,),
                                        Text('Nom', style: TextStyle(fontSize: 17, ),),SizedBox(height: 3,),
                                        Text('Tel', style: TextStyle(fontSize: 17, ),),SizedBox(height: 3,),
                                        Text('Location', style: TextStyle(fontSize: 17, )),SizedBox(height: 3,),
                                        Text('Contenue', style: TextStyle(fontSize: 17, )),

                                      ],
                                    )),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 26,),
                                      Text(snapshot.data[i]['date_de_commande'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                      Text(snapshot.data[i]['username'] + ' ' + snapshot.data[i]['lastname'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                      const SizedBox(height: 3,),Text(snapshot.data[i]['tel'].toString(), style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                      const SizedBox(height: 3,),Text(snapshot.data[i]['location'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                      const SizedBox(height: 3,),Text(snapshot.data[i]['Commande'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),

                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      /*
                      Container(
                          margin: const EdgeInsets.only(top: 0, left: 12),
                          child:
                          RawMaterialButton(
                            elevation: 2,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.red.shade300
                              ),
                              child: const Text(
                                'Refuser',
                                style: TextStyle(color: Colors.white,fontSize: 17),

                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                showAlertWaring(id_c: snapshot.data[i]['id'].toString(), stus: "refiser");
                                //
                              });
                              //pickerCamera();
                            },
                          )
                      ),
                      */

                      Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width - 135,),
                          padding: const EdgeInsets.only(right: 15, top: 0),
                          child: RawMaterialButton(
                            elevation: 2,
                            padding: EdgeInsets.zero,
                            shape: const CircleBorder(),
                            child: Container(
                                padding: const  EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.shade300,
                                ),
                                child:  Row(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(right: 4),
                                        padding: const EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100,),
                                            border: Border.all(color: kPrimaryColor,width: 1.5)
                                        ),child: const Icon(Icons.phone,size: 16,)),
                                    const SizedBox(height: 5,),
                                    const Text('Contacter', style: TextStyle(fontSize: 13),),
                                  ],
                                )),
                            onPressed: () {
                              setState(() {
                                showAlertWaring(id_c: snapshot.data[i]['id'].toString(), stus: "Terminer");
                                //print(id);
                                // showAlertWaring(id_c: snapshot.data[i]['id'].toString(), stus: "Finit");
                                //
                              });
                              //pickerCamera();
                            },
                          )
                      ),
                    ],
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
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