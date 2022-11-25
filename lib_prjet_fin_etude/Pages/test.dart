import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import '../domain/request.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
   File? file ;

  Future pickerCamera() async {
    final myFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      file = File(myFile!.path);
    });

  }
  Future pickerFile() async {
    final myFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      file = File(myFile!.path);
    });

  }
  TextEditingController _addpost = new TextEditingController();

  Future addPost() async {
    if(file == null) return;
    String base64 = base64Encode(file!.readAsBytesSync());
    String imagename = file!.path.split("/").last;
    var data = {
      //"post" : _addpost.text,
      //"postuser" : id,
      "imagepost" : imagename,
      "image64" : base64
    };
    var response = await http.post(Uri.parse(urlBase+'addImage.php'),body: data);
    //var respnsebody = jsonDecode(response.body);
   // Navigator.of(context).pushNamed("post");

  }
  Future upload() async {
    if(file == null) return null;
    String base64 = base64Encode(file!.readAsBytesSync());
    String imageName = file!.path.split("/").last;
    if (kDebugMode) {
      print(imageName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                child: const Text('Get Image'),
                onPressed: pickerCamera),
            Container(child: file== null ? const Text('Image not Selected') : Image.file(file!),),
            ElevatedButton(
                child: const Text('Upload Image'),

                onPressed: pickerFile),
            ElevatedButton(
                child: const Text('Upload Image'),

                onPressed: addPost),

          ],
        ),
      ),
    );
  }
}
