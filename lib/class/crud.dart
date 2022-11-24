import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:deidine/main.dart';

class AddEditPage extends StatefulWidget {
  final List? list;
  final int? index;
  AddEditPage({this.list,this.index});
  @override
  _AddEditPageState createState() => _AddEditPageState();
}
''
class _AddEditPageState extends State<AddEditPage> {

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController adress = TextEditingController();

  bool editMode = false;


  addUpdateData(){
    if(editMode){
      var url = 'http://192.168.19.71/flutter/edit.php';
      http.post(url,body: {
        'id' : widget.list![widget.index!]['id'],
        'fistname' : firstName.text,
        'lastname' : lastName.text,
        'phone' : phone.text,
        'adress' : adress.text,
      });
    }else{
      var url = 'http://192.168.19.71/flutter/add.php';
      http.post(url,body: {
        'fistname' : firstName.text,
        'lastname' : lastName.text,
        'phone' : phone.text,
        'adress' : adress.text,
      });
    }

  }


  @override
  void initState() {
    super.initState();
    if(widget.index != null){
      editMode = true;
      firstName.text = widget.list![widget.index!]['fistname'];
      lastName.text = widget.list![widget.index!]['lastname'];
      phone.text = widget.list![widget.index!]['phone'];
      adress.text = widget.list![widget.index!]['adress'];
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(editMode ? 'Update' :'Add Data'),),
      body: ListView(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: firstName,
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: lastName,
              decoration: InputDecoration(
                labelText: 'Last Name',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: phone,
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: adress,
              decoration: InputDecoration(
                labelText: 'Adress',
              ),
            ),
          ),

          Padding(padding: EdgeInsets.all(8),
            child: RaisedButton(
              onPressed: (){
                setState(() {
                  addUpdateData();
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(),),);
                debugPrint('Clicked RaisedButton Button');
              },
              color: Colors.blue,
              child: Text(editMode ? 'Update' :'Save',style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  Future getData()async{
    var url = 'http://192.168.19.71/flutter/read.php';
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Php Mysql deidiene'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
                  setState(() {});
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditPage(),),);
          debugPrint('Clicked FloatingActionButton Button');
        },
      ),
      body: FutureBuilder<dynamic>(
        future: getData(),
        builder: (context,snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,index){
                List list = snapshot.data;
                return ListTile(
                  leading: GestureDetector(child: Icon(Icons.edit),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditPage(list: list,index: index,),),);
                    debugPrint('Edit Clicked');
                  },),
                  title: Text(list[index]['lastname']),
                  subtitle: Text(list[index]['phone']),
                  trailing: GestureDetector(child: Icon(Icons.delete),
                    onTap: (){
                      setState(() {
                        var url = 'http://192.168.19.71/flutter/delete.php';
                        http.post(url,body: {
                          'id' : list[index]['id'],
                        });
                      });
                      debugPrint('delete Clicked');
                    },),
                );
              }
          )
              : CircularProgressIndicator();
        },
      ),
    );
  }
}
