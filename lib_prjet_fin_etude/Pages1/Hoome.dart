


import 'package:awn_stage2/domain/request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import '../Pages/MobList.dart';
import '../Pages/mobDetails.dart';
import '../Pages/profile_page.dart';
import '../constants.dart';
import '../myDrawer.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Home5 extends StatefulWidget {
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home5> {

  List<dynamic> listsearch =[] ;

  Future getData() async {
    var url = Uri.parse(urlBase+'search.php');
    var response = await http.get(url);
    var respnsebody = jsonDecode(response.body);
    for(int i=0 ; i < respnsebody.length ; i++){
      listsearch.add(respnsebody[i]['username']);
    }
  }

  Future getPhone() async {

    var response = await http.get(Uri.parse(urlBase+'inde.php'));
    var respnsebody = jsonDecode(response.body);
    return respnsebody;

  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Accueil',style: TextStyle(fontSize: 22),),
          centerTitle: true,
          elevation: 2,
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {
              showSearch(context: context, delegate: DataSearch(list: listsearch));
            },)
          ],
          primary: true,
        ),
        drawer: const MyDrawer(),
        body: Container(color: Colors.white54,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 200,width: double.infinity,
                  child: Carousel(
                    images: const[
                      AssetImage('images/p1.JPG'),
                      AssetImage('images/p2.JPG'),
                      AssetImage('images/p4.JPG'),
                    ],
                    boxFit: BoxFit.cover,
                    dotColor: Colors.blueGrey,
                    dotBgColor: Colors.yellowAccent.withOpacity(0.2),
                  ),
                ),
              ),

              /*Container(
                padding: const EdgeInsets.all(3),
                child: const Text(
                  'Categories',
                  style: TextStyle(fontSize: 30, color: Colors.blue),
                ),
              ),*/

              Container(color: Colors.white54,
                child: SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      //Start Categories
                      InkWell(
                        child: SizedBox(
                          height: 80,
                          width: 100,
                          child: ListTile(
                            title: Image.asset(
                              'images/c6.PNG',
                              width: 80,
                              height: 80,
                              fit: BoxFit.contain,
                            ),
                            subtitle: const Text(
                              'Samsung',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('samsung');
                        },
                      ),
                      InkWell(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: ListTile(
                            title: Image.asset(
                              'images/c5.JPG',
                              width: 80,
                              height: 80,
                              fit: BoxFit.contain,
                            ),
                            subtitle: const Text(
                              'Apple',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('iphone');
                        },
                      ),
                      InkWell(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: ListTile(
                            title: Image.asset(
                              'images/c1.JPG',
                              width: 80,
                              height: 80,
                              fit: BoxFit.contain,
                            ),
                            subtitle: const Text(
                              'Huawei',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('huawei');
                        },
                      ),
                      InkWell(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: ListTile(
                            title: Image.asset(
                              'images/c3.PNG',
                              width: 80,
                              height: 80,
                              fit: BoxFit.contain,
                            ),
                            subtitle: const Text(
                              'Xiaomi',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('xiaomi');
                        },
                      ),

                      InkWell(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: ListTile(
                            title: Image.asset(
                              'images/O1.jpg',
                              width: 80,
                              height: 80,
                              fit: BoxFit.contain,
                            ),
                            subtitle: const Text(
                              'Oppo',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('oppo');
                        },
                      ),

                      InkWell(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: ListTile(
                            title: Image.asset(
                              'images/R1.png',
                              width: 80,
                              height: 80,
                              fit: BoxFit.contain,
                            ),
                            subtitle: const Text(
                              'Realme',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('realme');
                        },
                      ),

                    ], //End Categories
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Tous les produits : ',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                  ),
                ),
              ),
              //Start Latest Products

              Column(
                children: [

                  SizedBox(
                    height: 400,
                    child: GridView(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1),
                      children: const[/*
                        FutureBuilder(
                          future: getPhone(),
                          builder: (BuildContext context, AsyncSnapshot snapshot ) {
                            if(snapshot.hasData){
                              return ListView.builder(
                                shrinkWrap: true,

                                itemCount: snapshot.data.length, itemBuilder: (context, i) {

                                return phone(snapshot.data[i]['battery'], snapshot.data[i]['camera_depth'], snapshot.data[i]['camera_feature'], snapshot.data[i]['camera_main'], snapshot.data[i]['camera_micro'], snapshot.data[i]['camera_self'], snapshot.data[i]['camera_self_feature'], snapshot.data[i]['camera_self_video'], snapshot.data[i]['camera_tele'], snapshot.data[i]['camera_ultra'], snapshot.data[i]['camera_video'], snapshot.data[i]['cpu'], snapshot.data[i]['gpu'], snapshot.data[i]['memory'], snapshot.data[i]['name'], snapshot.data[i]['num_core'], snapshot.data[i]['price_alg'], snapshot.data[i]['price_eg'], snapshot.data[i]['price_jo'], snapshot.data[i]['price_sa'], snapshot.data[i]['price_sy'], snapshot.data[i]['price_uae'], snapshot.data[i]['ram'], snapshot.data[i]['screen'], snapshot.data[i]['screen_protect'], snapshot.data[i]['screen_res'], snapshot.data[i]['system'], snapshot.data[i]['image'], snapshot.data[i]['namep'], snapshot.data[i]['mob_id']);

                              },);}
                            return const Center(child:CircularProgressIndicator(),);
                          },
                        ),

*/



                      ],
                    ),
                  )

                ],
              ),
              //End
            ],
          ),
        ),
      ),
    );
  }
}


class DataSearch extends SearchDelegate<String>{

  List<dynamic> list ;
  DataSearch({required this.list});
  Future getsearchData() async {
    var url = Uri.parse(urlBase + 'searchmob.php');
    var data = {"searchmobile" : query};
    var response = await http.post(url,body: data);
    var respnsebody = jsonDecode(response.body);
    return respnsebody;

  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(onPressed: (){
        query = "";
      }, icon: const Icon(Icons.clear),)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: (){
      close(context, "");
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return  FutureBuilder(
      future: getsearchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 5.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 55,
                              width: 55,
                              child: CircleAvatar(
                                radius: null,
                                child: ClipRRect(child: Image.network(urlBaseImg+snapshot.data[i]['img'],
                                  height: 76,
                                  width: 76,
                                  fit: BoxFit.cover,
                                ),
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data[i]['username'] +' ' + snapshot.data[i]['lastname'],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10,),
                                Text('  '+
                                    snapshot.data[i]['cat_name'].toString(),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                return ProfilePage(cat_name_D: snapshot.data[i]['cat_name'],id_D: snapshot.data[i]['id'].toString(), des_D: snapshot.data[i]['des'], id_cat_D: snapshot.data[i]['id_cat'].toString(), img_D: snapshot.data[i]['img'], password_D: snapshot.data[i]['password'], tel_D: snapshot.data[i]['tel'].toString(), lastname_D: snapshot.data[i]['lastname'], username_D: snapshot.data[i]['username']);

                              }));
                            },
                            color: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Text(
                              "Invite",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    var searchlis= query.isEmpty ? list : list.where((p) => p.startsWith(query)).toList();
    return ListView.builder(itemCount:searchlis.length,itemBuilder: (context, i){
      return ListTile(leading: const Icon(Icons.mobile_screen_share),title: Text(searchlis[i]),
        onTap: (){
          query = searchlis[i];
          showResults(context);
        },);

    });
  }

}

class phone extends StatelessWidget {
  final id;
  final name;
  final screen;
  final screen_protect;
  final screen_res;
  final system;
  final cpu;
  final num_core;
  final gpu;
  final memory;
  final ram;
  final battery;
  final camera_main;
  final camera_feature;
  final camera_video;
  final camera_ultra;
  final camera_tele;
  final camera_depth;
  final camera_micro;
  final camera_self;
  final camera_self_feature;
  final camera_self_video;
  final price_eg;
  final price_sa;
  final price_uae;
  final price_jo;
  final price_sy;
  final price_alg;
  final img;
  final namep;
  phone(this.battery, this.camera_depth, this.camera_feature, this.camera_main, this.camera_micro, this.camera_self, this.camera_self_feature, this.camera_self_video, this.camera_tele, this.camera_ultra, this.camera_video, this.cpu, this.gpu, this.memory, this.name, this.num_core, this.price_alg, this.price_eg, this.price_jo, this.price_sa, this.price_sy, this.price_uae, this.ram, this.screen, this.screen_protect, this.screen_res, this.system, this.img, this.namep, this.id);



  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(height: 270,
        child: GridTile(
          child: Image.network("http://172.20.10.4/img/$img",
            fit: BoxFit.contain,
          ),
          footer: Container(margin: const EdgeInsets.only(bottom: 10),
            height: 40,
            color: Colors.black.withOpacity(0.5),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  name ,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600,fontSize: 20),
                ),Text(
                  price_eg ,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w500, fontSize: 22),
                ),
              ],
            ),
          ),

        ),
      ),
      onTap: () {
        //Navigator.of(context).push(MaterialPageRoute(builder: (context){
          //return MobDetails(name_D: name,battery_D: battery,camera_depth_D: camera_depth,camera_feature_D: camera_feature,camera_main_D: camera_main,camera_micro_D: camera_micro,camera_self_D: camera_self,camera_self_feature_D: camera_self_feature,camera_self_video_D: camera_self_video,camera_tele_D: camera_tele,camera_ultra_D: camera_ultra,camera_video_D: camera_video,cpu_D: cpu,gpu_D: gpu,memory_D: memory, num_core_D: num_core,price_alg_D: price_alg,price_eg_D: price_eg,price_jo_D: price_jo,price_sa_D: price_sa,price_sy_D: price_sy,price_uae_D: price_uae,ram_D: ram,screen_D: screen,screen_protect_D: screen_protect,screen_res_D: screen_res,system_D: system,img: img,namep: namep,id_D: id,);
        //}));
      },
    );
  }
}










/*

            FutureBuilder(
              future: getPhone(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                List<dynamic> snap = listphone;
                List<dynamic> sna = listphon;
                List<dynamic> sn = listpho;

                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(snapshot.hasError){
                  return Center(
                    child: Text('error fatch'),
                  );
                }
                for(int i=0; i<listphone.length; i++ )
                return Container(height: 500,
                  child: ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context, index){
                        return SizedBox(

                          height: 500,
                          child: GridView(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                            children: [
                              InkWell(
                                child: GridTile(
                                  child: Image.network("http://172.20.10.4/img/${sna[i]}",
                                    fit: BoxFit.contain,
                                  ),
                                  footer: Container(
                                    height: 20,
                                    color: Colors.black.withOpacity(0.5),
                                    child: Row(
                                      children: [
                                        Text(
                                          listphone[i] ,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white, fontWeight: FontWeight.w700),
                                        ),Text(
                                          "   " ,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white, fontWeight: FontWeight.w700),
                                        ),Text(
                                          sn[i] ,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white, fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () => {
                                  debugPrint("P30 Pro")
                                },
                              ),




                            ],
                          ),
                        );
                      }
                  ),
                );
              },

            )





showDialog(context: context, builder: (context){
                return AlertDialog(title: Text("search"),content: Container(height: 100,child: Column(children: [
                  Text("Entre le nom du phone qui tu recherche"),
                  TextFormField(decoration: InputDecoration(
                    hintText: "écrire ici",
                  ),),
                ],),),actions: [
                      FlatButton(onPressed: (){}, child: Text("Ok")),
                      FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Anuller")),
                ],);
              });
*/
