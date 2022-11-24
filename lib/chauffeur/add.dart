import 'dart:convert';
import 'package:deidine/const/const.dart';
import 'package:intl/intl.dart';

import '../widgets/alert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class add extends StatefulWidget{
_addState createState()=> _addState();
}
class _addState extends State<add>{
  final _formKey = GlobalKey<FormState>();
 TextEditingController nom = TextEditingController();
  TextEditingController prenom= TextEditingController();
  TextEditingController telephone= TextEditingController();
  TextEditingController salaire= TextEditingController();
  
Future _reg()async  {//{$ip}
      var url = '${SERVER_NAME}chauffeur/add.php';
   var response = await http.post(url,body: {
        'nom' : nom.text,
        'prenom' : prenom.text,
        'telephone':telephone.text,
        'salaire':salaire.text
      });
    var data = json.decode(response.body);
    if (data == "yes") {
      MyAlertDialog.showAlertDialog(title: "succse", message: "l'information sont enregistrer en succs", myContext: context);
      nom.clear();
      prenom.clear();
      salaire.clear();
      telephone.clear();
    } else {
      debugPrint("no terminer");

      }}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text("REGISTRATION", style: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold
      )),
      elevation:0,
    backgroundColor:Color.fromRGBO(143, 148, 251, .6),  
      
      ),
      backgroundColor: Colors.white,
      body:Form(
        key: _formKey,
        child: SingleChildScrollView(
      	child: Container(
	        child: Column(
	          children: <Widget>[
              Container(
	              height: 100,
	              decoration: BoxDecoration(
	                image: DecorationImage(
	                  image: AssetImage('images/bus.png'),
	                  fit: BoxFit.fill
	                )
	              ),
	              ),
	            Padding(
	              padding: EdgeInsets.all(30.0),
	              child: Column(
	                children: <Widget>[
	                   Container(
	                    padding: EdgeInsets.all(5),
	                    decoration: BoxDecoration(
	                      color: Colors.white,
	                      borderRadius: BorderRadius.circular(10),
	                      boxShadow: [
	                        BoxShadow(
	                          color: Color.fromRGBO(143, 148, 251, .2),
	                          blurRadius: 20.0,
	                          offset: Offset(0, 10)
	                        )
	                      ]
	                    ),
	                    child: Column(
	                      children: <Widget>[
	                        Container(
	                          padding: EdgeInsets.all(8.0),
	                          decoration: BoxDecoration(
	                            border: Border(bottom: BorderSide(color: Colors.grey))
	                          ),
	                          child: TextFormField(
                              controller:nom, validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
      
	                            decoration: InputDecoration(
                                                  labelText: "nom",

                               prefixIcon: const Icon(Icons.person , color: Colors.black,),
                                enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(25.0),
                                                      borderSide: BorderSide(color:Color.fromRGBO(143, 148, 251, .6))
                                                  ),
	                              border: InputBorder.none,
	                              hintText: "Email or telephone number",
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        ),
	                        Container(
	                          padding: EdgeInsets.all(8.0),
	                          child: TextFormField(
                              controller: prenom,
                               validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
      
	                            decoration: InputDecoration(
                                labelText: "prenom",

                                        enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Color.fromRGBO(143, 148, 251, .6))
                                ),
                              prefixIcon: const Icon(Icons.person ,color: Colors.black,),

	                              border: InputBorder.none,
	                              hintText: "prenom",
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        ),
                                Divider(),
                            Container(
	                          padding: EdgeInsets.all(8.0),
	                          child: TextFormField(
                              controller: telephone,
                               validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
      
	                            decoration: InputDecoration(
                                labelText: "telephone",
                        enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Color.fromRGBO(143, 148, 251, .6))
                                ),
                              prefixIcon: const Icon(Icons.phone_android ,color: Colors.black,),
	                              border: InputBorder.none,
	                              hintText: "telephone",
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        ),
                                    Divider(),
                            Container(
	                          padding: EdgeInsets.all(8.0),
	                          child: TextFormField( 
                              controller: salaire,
                               validator: (value) {
                                  if (value == null || value.isEmpty ) {
                                 return 'Please enter some text';
                                  }
                                  return null;
                                },
      
	                            decoration: InputDecoration(
                                labelText: "salaire",

                                        enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Color.fromRGBO(143, 148, 251, .6))
                                ),
                              prefixIcon: const Icon(Icons.price_check ,color: Colors.black,),

	                              border: InputBorder.none,
	                              hintText: "salaire",
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        )
],
),
),
      SizedBox(height: 30,),
	                   Container(
	                    child: Center(
                        child:ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          padding:EdgeInsets.only(left:90.0,right: 90.0),
                          primary:Color.fromRGBO(143, 148, 251, .6),
                          textStyle: const TextStyle(
                          color: Colors.white, fontSize: 15, fontStyle: FontStyle.normal),
                          ),
                          onPressed: () {      
                              if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),);
      setState(() {
               _reg(); 
                });
                            }    
                            },
                          child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => home(),),);
                      ),),
	                  SizedBox(height: 70,)
                    
                     ],
	              ),
	            )
	          ],
	        ),
	      ),
      ))); }
}