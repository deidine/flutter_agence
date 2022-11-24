import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class chauffeur_list extends StatefulWidget {
  @override
  _chauffeur_listState createState() => _chauffeur_listState();
}

class _chauffeur_listState extends State<chauffeur_list> {
  List<chauffeur_data> emprecord = [];

  Future<List<chauffeur_data>?> _getdeptemp() async {
    final response = await http.get('http://192.168.43.179/flutter/chauffeur/read.php');
    if (response.statusCode == 200) {
      List paresd = jsonDecode(response.body);
      return paresd.map((emp) => chauffeur_data.fromJson(emp)).toList();
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
                                            "${snapshot.data[index].id}",
                                            textAlign: TextAlign.center,
                                            )),
                                    Expanded(
                                        child: Text(
                                            "${snapshot.data[index].telephone}",
                                            textAlign: TextAlign.center,
                                            )),
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

DataTable show_table(){
  return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Name',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Age',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Role',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Ravi')),
            DataCell(Text('19')),
            DataCell(Text('Student')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Jane')),
            DataCell(Text('43')),
            DataCell(Text('Professor')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('William')),
            DataCell(Text('27')),
            DataCell(Text('Professor')),
          ],
        ),
      ],
    );
}
class chauffeur_data{
  String? id;
  String? nom;
  String? prenom;
  String? telephone;

  chauffeur_data({this.id, this.nom, this.prenom,
                this.telephone});

  chauffeur_data.fromJson(Map<String,dynamic> json){
      id = json['id'];
      nom = json['nom'];
      prenom = json['prenom'];
      telephone = json['telephone'];
  }    
}
