
import 'package:flutter/material.dart';

class Order extends StatefulWidget{
  @override
  State createState() => _OrderState();
}

class _OrderState extends State<Order>{
  @override
  Widget build(BuildContext context) {
return AnimatedContainer(
  duration: Duration(milliseconds: 300),
  height: 20,
  child: Card(
    margin: EdgeInsets.all(08.0),
    child: Column(children: [ListTile(
      title: Text('rr'),
      subtitle: Text("DateFormat('dd/mm/yyyy hh:mm')"),
    trailing: IconButton(onPressed: (){}, icon: Icon(Icons.cabin)),
    ),
    AnimatedContainer(
  duration: Duration(milliseconds: 300),
  height: 20,
  child: Text("ee"))
    ]),
  ),

);
  }

}


