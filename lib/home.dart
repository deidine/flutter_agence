import 'package:deidine/chauffeur/index.dart';
import 'package:deidine/chauffeur/index.dart';
import 'package:deidine/client/index.dart';
import 'package:deidine/test/client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/drawer.dart';
import 'widgets/appBar.dart';

// ignore: camel_case_types
class home extends StatefulWidget {

final SharedPreferences? prefs;
home({Key? key,this.prefs});
  @override
_homeState createState() => _homeState();

}
class _homeState extends State<home>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
drawer:  HomeDrawer(prefs: widget.prefs),
      appBar: MyAppBar(title: Text("home"),),
      body:ListView(
physics:BouncingScrollPhysics(),
        children: [
        body(),
        Text("rrr")
      ])
    );
  }

body(){
   return SingleChildScrollView(
        physics: BouncingScrollPhysics(),

scrollDirection:Axis.horizontal ,
child:Row(children:[
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
       Center(
        child: Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.greenAccent[100],
          child: SizedBox(
            width: 200,
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green[500],
                    radius: 108,
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('images/helpImage.png'),
                      radius: 100,
                    ), 
                  ), 
                  // const SizedBox(
                  //   height: 10,
                  // ), 
                  Text(
                    'les clients',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.green[900],
                      fontWeight: FontWeight.w500,
                    ),
                  ), 
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  const SizedBox(
                    height: 10,
                  ), 
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext contex) =>
                            Client())),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: const [
                            Icon(Icons.touch_app),
                            Text('Visit'),
                            
                          ],
                        ),
                      ),
                    ),
                  ) 
                ],))))),            
  Center(
        child: Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.greenAccent[100],
          child: SizedBox(
            width: 200,
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green[500],
                    radius: 108,
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('images/bus.png'),
                      radius: 100,
                    ), 
                  ), 
                  // const SizedBox(
                  //   height: 10,
                  // ), 
                  Text(
                    'les chauf',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.green[900],
                      fontWeight: FontWeight.w500,
                    ),
                  ), 
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  const SizedBox(
                    height: 10,
                  ), 
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext contex) =>
                            Index())),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: const [
                            Icon(Icons.touch_app),
                            Text('Visit'),
                            
                          ],
                        ),
                      ),
                    ),
                  ) 
                ],))))),
             ])
      );
  }
}