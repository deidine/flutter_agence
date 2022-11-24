import 'package:deidine/test/cart.dart';
import 'package:flutter/material.dart';

import 'cus_btn.dart';
// ignore: must_be_immutable
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Text? title;
  MyAppBar({Key? key, this.title}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {//Container(color: Colors.red);
    return AppBar(title:title,
    elevation: 0,
    centerTitle: true,
    // CustomButton(text: "click",onTap: printf("ss"),),
    actions:[IconButton(onPressed: (){
 Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext contex) =>cartitem()
                            ));


    }, icon: const Icon(Icons.home)),    ]
    );
}}
    