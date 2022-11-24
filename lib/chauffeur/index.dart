import 'package:deidine/chauffeur/add.dart';
import 'package:deidine/chauffeur/chauf.dart';
import 'package:deidine/chauffeur/show.dart';
import 'package:flutter/material.dart';
import '../widgets/appBar.dart';

class Index extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      appBar:MyAppBar(title: Text("les chauffeur"),),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [ Container(
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
            onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (BuildContext contex) =>chauffeur_list())),
            icon:const Icon(Icons.slideshow_sharp)),const Text("afficher tout les chauffeurs")]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.center,
            children: [IconButton(
            onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (BuildContext contex) =>add())),
            icon:const Icon(Icons.add_box_sharp)),const Text("enregistrer un chauffeurs")]),
     Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.center,
            children: [IconButton(
            onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (BuildContext contex) =>Data_Chauf())),
            icon:const Icon(Icons.add_box_sharp)),const Text("Test")]),
            
            ]));}
}