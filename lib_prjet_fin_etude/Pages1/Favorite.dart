import 'dart:math';

import 'package:awn_stage2/Pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../domain/request.dart';
import 'Modifier_MyProfile.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<dynamic> listsearch =[] ;


  Future getPhone() async {
    final data = {"user_id": id};
    final response =
    await http.post(Uri.parse(urlBase + 'indChek.php'), body: data);
    var respnsebody = jsonDecode(response.body);
    return respnsebody;
  }

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
  Future deleteFavorite({required String Uid, required String Aid}) async{

      var data = {"user_id": Uid, "admin_id": Aid};
      var response = await http
          .post(Uri.parse(urlBase+'delete.php'), body: data);
  }

  @override
  void initState() {

    getPref();
    super.initState();
  }

  double value = 0;
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 3;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade400,
                    Colors.blue.shade800,
                    kPrimaryColor,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )),
          ),
          SafeArea(
              child: Container(
                width: 200.0,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (img == null)
                      const Icon(
                        Icons.person,
                        size: 32,
                        color: Colors.amber,
                      )
                    else
                      CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(urlBaseImg + img)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (username == null)
                      const SizedBox()
                    else
                      Text(
                        username + ' ' + lastname,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                        ),
                      ),
                    Container(
                      color: kPrimaryColor,
                      height: 3,
                      width: MediaQuery.of(context).size.width / 8,
                      padding: const EdgeInsets.only(top: 18, bottom: 10),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      tel.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                      ),
                    ),
                    const SizedBox(
                      height: 130,
                    ),
                    Expanded(
                        child: ListView(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.of(context).pushNamed('HomeScreen');
                              },
                              leading: const Icon(
                                Icons.home_outlined,
                                color: Colors.white,
                                size: 31,
                              ),
                              title: const Text(
                                'Home',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).pushNamed('MyProfilePage');
                              },
                              leading: const Icon(
                                Icons.person_outline,
                                color: Colors.white,
                                size: 31,
                              ),
                              title: const Text(
                                'Profile',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return Modifier(lastname: lastname, id: id, fistname: username, phone: tel, pawd: pawd,);

                                }));
                              },
                              leading: const Icon(
                                Icons.settings_applications,
                                color: Colors.white,
                                size: 31,
                              ),
                              title: const Text(
                                'Settings',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ListTile(
                              onTap: () async {
                                SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                                preferences.clear();
                                Navigator.of(context).pushNamed("LoginPage");
                              },
                              leading: const Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: 31,
                              ),
                              title: const Text(
                                'Log out',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              )),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInExpo,
              builder: (_, double val, __) {
                return (Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(0, 3, 200 * val)
                      ..rotateY((pi / 6) * val),
                    child: Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: true,
                        title: const Text('Favorites',style: TextStyle(fontSize: 21, color: Colors.white),),
                        centerTitle: true,
                        elevation: 2,
                        backgroundColor: kPrimaryColor,

                        primary: true,

                      ),
                      drawer: FlatButton(
                        child: value == 1 ? const SizedBox() : Icon(
                          Icons.arrow_forward_outlined,
                          size: 30, color: Colors.blue.shade800,
                        ),
                        onPressed: () {
                          setState(() {
                            value = 1;
                          });
                        },
                      ),
                      body: FutureBuilder(
                        future: getPhone(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                      return ProfilePage(isFavorite: true,cat_name_D: snapshot.data[i]['cat_name'],id_D: snapshot.data[i]['id'].toString(), des_D: snapshot.data[i]['des'], id_cat_D: snapshot.data[i]['id_cat'].toString(), img_D: snapshot.data[i]['img'], password_D: snapshot.data[i]['password'], tel_D: snapshot.data[i]['tel'].toString(), lastname_D: snapshot.data[i]['lastname'], username_D: snapshot.data[i]['username']);
                                    }));
                                  },
                                  child: Container(
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
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: kPrimaryColor.withOpacity(0.3),
                                                          borderRadius: BorderRadius.circular(100)
                                                      ),
                                                      alignment: Alignment.center,
                                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                                                      margin: const EdgeInsets.only(top: 8.0),
                                                      child: const Icon(Icons.phone,size: 27,

                                                      ),
                                                    ),
                                                    Container(
                                                        margin: const EdgeInsets.symmetric(horizontal: 10),
                                                        child: const Icon(Icons.arrow_forward_ios)
                                                    ),

                                                  ],
                                                ),
                                                /*
                                                Container(padding: EdgeInsets.zero,
                                                  margin: EdgeInsets.zero,
                                                  child: InkWell(
                                                    child:  isSavedId ? const Icon(Icons.favorite,color: kPrimaryColor,) :
                                                    const Icon(Icons.favorite_border,color: kPrimaryColor,),
                                                    onTap: (){
                                                      setState(()  {
                                                        getPref();
                                                        deleteFavorite(Aid: snapshot.data[i]['id'].toString(), Uid: id.toString());
                                                        getFavorite();
                                                        // print(id);
                                                      });
                                                    },
                                                  ),
                                                ),

                                                 */
                                              ],
                                            )
                                          ],
                                        ),
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
                      ),
                      bottomNavigationBar: BottomNavyBar(
                        selectedIndex: _selectedIndex,
                        itemCornerRadius: 8,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        showElevation: true, // use this to remove appBar's elevation
                        onItemSelected: (index) => setState(() {
                          _selectedIndex = index;
                          if(index == 0) {
                            Navigator.of(context).pushNamed('HomeScreen');
                          }else if(index == 2) {
                            Navigator.of(context).pushNamed('Categories');
                          }else if(index == 1) {
                            Navigator.of(context).pushNamed('listUser');
                          }

                        }),


                        items: [
                          BottomNavyBarItem(
                            icon: const Icon(Icons.apps),
                            title: const Text('Home'),
                            activeColor: kPrimaryColor,
                          ),
                          BottomNavyBarItem(
                            icon: const Icon(Icons.people),
                            title: const Text('Users'),
                            activeColor: kPrimaryColor,
                          ),
                          BottomNavyBarItem(
                            icon: const Icon(Icons.add_alert),
                            title: const Text('Notifications'),
                            activeColor: kPrimaryColor,
                          ),
                          BottomNavyBarItem(
                            icon: const Icon(Icons.favorite),
                            title: const Text('Favorites'),
                            activeColor: kPrimaryColor, inactiveColor: null,
                          )
                        ],

                      ),
                      //bottomNavigationBar: MyBottomNavBar(),
                    )));
              }),
          GestureDetector(
            onHorizontalDragUpdate: (e) {
              setState(() {
                if (e.delta.dx > 0) {
                  value = 1;
                } else {
                  value = 0;
                }
              });
            },
          )
        ],
      ),
    );
  }
}


class BottomNavyBar extends StatelessWidget {
  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;

  BottomNavyBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
  }) {
    assert(items.length >= 2 && items.length <= 5);
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Container(
        decoration: BoxDecoration(color: bgColor, boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            )
        ]),
        child: SafeArea(
            child: Container(
                width: double.infinity,
                height: 56,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: Row(
                  mainAxisAlignment: mainAxisAlignment,
                  children: items.map((item) {
                    var index = items.indexOf(item);
                    return GestureDetector(
                        onTap: () => onItemSelected(index),
                        child: _ItemWidget(
                          item: item,
                          iconSize: iconSize,
                          isSelected: index == selectedIndex,
                          backgroundColor: bgColor,
                          itemCornerRadius: itemCornerRadius,
                          animationDuration: animationDuration,
                        ));
                  }).toList(),
                ))));
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color? backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;

  const _ItemWidget(
      {Key? key,
        required this.item,
        required this.isSelected,
        this.backgroundColor,
        required this.animationDuration,
        required this.itemCornerRadius,
        required this.iconSize})
      : assert(backgroundColor != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        width: isSelected ? 130 : 50,
        height: double.maxFinite,
        duration: animationDuration,
        padding: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          color:
          isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius),
        ),
        child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconTheme(
                        data: IconThemeData(
                            size: iconSize,
                            color: isSelected
                                ? item.activeColor.withOpacity(1)
                                : item.inactiveColor ?? item.activeColor),
                        child: item.icon,
                      ),
                    ),
                    isSelected
                        ? DefaultTextStyle.merge(
                      style: TextStyle(
                        color: item.activeColor,
                        fontWeight: FontWeight.bold,
                      ),
                      child: item.title,
                    )
                        : const SizedBox.shrink()
                  ])
            ]));
  }
}

class BottomNavyBarItem {
  final Icon icon;
  final Text title;
  final Color activeColor;
  final Color? inactiveColor;

  BottomNavyBarItem({
    required this.icon,
    required this.title,
    this.activeColor = Colors.blue,
    this.inactiveColor,
  }) {
  }
}







