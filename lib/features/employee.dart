import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manajemen_karyawan/assets/colors.dart';
import 'package:manajemen_karyawan/features/employee_add.dart';
import 'package:provider/provider.dart';

import '../models/employee_model.dart';
import '../providers/employee_provider.dart';
import 'employee_edit.dart';


class Employee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.simpleCurrency();

    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Management"),
        backgroundColor: ColorPrimary,
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<EmployeeProvider>(context, listen: false).getEmployee(),
        color: Colors.red,
        child: Container(
          margin: EdgeInsets.all(10),
          child: FutureBuilder(
            future: Provider.of<EmployeeProvider>(context, listen: false).getEmployee(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Consumer<EmployeeProvider>(
                builder: (context, data, _) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: data.dataEmployee.length,
                    itemBuilder: (_, i) => InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                EmployeeEdit(id: data.dataEmployee[i].id)));
                      },
                      child: Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          confirmDismiss:
                              (DismissDirection direction) async {
                            final bool res = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Konfirmasi ?"),
                                    content: Text("Apa kamu yakin ?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: Text("Hapus"),
                                      ),
                                      FlatButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: Text("Batal"),
                                      ),
                                    ],
                                  );
                                });
                            return res;
                          },
                          onDismissed: (value) {
                            Provider.of<EmployeeProvider>(context, listen: false).deleteEmployee(data.dataEmployee[i].id);
                          },
                          child: Card(
                            margin: EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Image.asset("assets/images/ic_man.png", width: 50,),
                                  SizedBox(height: 5,),
                                  GenerateText("Nama", data.dataEmployee[i].employeeName),
                                  GenerateText("Umur", "${data.dataEmployee[i].employeeAge}"),
                                  GenerateText("Gaji", "\Rp.${data.dataEmployee[i].employeeSalary}"),
                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPrimary,
        child: Text("+"),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EmployeeAdd()));
        },
      ),
    );
  }
}

class GenerateText extends StatelessWidget {
  String title;
  String value;
  GenerateText(this.title, this.value){

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 40,
            child: Text(title)
        ),
        Text(" : "),
        Text(value),
      ],
    );
  }
}

