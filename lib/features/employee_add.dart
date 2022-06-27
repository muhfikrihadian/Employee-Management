import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manajemen_karyawan/assets/colors.dart';
import 'package:manajemen_karyawan/features/employee.dart';
import 'package:manajemen_karyawan/providers/employee_provider.dart';
import 'package:provider/provider.dart';

class EmployeeAdd extends StatefulWidget {
  @override
  _EmployeeAddState createState() => _EmployeeAddState();
}

class _EmployeeAddState extends State<EmployeeAdd> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _salary = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final snackbarKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  FocusNode salaryNode = FocusNode();
  FocusNode ageNode = FocusNode();

  void submit(BuildContext context) {
    if (!_isLoading) {
      // snackbarKey.currentState.showSnackBar(snackbar);
      // setState(() {
      //   _isLoading = true;
      // });
      Provider.of<EmployeeProvider>(context, listen: false)
          .storeEmployee(_name.text, _salary.text, _age.text)
          .then((res) {
        if (res) {
          var snackbar = SnackBar(
            content: Text("Successfully Added Employees !"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Employee()),
              (route) => false);
        } else {
          var snackbar = SnackBar(
            content: Text("Ooppss... Something went wrong"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackbarKey,
      appBar: AppBar(
        title: Text("Add Employee"),
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
