import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class  cartitem extends StatefulWidget{
   @override
  _cartitemState createState() => _cartitemState();
}
class _cartitemState extends State<cartitem>{
 List<chauffeur_data> emprecord = [];

  Future<List<chauffeur_data>?> _getdeptemp() async {
    final response = await http.get('http://192.168.43.179/flutter/read.php');
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
  Widget build(BuildContext context){
    return
     Scaffold(body:
     SafeArea(child: Expanded(
              flex: 8,
              child: Container(
                child: FutureBuilder<dynamic>(
                    future: _getdeptemp(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                              return  Card(
                                          margin: EdgeInsets.all(8.0),
                                          child:Padding(padding: EdgeInsets.all(8.0),
                                          child: ListTile(
                                          leading:GestureDetector(child:Column(children: [Text("edit"),Icon(Icons.edit),],) ,
                                          onTap: (){
                                          debugPrint('Edit Clicked');
                                        },),
                                    title:Text(
                                              "${snapshot.data[index].nom}",
                                              textAlign: TextAlign.center,
                                              ),
                                    subtitle: Expanded(
                                              child: Text(
                                                  "${snapshot.data[index].prenom}",
                                                  textAlign: TextAlign.center,
                                                  )),
                                    trailing: Expanded(
                                                child: Text(
                                                    "${snapshot.data[index].telephone}",
                                                    textAlign: TextAlign.center,
                                                    )),
                                )),
                                );}
                                  
                            );}
                        
                         else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
    
     ))));
  }
}
/*CircleAvatar(
    child: Padding(padding: EdgeInsets.all(5.0),
    child:FittedBox(
      child: Text('kjnjfn'),
    ),),),*/
    

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
      telephone = json['telelphone'];
  }    
}
