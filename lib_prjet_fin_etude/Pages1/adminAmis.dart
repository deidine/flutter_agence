// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/request.dart';

class AdminClient extends StatefulWidget {
  const AdminClient({Key? key}) : super(key: key);

  @override
  State<AdminClient> createState() => _AdminClientState();
}

class _AdminClientState extends State<AdminClient> {
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

  Future getClient() async {
    var data = {"id_f": id};
    var response = await http
        .post(Uri.parse(urlBase+'getClient.php'), body: data);
    var respnsebody = jsonDecode(response.body);
    return respnsebody;

  }
  @override
  void initState() {
    getPref();
    //getClient();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lists Client', style: TextStyle(
          color: Colors.black,
          fontSize: 22,
        ),
        ),
        backgroundColor: Colors.grey.shade200,
        elevation: 0.1,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getClient(),
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
                      child: InkWell(
                              onTap: () {
                                setState(() {
                                  showAlert(context, snapshot.data[i]['tel'].toString());
                                });
                              },
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
                                        snapshot.data[i]['tel'].toString(),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                                  margin: const EdgeInsets.only(top: 8.0),
                                  child: const Icon(Icons.phone,size: 27,
                                  ),
                                ),
                                Container(margin: EdgeInsets.only(left: 10),
                                    child: const Icon(Icons.arrow_forward_ios)
                                )

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
    );
  }
}




showAlert(BuildContext context, String phoneNumber) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 8.0,
        contentPadding: const EdgeInsets.all(18.0),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => launch('tel:' + phoneNumber),
                child: Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  child: const Text('Call'),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () => launch('sms:' + phoneNumber),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: const Text('Message'),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () => launch('https://wa.me/' + phoneNumber),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: const Text('WhatsApp'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}