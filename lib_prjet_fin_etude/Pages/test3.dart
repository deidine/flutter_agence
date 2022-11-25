import 'package:awn_stage2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Pages1/alertDialoge.dart';

class App3 extends StatefulWidget {
  const App3({Key? key}) : super(key: key);

  @override
  State<App3> createState() => _App3State();
}

class _App3State extends State<App3> with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this, initialIndex: 0);

  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.white
      )
    );
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: controller,
          labelColor: kPrimaryColor,
          unselectedLabelColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.description),),
            Tab(icon: Icon(Icons.add_alert),),
            Tab(icon: Icon(Icons.home),),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: const [
          AlertDialig1(),
          AlertDialig2(),
          AlertDialig2(),
        ],
      ),
    );
  }
}
