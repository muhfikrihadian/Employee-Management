
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manajemen_karyawan/assets/colors.dart';
import 'package:manajemen_karyawan/features/employee.dart';
import 'package:provider/provider.dart';

import '../providers/employee_provider.dart';

class EmployeeEdit extends StatefulWidget{
  final String id;
  EmployeeEdit({required this.id});

  @override
  _EmployeeEditState createState() => _EmployeeEditState();
}

class _EmployeeEditState extends State<EmployeeEdit>{
  final TextEditingController _name = TextEditingController();
  final TextEditingController _salary = TextEditingController();
  final TextEditingController _age = TextEditingController();
  bool _isLoading = false;
  final snackbarKey = GlobalKey<ScaffoldState>();
  FocusNode salaryNode = FocusNode();
  FocusNode ageNode = FocusNode();

  @override
  void initState() {
    Future.delayed(Duration.zero, (){
      Provider.of<EmployeeProvider>(context, listen: false).findEmployee(widget.id).then((response){
        _name.text = response.employeeName;
        _age.text = response.employeeAge;
        _salary.text = response.employeeSalary;
      });
    });
    super.initState();
  }

  void submit(BuildContext context){
    if(!_isLoading){
      // setState(() {
      //   _isLoading = true;
      // });

      Provider.of<EmployeeProvider>(context, listen: false).updateEmployee(widget.id, _name.text, _salary.text, _age.text).then((res){
        if(res){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Employee()), (route) => false);
        } else {
          var snackbar = SnackBar(content: Text("Error"));
          // snackbarKey.currentState.showSnackBar(snackbar);
          // ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackbarKey,
      appBar: AppBar(
        title: Text("Edit Employee"),
        backgroundColor: ColorPrimary,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Text(
              "Name",
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            Container(
              height: 50,
              child: TextField(
                style: GoogleFonts.poppins(
                  height: 1,
                ),
                controller: _name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: ColorPrimary,
                      )),
                ),
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(salaryNode);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Sallary",
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            Container(
              height: 50,
              child: TextField(
                style: GoogleFonts.poppins(
                  height: 1,
                ),
                controller: _salary,
                focusNode: salaryNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: ColorPrimary,
                      )),
                ),
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(ageNode);
                },
              ),
            ),
            Text(
              "Age",
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            Container(
              child: TextField(
                style: GoogleFonts.poppins(
                  height: 1,
                ),
                controller: _age,
                focusNode: ageNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: ColorPrimary)),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Material(
            //Wrap with Material
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            color: ColorPrimary,
            clipBehavior: Clip.antiAlias,
            // Add This
            child: MaterialButton(
              minWidth: 200.0,
              height: 50,
              color: ColorPrimary,
              child: new Text('Submit',
                  style: new TextStyle(fontSize: 16.0, color: Colors.white)),
              onPressed: () {
                submit(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}