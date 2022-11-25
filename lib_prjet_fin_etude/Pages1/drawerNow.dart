import 'dart:math';

import 'package:awn_stage2/Pages1/home.dart';
import 'package:awn_stage2/constants.dart';
import 'package:flutter/material.dart';

import '../myDrawer.dart';
import 'body.dart';

class NowDrawer extends StatefulWidget {
  const NowDrawer({Key? key}) : super(key: key);

  @override
  State<NowDrawer> createState() => _NowDrawerState();
}

class _NowDrawerState extends State<NowDrawer> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
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
                const CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('images/IMG.JPG'),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Cheikh Sidi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView(
                  children: [
                    ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Home',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Settings',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.white,
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
                            backgroundColor: kPrimaryColor, elevation: 0),
                        drawer: FlatButton(
                          child: value == 1 ? SizedBox() : Icon(
                            Icons.arrow_forward_outlined,
                            size: 30, color: Colors.blue.shade800,
                          ),
                          onPressed: () {
                            setState(() {
                              value = 1;
                            });
                          },
                        ),
                        body: const Body(),
                        bottomNavigationBar: BottomNavyBar(
                          selectedIndex: _selectedIndex,
                          itemCornerRadius: 8,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          showElevation:
                              true, // use this to remove appBar's elevation
                          onItemSelected: (index) => setState(() {
                            _selectedIndex = index;
                            if (index == 1) {
                              Navigator.of(context).pushNamed('listUser');
                            } else if (index == 2) {
                              Navigator.of(context).pushNamed('MyApp3');
                            } else if (index == 3) {
                              Navigator.of(context).pushNamed('NowDrawer');
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
                              activeColor: Colors.purpleAccent,
                            ),
                            BottomNavyBarItem(
                              icon: const Icon(Icons.message),
                              title: const Text('Messages'),
                              activeColor: Colors.pink,
                            ),
                            BottomNavyBarItem(
                              icon: const Icon(Icons.settings),
                              title: const Text('Settings'),
                              activeColor: Colors.blue,
                              inactiveColor: null,
                            )
                          ],
                        )
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
