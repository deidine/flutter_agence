// ignore_for_file: prefer_const_constructors

import 'edit.dart';

import 'add.dart';
import 'num_pac.dart';
import 'show.dart';
import 'test.dart';
import 'package:flutter/material.dart';
import '../widgets/appBar.dart';
import 'table.dart';
class Client extends StatelessWidget{
  const Client({Key? key}) : super(key: key);

   
  Widget build(BuildContext context){
    return Scaffold(
      appBar:MyAppBar(title: Text("les client"),),
      body:SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
        children: [Expanded(
                      child: GestureDetector(
                        onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (BuildContext contex) =>NumericPad(onNumberSelected: (int ) {  },)));
                          
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFDC3D),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "NumericPad",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                     SizedBox(
                      height:MediaQuery.of(context).size.height /5,
                      child: Image.asset(
                        'images/logo.png'
                      ),
                    ),
 Container(
          height: 150.0,
          width: 150.0,
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child:CircleAvatar(
                    backgroundColor: Colors.green[500],
                    radius: 108,
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('images/bus.png'),
                      radius: 100,
                    ), 
                  ), ),),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.center,
            children: [IconButton(
            onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (BuildContext contex) =>Show_Client())),
            icon:const Icon(Icons.slideshow_sharp)),const Text("afficher tout les client")]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.center,
            children: [IconButton(
            onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (BuildContext contex) =>add())),
            icon:const Icon(Icons.add_box_sharp)),const Text("ajouter tout les client")]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.center,
            children: [IconButton(
            onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (BuildContext contex) =>edit())),
            icon:const Icon(Icons.tab_unselected)),const Text("edit tout les client")]),
            ElevatedButton(onPressed: (){},
             child: Text("delete"))
            ,
              ElevatedButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (BuildContext contex) =>Table2()));
            }, child: Text("table")),
            ])));}
}