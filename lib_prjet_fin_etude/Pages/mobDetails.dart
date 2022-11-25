import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/request.dart';
import 'choipaiemment.dart';


class MobDetails extends StatefulWidget {

  final id;
  final username;
  final tel;
  final password;
  final id_cat;
  final img;
  final des;

  MobDetails(
      {this.id,
        this.username,
        this.tel,
        this.password,
        this.id_cat,
        this.img,
        this.des});


  @override
  _MobDetailsState createState() => _MobDetailsState(id: this.id,
      username: this.username,
      tel: this.tel,
      password: this.password,
      id_cat: this.id_cat,
      img: this.img,
      des: this.des);
}

class _MobDetailsState extends State<MobDetails> {
  final id;
  final username;
  final tel;
  final password;
  final id_cat;
  final img;
  final des;

  _MobDetailsState(
      {this.id,
      this.username,
      this.tel,
      this.password,
      this.id_cat,
      this.img,
      this.des});

  var usernam;
  var tell;
  bool  isSigin = false;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    usernam = preferences.getString("username");
    tell = preferences.getString("tel");

    if(username != null) {
      setState(() {
        usernam = preferences.getString("username");
        tell = preferences.getString("tel");
        isSigin= true;
      });
    }
  }
  @override
  initState(){
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Descriptions'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 300,
              child: GridTile(
                child: Image.network(urlBaseAdmin+"/upload/$img"),
                footer: Container(
                    height: 70,
                    color: Colors.black.withOpacity(0.3),
                    child: Row(children: [
                      Expanded(child:
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          username,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                      ),),
                      // ignore: prefer_const_constructors
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "$tel",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                    )
                ),
              ),
            ),
            Container(decoration: BoxDecoration(
                border: const Border(top: BorderSide(color: Colors.grey)),borderRadius: BorderRadius.circular(60)),
              padding: const EdgeInsets.all(10),child: const Text("Propriétés :",style: TextStyle(fontSize: 29,fontWeight: FontWeight.w700),),),
            Container(padding: const EdgeInsets.all(8),child: Column(children: [
              Container(color: Colors.purpleAccent.withOpacity(0.7),width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(18),child: RichText(text: TextSpan(style: const TextStyle(fontSize: 25),children: <TextSpan>[
                  TextSpan(text: "id_cat" + " : "),
                  TextSpan(text: des,style: const TextStyle(color: Colors.white),)
                ],),),),
            ],),),
            Container(padding: const EdgeInsets.all(10),color: Colors.white60,
              child: Column(children: [
                //MySpec(context, "Samsung : ", name_D, Colors.white, Colors.blue),
               /* MySpec(context, "L\'écran : ", screen_D, Colors.grey.withOpacity(0.2), Colors.grey),
                MySpec(context, "Protection : ", screen_protect_D, Colors.white, Colors.grey),
                MySpec(context, "Résolution d\'écran : ", screen_res_D, Colors.grey.withOpacity(0.2), Colors.grey),
                MySpec(context, "Systeme d\'exploitation : ", system_D, Colors.white, Colors.grey),
                MySpec(context, "Processeur : ", cpu_D, Colors.grey.withOpacity(0.2), Colors.grey),
                MySpec(context, "GPU : ", gpu_D, Colors.white, Colors.grey),
                MySpec(context, "Mémoire : ", memory_D, Colors.grey.withOpacity(0.2), Colors.grey),
                MySpec(context, "RAM : ", ram_D, Colors.white, Colors.grey),
                MySpec(context, "Batterie : ", battery_D, Colors.grey.withOpacity(0.2), Colors.grey),*/
              ],),),
            Container(color: Colors.transparent,padding: const EdgeInsets.all(10),child: const Text("Camera :",style: TextStyle(fontSize: 29,fontWeight: FontWeight.w700),),),

            Container(padding: const EdgeInsets.all(10),
              child: Column(children: [/*
                MySpec(context, "Caméra Principale : ", camera_main_D, Colors.grey.withOpacity(0.2), Colors.grey),
                MySpec(context, "Caractéristiques du photographie : ", camera_feature_D, Colors.white, Colors.grey),
                MySpec(context, "Video : ", camera_video_D, Colors.grey.withOpacity(0.2), Colors.grey),
                MySpec(context, "Caméra ultrawide : ", camera_video_D, Colors.white, Colors.grey),
                MySpec(context, "Caméra micro : ", camera_micro_D, Colors.grey.withOpacity(0.2), Colors.grey),
                MySpec(context, "Caméra depth : ", camera_depth_D, Colors.white, Colors.grey),
                MySpec(context, "Caméra telephoto : ", camera_tele_D, Colors.grey.withOpacity(0.2), Colors.grey),
                MySpec(context, "Caméra frontale : ", camera_self_D, Colors.white, Colors.grey),
                MySpec(context, "Caractéristiques du photographie : ", camera_self_feature_D, Colors.grey.withOpacity(0.2), Colors.grey),
                MySpec(context, "Video : ", camera_self_video_D, Colors.white, Colors.grey),*/

              ],),),
            Container(padding: const EdgeInsets.all(0),margin: const EdgeInsets.only(left: 110,right: 110),
              child: ElevatedButton(child: const Text("Achat",style: TextStyle(fontSize: 29,fontWeight: FontWeight.w700),),
                onPressed: isSigin ? () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return choidepaiemment(id: id);
                  }));
                } : () {
                Navigator.of(context).pushNamed("login");
                },
              ),)
          ],
        ));
  }
}


MySpec(context, String feature, String details, Color colorbackground, Color colortext){
  return Container(width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      color: colorbackground,
      child: RichText(
          text: TextSpan(
              style:const TextStyle(fontSize: 19,color: Colors.black,),
              children: <TextSpan>[
            TextSpan(text: feature,style: const TextStyle(color: Colors.black,fontSize: 22)),
            TextSpan(text: details,style: TextStyle(color: colortext,),)
    ],),),);
}