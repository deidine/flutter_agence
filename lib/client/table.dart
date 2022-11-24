//https://help.syncfusion.com/flutter/datagrid/scrolling
import 'dart:convert';
import 'package:deidine/client/edit.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../const/const.dart';
import 'index.dart';
class Table2 extends StatefulWidget {
/// Creates the home page.
    Table2({Key? key}) : super(key: key);

@override
  _Table2State createState() => _Table2State();
}

class _Table2State extends State<Table2> {
  
      EmployeeDataSource? employeeDataSource;
      List<GridColumn>? _columns;
      final DataGridController _controller = DataGridController();

Future<dynamic> generateEmployeeList() async {
      final response = await http.get('${SERVER_NAME}client/read.php');

      var list = json.decode(response.body);

      // Convert the JSON to List collection.
      List<Employee> _employees =
      await list.map<Employee>((json) => Employee.fromJson(json)).toList();
      employeeDataSource = EmployeeDataSource(_employees);
      return _employees;
}

List<GridColumn> getColumns() {
        return <GridColumn>[
                  GridColumn(
                  columnName: 'id',
                  width: 70,
                  label: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Text(
                  'ID',
                  ))),
                  GridColumn(
                  columnName: 'name',
                  width: 80,
                  label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text('Name'))),
                  GridColumn(
                  columnName: 'designation',
                  width: 120,
                  label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                  'Designation',
                  overflow: TextOverflow.ellipsis,
                  ))),
                  GridColumn(
                  columnName: 'salary',
                  label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text('Salary'))),
                  GridColumn(
                  columnName: 'suprimer',
                  label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text('suprimer'))),
                  GridColumn(
                  columnName: 'modifier',
                  label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text('modifier'))),
                  ];
}

@override
void initState() {
          super.initState();
          _columns = getColumns();
          
}

@override
Widget build(BuildContext context) {
return Scaffold(
    appBar: AppBar(
    title: Text('Syncfusion flutter datagrid'),
    ),
    body:FutureBuilder(
          future: generateEmployeeList(),
          builder: (context, data) {
          return data.hasData
                    ? SfDataGrid(     defaultColumnWidth: 150,
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    showCheckboxColumn: true,
                    // selectionMode: SelectionMode.multiple,
                    rowsCacheExtent: 20,
                    source: employeeDataSource!,
                    columns: _columns!,
                    columnWidthMode: ColumnWidthMode.fill)
          : Center(
          child: CircularProgressIndicator(
          strokeWidth: 2,
          value: 0.8,
));
}));
}
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
/// Creates the employee data source class with required details.
EmployeeDataSource(this.employees) {
buildDataGridRow();
}

void buildDataGridRow() {
          _employeeDataGridRows = employees
          .map<DataGridRow>((e) => DataGridRow(cells: [
          DataGridCell<int>(columnName: 'id', value: e.id),
          DataGridCell<String>(columnName: 'name', value: e.firstName),
          DataGridCell<String>(
          columnName: 'designation', value: e.designation),
          DataGridCell<int>(columnName: 'salary', value: e.salary),
          DataGridCell<Widget>(columnName: 'suprimer', value: null),
          DataGridCell<Widget>(columnName: 'modifier', value: null),
          ]))
          .toList();
          }

List<Employee> employees = [];

List<DataGridRow> _employeeDataGridRows = [];

@override
List<DataGridRow> get rows => _employeeDataGridRows;

@override
DataGridRowAdapter buildRow(DataGridRow row) {

return DataGridRowAdapter(cells: row.getCells().map<Widget>((e) {

if (e.columnName == 'suprimer' || e.columnName == 'modifier'){
void delete(){
            var a=row.getCells()[0].value.toString();
            var url = '${SERVER_NAME}client/delete.php';
            http.post(url,body: {'id':a});
            }
return Container(width:50,alignment: Alignment.center,padding: const EdgeInsets.all(8.0),
            child:LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                    child: e.columnName == 'modifier'?IconButton(
                    icon:Icon(Icons.edit,color: Colors.yellow),
                    onPressed: () {
                      //  debugPrint(row.getCells()[0].value.toString());
            var a=row.getCells()[0].value.toString();

                    // edit(date: '', nom: '', numero: '', prenom: '', prix: '', telephone: '');
                    
                     },)
                    : IconButton(icon:Icon(Icons.delete,color: Color.fromARGB(255, 184, 40, 40)), onPressed: () {  
                    showDialog(context: context,builder: (context) => AlertDialog(
                    title: Text('confirmer',style: TextStyle(color: Colors.red),),
                    content: Text('tu veux suprimer'),actions: <Widget>[Padding(
                    padding: EdgeInsets.all(16),child: Row(children: <Widget>[
                    ElevatedButton(child: Text("ok", textScaleFactor: 1.5),
                    onPressed: () {
                    Navigator.pop(context);
              delete();
              Navigator.push(context,MaterialPageRoute(builder: (BuildContext contex) =>Client()));},
        ), SizedBox(width: 5,),

        ElevatedButton(
        child: Text("annuller", textScaleFactor: 1.5),
        onPressed: () {
        Navigator.pop(context);},),],))]));},),);}));}
        else { return Text(e.value.toString());}

}).toList());
}

void updateDataGrid() {
    notifyListeners();
}}



class Employee {
int? id;
String? firstName;
String? designation;
int? salary;

Employee({this.id, this.firstName, this.designation, this.salary});

factory Employee.fromJson(Map<String, dynamic> json) {
            return Employee(
            id: int.parse(json['id']),
            firstName: json['nom'] as String,
            designation: json['prenom'] as String,
            salary: int.parse(json['telephone']));
}
}
