import 'package:deidine/class/data.dart';
import 'package:deidine/widgets/cus_btn.dart';
import 'package:deidine/widgets/cus_text.dart';
import 'package:deidine/widgets/loading.dart';
import 'package:deidine/home.dart';
import 'package:deidine/test/client.dart';
import '../const/pref.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';
import '../test/order.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({this.prefs});

  final SharedPreferences? prefs;

  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    // bool isLoggedIn = prefs?.getBool(PrefConstants.ISLOGGEDIN) ?? false;
    // if (!isLoggedIn) {
    //   return LoginPage(prefs: prefs);
    // } else {
    //   final phonenumber = prefs?.getString(PrefConstants.LOGGED_PHONE) ?? '07';
    //   final name = prefs?.getString(PrefConstants.LOGGED_NAME) ?? 'Web';

    //   void _signOut() async {
    //     try {
    //       prefs?.setBool(PrefConstants.ISLOGGEDIN, false);
    //       Navigator.of(context).pop();
    //       Navigator.push(
    //           context,
    //            MaterialPageRoute(
    //               builder: (BuildContext context) =>
    //                    LoginPage(prefs: prefs)));
    //     } catch (e) {
    //       print(e);
    //     }
    //   }

      void showAlertDialog() {
        AlertDialog alertDialog = AlertDialog(
            title: Text('Status'),
            content:
                Text('Are you sure you want to logout from Bus Booking App'),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                       FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text('Ok', textScaleFactor: 1.5),
                        onPressed: () {
                          //_signOut(); //signout
                        },
                      ),
                      Container(
                        width: 5.0,
                      ),
                       FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        color: Colors.red,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ))
            ]);

        showDialog(context: context, builder: (_) => alertDialog);
      }

      return  Drawer(
        child: ListView(
          children: <Widget>[
             UserAccountsDrawerHeader(
              accountName: Text("name"),
              accountEmail: Text("phonenumber"),
              currentAccountPicture:  CircleAvatar(
                backgroundImage:  AssetImage("images/logo.png"),
                // backgroundImage:  AssetImage(AppConstants.APP_LOGO),
              ),
            ),
             ListTile(
              leading: Icon(Icons.home),
              title:  Text('Home'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext contex) =>
                            home(prefs: prefs)));
              },
            ),
             ListTile(
              leading: Icon(Icons.fingerprint),
              title:  Text('prefume'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext contex) =>Shopping()
                            ));

                //Navigator.of(context).pushNamed(MyRoutes.VIEW_SPORTS);
              },
            ),
             ListTile(
              leading: Icon(Icons.textsms),
              title:  Text('Tickets'),
              onTap: () {
                Navigator.of(context).pop();
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Order()),);

               /* Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext contex) =>
                            ViewReceipts(prefs: prefs)));*/

                //  Navigator.of(context).pushNamed(MyRoutes.VIEW_STUDENTS);
              },
            ),
             ListTile(
              leading: Icon(Icons.developer_mode),
              title:  Text('About Developer'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
             ListTile(
              leading: Icon(Icons.all_out),
              title:  Text('time'),
              onTap: () { Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext contex) =>
                            DateTimePicker()));
                
                // showAlertDialog(); // _signOut();
              },
            ),ListTile(
              leading: Icon(Icons.card_travel),
              title:  Text('cart'),
              onTap: () {},
            ),
            CustomButton(text: "add", onTap: (){}),
            CustomText(text: "hi",)
          ],
        ),
      );
    }
  }

//  Widget CustomButton();
  
  /*
 TabBarWidget(
        title: MyApp.title,
        tabs: [
          Tab(icon: Icon(Icons.sort_by_alpha), text: 'Sortable'),
          Tab(icon: Icon(Icons.select_all), text: 'Selectable'),
          Tab(icon: Icon(Icons.edit), text: 'Editable'),
        ],
        children: [
          SortablePage(),
          Container(),
          Container(),
        ],
      );*/