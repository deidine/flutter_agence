import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../client/table.dart';
class SplashScreen extends StatefulWidget {
  @override
 _SplashScreenState createState()=> _SplashScreenState(); 
}
class _SplashScreenState extends State<SplashScreen>{
  @override
void dispose() {
  super.dispose();
}
 Future foo() async{
   var future = Future.delayed(const Duration(seconds: 1), () async {
  //              Navigator.push(context,MaterialPageRoute(builder: (BuildContext contex) =>Table2()));
dispose();
  });
}
 @override
  void initState() {
    super.initState();

  }
 @override
  // ignore: use_function_type_syntax_for_parameters
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/bus.png', width: 120,),
          SizedBox(height: 10,),
 IconButton(onPressed: (){
  // setState(() {
  //   foo(context);
  //  });
foo();
 }, icon: Icon(Icons.back_hand))
 

        ],
      ),
    );
  }
}
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const SpinKitFadingCircle(
        color: Colors.black,
        size: 30,
      )
    );
  }
}