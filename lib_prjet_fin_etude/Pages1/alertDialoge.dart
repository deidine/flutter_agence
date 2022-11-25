
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Pages/login.dart';
import '../domain/request.dart';
import 'package:flutter/cupertino.dart';
import '../constants.dart';



class AlertDialig extends StatefulWidget {
  const AlertDialig({Key? key}) : super(key: key);

  @override
  State<AlertDialig> createState() => _AlertDialigState();
}

class _AlertDialigState extends State<AlertDialig> {

  final TextEditingController _descripon = TextEditingController();
  final TextEditingController _localisation = TextEditingController();

  AddCommande() async {
    var dat = {
      "des": _descripon.text,
      "id_user": '13',
      "id_fourni": '12',
      "loc": _localisation.text
    };
    var respons = await http.post(
        Uri.parse(urlBase+'addcommade.php'),
        body: dat);
    var respnsebod = jsonDecode(respons.body);
    if (respnsebod['status'] == "success add") {
      Navigator.of(context).pop();

    }else{

      showdialogall(context, "Erreur", "Numéro de télephone existe déjà ");
    }
    //Navigator.of(context).pushNamed("home");


  }
  showAlertNew() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Dialog Title',
            textAlign: TextAlign.center,
          ),
          titleTextStyle: const TextStyle(
            fontSize: 16.0,
            color: kPrimaryColor,//Theme.of(context).textTheme.titleMedium.backgroundColor,
            fontWeight: FontWeight.w800,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),

          ),
          actions: <Widget>[
            FlatButton(color: Colors.red.shade400,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'.toUpperCase()),
            ),
            FlatButton(color: Colors.blue.shade400,
              onPressed: () {
                AddCommande();
                //Navigator.of(context).pop();
              },
              child: Text('OK'.toUpperCase()),
            ),
          ],
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: _localisation,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Localisation',
                  ),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    //FocusScope.of(context).requestFocus(_nodePassword);
                  },
                ),
                TextField(
                  controller: _descripon,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  late List<Widget> _pages;
  late int _activePage = 0 ;
  @override
  Widget build(BuildContext context) {
    _pages = [
      const AlertDialig2(),
      const AlertDialig1(),
    ];
    return Stack(
        children:  [
          Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              top: 0.0,
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      _activePage = value;
                    });
                  },
                  children: _pages,
                ),
              )
          ),
          Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: ButtonOptions(
                totalPage: _pages.length,
                activePage: _activePage,
              )
          ),
        ],
      );
  }

}


class ButtonOptions extends StatefulWidget {
  const ButtonOptions({Key? key, required this.totalPage,required this.activePage}) : super(key: key);
  final int totalPage;
  final int activePage;

  @override
  State<ButtonOptions> createState() => _ButtonOptionsState();
}

class _ButtonOptionsState extends State<ButtonOptions> {
  late int Ind =0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children:  [

          //Page View Pagination
          Container(
            child: Row(
              children: [
                Container(
                  child: TextButton(
                  child: Text('Bonj'),
                   onPressed: () {
                    Navigator.of(context).pushNamed('App3');
                    setState(() {

                      if(Ind == 0) {
                          Ind = 1;
                        }else{
                        Ind = 0;
                      }
                      });
                   },
                  ),
                ),
                Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  List.generate(widget.totalPage, (index) {
                    setState(() {
                      index = Ind;
                      print(index);
                    });
                    return AnimatedContainer(
                      duration: const Duration(microseconds: 500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: widget.activePage == index ? 12 : 7,
                      height: 5,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: widget.activePage == index ? Colors.indigo : Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 35,),
          //Page View Pagination


/*
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('loginAdminPage');
            },
            child: Container(
              height: 60,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black.withOpacity(0.05),
                      width: 2
                  ),
                  borderRadius: BorderRadius.circular(35)
              ),
              child: Row(
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle
                      ),
                      child: const Icon(Icons.login,
                        color: Colors.white,
                      )

                  ),
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: const Text('Entre un tanque Admin',
                            style:  TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 17
                            ),
                          )
                      )
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 20,),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('LoginPage');
            },
            child: Container(
              height: 60,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(35)
              ),
              child: Row(
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                      child: const Icon(Icons.login,
                        color: Colors.blue,
                        size: 25,
                      )
                  ),
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: const Text('Entre un tanque Utilisateur',
                            style:  TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 17
                            ),
                          )
                      )
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
*/
        ],
      ),
    );
  }
}











class AlertDialig1 extends StatefulWidget {
  const AlertDialig1({Key? key}) : super(key: key);

  @override
  State<AlertDialig1> createState() => _AlertDialig1State();
}

class _AlertDialig1State extends State<AlertDialig1> {

  Future getCommande() async {
    var response = await http.get(Uri.parse(urlBase + 'getcommande.php'));
    var respnsebody = jsonDecode(response.body);
    return respnsebody;
  }
  DeleteCommand(String id) async {
    var data = {"id": id};
    var response = await http
        .post(Uri.parse(urlBase+'deletcommande.php'), body: data);
   var respnsebody = jsonDecode(response.body);
    if (respnsebody['status'] == "success delete") {
      setState(()  {
        print('true');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: FutureBuilder(
        future: getCommande(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return Stack(
                  children: [
                    Container(

                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text('Date', style: TextStyle(fontSize: 17, ),),
                                      Text('Stus', style: TextStyle(fontSize: 17, )),
                                      Text('Stutue', style: TextStyle(fontSize: 17, )),

                                    ],
                                  )),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data[i]['date_de_commande'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                      Text(snapshot.data[i]['Commande'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                      Text(snapshot.data[i]['stutus'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                    ],
                                  ),
                                ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(290, 0, 0, 0),
                        child:
                        RawMaterialButton(
                          elevation: 2,
                          padding: const EdgeInsets.all(1.0),
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                            size: 20.0,
                          ),
                          onPressed: () {
                            setState(() {
                              DeleteCommand(snapshot.data[i]['id'].toString());
                            });
                            //pickerCamera();
                          },
                        )
                    ),
                  ],
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}





class AlertDialig2 extends StatefulWidget {
  const AlertDialig2({Key? key}) : super(key: key);

  @override
  State<AlertDialig2> createState() => _AlertDialig2State();
}

class _AlertDialig2State extends State<AlertDialig2> {

  Future getCommande() async {
    var response = await http.get(Uri.parse(urlBase + 'getcommandeEnEtat.php'));
    var respnsebody = jsonDecode(response.body);
    return respnsebody;
  }


  DeleteCommand(String id) async {
    var data = {"id": id};
    var response = await http
        .post(Uri.parse(urlBase+'deletcommande.php'), body: data);
    var respnsebody = jsonDecode(response.body);
    if (respnsebody['status'] == "success delete") {
      setState(()  {
        print('true');
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: FutureBuilder(
        future: getCommande(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return Stack(
                  children: [
                    Container(

                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text('Date', style: TextStyle(fontSize: 17, ),),
                                      Text('Stus', style: TextStyle(fontSize: 17, )),
                                      Text('Stutue', style: TextStyle(fontSize: 17, )),

                                    ],
                                  )),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data[i]['date_de_commande'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                    Text(snapshot.data[i]['Commande'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                    Text(snapshot.data[i]['stutus'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(290, 0, 0, 0),
                        child:
                        RawMaterialButton(
                          elevation: 2,
                          padding: const EdgeInsets.all(1.0),
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                            size: 20.0,
                          ),
                          onPressed: () {
                            setState(() {
                              DeleteCommand(snapshot.data[i]['id'].toString());
                            });
                            //pickerCamera();
                          },
                        )
                    ),
                  ],
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}


class AlertDialig3 extends StatefulWidget {
  const AlertDialig3({Key? key}) : super(key: key);

  @override
  State<AlertDialig3> createState() => _AlertDialig3State();
}

class _AlertDialig3State extends State<AlertDialig3> {

  Future getCommande() async {
    var response = await http.get(Uri.parse(urlBase + 'getcommandeterminer.php'));
    var respnsebody = jsonDecode(response.body);
    return respnsebody;
  }
  DeleteCommand(String id) async {
    var data = {"id": id};
    var response = await http
        .post(Uri.parse(urlBase+'deletcommande.php'), body: data);
    var respnsebody = jsonDecode(response.body);
    if (respnsebody['status'] == "success delete") {
      setState(()  {
        print('true');
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: FutureBuilder(
        future: getCommande(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return Stack(
                  children: [
                    Container(

                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text('Date', style: TextStyle(fontSize: 17, ),),
                                      Text('Stutue', style: TextStyle(fontSize: 17, )),
                                      Text('Contenue', style: TextStyle(fontSize: 17, )),

                                    ],
                                  )),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data[i]['date_de_commande'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                    Text(snapshot.data[i]['stutus'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                    Text(snapshot.data[i]['Commande'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(290, 0, 0, 0),
                        child:
                        RawMaterialButton(
                          elevation: 2,
                          padding: const EdgeInsets.all(1.0),
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                            size: 20.0,
                          ),
                          onPressed: () {
                            setState(() {
                              DeleteCommand(snapshot.data[i]['id'].toString());
                            });
                            //pickerCamera();
                          },
                        )
                    ),
                  ],
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

/*

class AlertDialig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<NotificationCard> _listOfNotification = [
    NotificationCard(
      date: DateTime.now(),
      leading: const Icon(
        Icons.account_circle,
        size: 48,
      ),
      title: 'OakTree 1',
      subtitle: 'We believe in the power of mobile computing.',
    ),
    NotificationCard(
      date: DateTime.now().subtract(
        const Duration(minutes: 4),
      ),
      leading: const Icon(
        Icons.account_circle,
        size: 48,
      ),
      title: 'OakTree 2',
      subtitle: 'We believe in the power of mobile computing.',
    ),
    NotificationCard(
      date: DateTime.now().subtract(
        const Duration(minutes: 10),
      ),
      leading: const Icon(
        Icons.account_circle,
        size: 48,
      ),
      title: 'OakTree 3',
      subtitle: 'We believe in the power of mobile computing.',
    ),
    NotificationCard(
      date: DateTime.now().subtract(
        const Duration(minutes: 30),
      ),
      leading: const Icon(
        Icons.account_circle,
        size: 48,
      ),
      title: 'OakTree 4',
      subtitle: 'We believe in the power of mobile computing.',
    ),
    NotificationCard(
      date: DateTime.now().subtract(
         const Duration(minutes: 44),
      ),
      leading:  const Icon(
        Icons.account_circle,
        size: 48,
      ),
      title: 'OakTree 5',
      subtitle: 'We believe in the power of mobile computing.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Stacked Notification Card',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StackedNotificationCards(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 2.0,
                )
              ],
              notificationCardTitle: 'Message',
              notificationCards: [..._listOfNotification],
              cardColor: const Color(0xFFF1F1F1),
              padding: 16,
              actionTitle: const Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              showLessAction: const Text(
                'Show less',
                style:  TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              onTapClearAll: () {
                setState(() {

                });
              },
              clearAllNotificationsAction: const Icon(Icons.close),
              clearAllStacked: const Text('Clear All'),
              cardClearButton: const Text('clear'),
              cardViewButton: const Text('view'),
              onTapClearCallback: (index) {
                print(index);
                setState(() {
                  _listOfNotification.removeAt(index);
                });
              },
              onTapViewCallback: (index) {
                print(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}

 */