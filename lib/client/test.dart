import 'package:bs_flutter/bs_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
        
 final BsSelectBoxController select1 = BsSelectBoxController(
     options: [
       const BsSelectBoxOption(value: 1, text: Text('nktt')),
      const BsSelectBoxOption(value: 2, text: Text('atar')),
      const BsSelectBoxOption(value: 3, text:  Text('ndb')),
    ]
  );
 String dropdownvalue = 'Direction ';

// List of items in our dropdown menu
final items = [
  'Direction ',
    'Atar أطار',
    'Noukchott أنواكشوط',
    'Noudibou أنواذيبوا',
    'Akjoujat أكجوجت',
    'Zoirate أزويرات',
  ];

  List? _myActivities;
  late String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
  }
var  _date =DateFormat("yyyy-MM-dd").format(DateTime.now());
void _showpick(){
  showDatePicker(

    context:context,
    initialDate:DateTime.now(),
firstDate:DateTime(2000),
lastDate:DateTime(2025)).then((value){
    setState((){
_date=value! as String;
    });
});
}
  

  _saveForm() {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      debugPrint(dropdownvalue);
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MultiSelect Formfield Example'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(_date.toString()),
              Container(
                padding: EdgeInsets.all(16),
                child: MultiSelectFormField(
                  autovalidate: AutovalidateMode.disabled,
                  chipBackGroundColor: Colors.blue,
                  chipLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Colors.blue,
                  checkBoxCheckColor: Colors.white,
                  dialogShapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  title: Text(
                    "My workouts",
                    style: TextStyle(fontSize: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Please select one or more options';
                    }
                    return null;
                  },
                  dataSource: [
                    {
                      "display": "Running",
                      "value": "Running",
                    },
                    {
                      "display": "Climbing",
                      "value": "Climbing",
                    },
                    {
                      "display": "Walking",
                      "value": "Walking",
                    },
                    {
                      "display": "Swimming",
                      "value": "Swimming",
                    },
                    {
                      "display": "Soccer Practice",
                      "value": "Soccer Practice",
                    },
                    {
                      "display": "Baseball Practice",
                      "value": "Baseball Practice",
                    },
                    {
                      "display": "Football Practice",
                      "value": "Football Practice",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  hintWidget: Text('Please choose one or more'),
                  initialValue: _myActivities,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities = value;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  child: Text('Save'),
                  onPressed: _saveForm,

                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(_myActivitiesResult),
              )
            ,ElevatedButton(onPressed:(){ _showpick();}, child: const Text('date'))
            ,
               DropdownButton(

              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },),
              
                   BsSelectBox(
    hintText: 'direction', validators: [
                      BsSelectValidators.required
                    ],
    controller: select1, 
                          ),
	   
               
              ],
          ),
        ),
      ),
    );
  }
}