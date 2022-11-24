import 'dart:convert';
import 'package:bs_flutter/bs_flutter.dart';
import 'package:deidine/const/const.dart';
import 'package:intl/intl.dart';

import '../widgets/alert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//Import intl in the file this is being done

class add extends StatefulWidget{
_addState createState()=> _addState();
}
class _addState extends State<add>{

 String dropdownvalue = 'Direction ';
  
  final _formKey = GlobalKey<FormState>();
 final items = [
  'Direction ',
    'Atar أطار',
    'Noukchott أنواكشوط',
    'Noudibou أنواذيبوا',
    'Akjoujat أكجوجت',
    'Zoirate أزويرات',
  ];


 TextEditingController nom = TextEditingController();
  TextEditingController prenom= TextEditingController();
  TextEditingController telephone= TextEditingController();
  TextEditingController prix= TextEditingController();
  TextEditingController numero= TextEditingController();
  TextEditingController date= TextEditingController();
  
var  _date =DateFormat("yyyy-MM-dd").format(DateTime.now());
void _showpick(){
  showDatePicker(

    context:context,
    initialDate:DateTime.now(),
firstDate:DateTime(2000),
lastDate:DateTime(2025)).then((value){
    setState((){
_date=DateFormat("yyyy-MM-dd").format(value!);
    date.text = DateFormat("yyyy-MM-dd").format(value) ; //default text
    });
});
}
  final dateFormat = DateFormat("dd-M-yyyy");
Future _reg()async  {
      var url = '${SERVER_NAME}client/add.php';

   var response = await http.post(url,body: {
        'nom' : nom.text,
        'prenom' : prenom.text,
        'telephone':telephone.text,
        'direction':dropdownvalue,
        'numero':numero.text,
        'prix':prix.text,
        'date':date.text
      });
    var data = json.decode(response.body);
    if (data == "yes") {
      MyAlertDialog.showAlertDialog(title: "succse", message: "l'information sont enregistrer en succs", myContext: context);
      nom.clear();
      prenom.clear();setState(() {
                  dropdownvalue = dropdownvalue;
                });
      telephone.clear();
      prix.clear();
      date.clear();
      numero.clear();
    } else {
      debugPrint("no terminer");

      }}
 @override
  void initState() {
    date.text =_date ;
     //default text
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:const Text("REGISTRATION", style: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold
      )),
      elevation:0,
    backgroundColor:const Color.fromRGBO(143, 148, 251, .6),  
      
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
	              decoration: const BoxDecoration(
	                image: DecorationImage(
	                  image: AssetImage('images/bus.png'),
	                  fit: BoxFit.fill
	                )
	              ),
	              ),
	            Padding(
	              padding: const EdgeInsets.all(30.0),
	              child: Column(
	                children: <Widget>[
	                   Container(
	                    padding: const EdgeInsets.all(5),
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
	                          padding: const EdgeInsets.all(8.0),
	                          decoration: const BoxDecoration(
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
                                                      borderSide: const BorderSide(color:const Color.fromRGBO(143, 148, 251, .6))
                                                  ),
	                              border: InputBorder.none,
	                              hintText: "Email or telephone number",
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        ),
                         Divider(),
              
	                        Container(
	                          padding: const EdgeInsets.all(8.0),
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
                              borderSide: const BorderSide(color: Color.fromRGBO(143, 148, 251, .6))
                                ),
                              prefixIcon: const Icon(Icons.person ,color: Colors.black,),

	                              border: InputBorder.none,
	                              hintText: "prenom",
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        ),
                                const Divider(),

                         Container(
	                          padding: const EdgeInsets.all(8.0),
	                          child: DropdownButton(
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },)),
                               Divider(),
                            Container(
	                          padding: const EdgeInsets.all(12.0),
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
                              borderSide: const BorderSide(color: const Color.fromRGBO(143, 148, 251, .6))
                                ),
                              prefixIcon: const Icon(Icons.phone_android ,color: Colors.black,),
	                              border: InputBorder.none,
	                              hintText: "telephone",
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        ),
                                    const Divider(),
                            Container(
	                          padding: const EdgeInsets.all(8.0),
	                          child: TextFormField(
                              controller: numero,
                               validator: (value) {
                                  if (value == null || value.isEmpty ) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
      
	                            decoration: InputDecoration(
                                labelText: "numero",

                                        enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(color: Color.fromRGBO(143, 148, 251, .6))
                                ),
                              prefixIcon: const Icon(Icons.price_check ,color: Colors.black,),

	                              border: InputBorder.none,
	                              hintText: "numero",
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        ),   const Divider(),
                            Container(
	                          padding: const EdgeInsets.all(8.0),
	                          child: TextFormField(
                              controller: prix,
                               validator: (value) {
                                  if (value == null || value.isEmpty ) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
      
	                            decoration: InputDecoration(
                                labelText: "prix",

                                        enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(color: const Color.fromRGBO(143, 148, 251, .6))
                                ),
                              prefixIcon: const Icon(Icons.price_check ,color: Colors.black,),

	                              border: InputBorder.none,
	                              hintText: "prix",
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        ),
                          Divider(),
                            Container(
	                          padding: EdgeInsets.all(8.0),
	                          child: TextFormField(
                              readOnly:true, 
                              controller: date,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                border: OutlineInputBorder(),
                                labelText: "date",
                                suffixIcon:  IconButton(icon:Icon(Icons.event_note), onPressed: () { _showpick(); }, ),

                                enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Color.fromRGBO(143, 148, 251, .6))
                                ),
	                              hintText: "date"),
	                          ),
	                        ),
                         
                     ],
	                    ),
	                  ),
                    const SizedBox(height: 30,),
	                   Container(
	                    child: Center(
                        child:ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          padding:const EdgeInsets.only(left:90.0,right: 90.0),
                          primary:const Color.fromRGBO(143, 148, 251, .6),
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
                          child: const Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => home(),),);
                      ),),
	                  const SizedBox(height: 70,)
                     ],
	              ),
	            )
	          ],
	        ),
	      ),
      ))); }
}

