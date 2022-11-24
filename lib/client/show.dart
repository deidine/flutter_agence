import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Show_Client extends StatefulWidget {
  @override
  _Show_ClientState createState() => _Show_ClientState();
}

class _Show_ClientState extends State<Show_Client> {
  List<Client_data> emprecord = [];

  Future<List<Client_data>?> _getdeptemp() async {
    final response = await http.get('http://192.168.43.179/flutter/client/read.php');
    if (response.statusCode == 200) {
      List paresd = jsonDecode(response.body);
      return paresd.map((emp) => Client_data.fromJson(emp)).toList();
    }
  }

  @override
  void initState() {
    _getdeptemp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        title: Text("Employee Data"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.pinkAccent[100],
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    const Expanded(
                      child: Text(
                        "nom",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text("prenom",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  const  Expanded(
                      child: Text("ID",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  const Expanded(
                      child: Text("Telephone",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                child: FutureBuilder<dynamic>(
                    future: _getdeptemp(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 0,
                              margin: EdgeInsets.all(0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                            "${snapshot.data[index].nom}",
                                            textAlign: TextAlign.center,
                                            )),
                                    Expanded(
                                        child: Text(
                                            "${snapshot.data[index].prenom}",
                                            textAlign: TextAlign.center,
                                            )),
                                    Expanded(
                                        child: Text(
                                            "${snapshot.data[index].direction}",
                                            textAlign: TextAlign.center,
                                            )),
                                    Expanded(
                                        child: Text(
                                            "${snapshot.data[index].telephone}",
                                            textAlign: TextAlign.center,
                                            )),
                                            Expanded(
                                        child:Column(
                                          children :[
                                          IconButton(icon:Icon(Icons.edit), onPressed: () {  },),
                                           Text("${snapshot.data[index].telephone}",
                                            textAlign: TextAlign.center,)
                                   ]) )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class Client_data{
  String? direction;
  String? nom;
  String? prenom;
  String? telephone;

  Client_data({this.direction, this.nom, this.prenom,
                this.telephone});

  Client_data.fromJson(Map<String,dynamic> json){
      direction = json['direction'];
      nom = json['nom'];
      prenom = json['prenom'];
      telephone = json['telephone'];
  }    
}
