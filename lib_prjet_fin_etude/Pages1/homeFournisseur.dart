// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:awn_stage2/domain/request.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenFournisseur extends StatefulWidget {
  const HomeScreenFournisseur({Key? key}) : super(key: key);

  @override
  _HomeScreenFournisseurState createState() => _HomeScreenFournisseurState();
}

class _HomeScreenFournisseurState extends State<HomeScreenFournisseur> {


  var username;
  var tel;
  var lastname;
  var img;
  var id;
  var pawd;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString("username");

    if (username != null) {
      setState(() {
        username = preferences.getString("username");
        tel = preferences.getString("tel");
        img = preferences.getString("img");
        lastname = preferences.getString("lastname");
        id = preferences.getString("id");
        pawd = preferences.getString("password");
      });
    }
  }
@override
  void initState() {
    getPref();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // to get size
    var size = MediaQuery.of(context).size;

    // style
    var cardTextStyle = const TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));

    return Scaffold(
      body: Container(
        color: Colors.grey.shade300,
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height * 0.6,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/images/top_header.png')),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 133,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                           CircleAvatar(
                            radius: 52,
                            backgroundImage: NetworkImage(
                              urlBaseImg + img),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                               Text(
                                username + ' ' + lastname,
                                style: const TextStyle(
                                    fontFamily: "Montserrat Medium",
                                    color: Colors.white,
                                    fontSize: 22),
                              ),
                              Text(
                                tel,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: "Montserrat Regular"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        primary: false,
                        crossAxisCount: 2,
                        children: <Widget>[
                          Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('AdminClient');
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/4.jpg',
                                    height: 128,
                                  ),
                                  Text(
                                    'Lists Clients',
                                    style: cardTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),

                          Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('AdminCommande');
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/2.jpg',
                                    height: 128,
                                  ),
                                  Text(
                                    'Commandes',
                                    style: cardTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),

                          Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('ProfilePageAdmin');
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/8.png',
                                    height: 128,
                                    //width: 100,
                                  ),
                                  Text(
                                    'Mon Profile',
                                    style: cardTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),

                          Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('AdminCommandeAcc');
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/7.jpg',
                                    height: 128,
                                    width: 100,
                                  ),
                                  Text(
                                    'Commandes Acc',
                                    style: cardTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),

                          Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/6.png',
                                  height: 128,
                                  width: 100,
                                ),
                                Text(
                                  'Course Booking',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),

                          Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: InkWell(
                              onTap: () async {
                                SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                                preferences.clear();
                                Navigator.of(context).pushNamed("loginAdminPage");
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/5.png',
                                    height: 128,
                                    width: 100,
                                  ),
                                  Text(
                                    'Log Out',
                                    style: cardTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
