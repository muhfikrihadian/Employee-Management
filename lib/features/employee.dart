import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    List<String> images = [
      "https://awsimages.detik.net.id/community/media/visual/2022/01/12/ardhito-pramono-10_169.jpeg?w=1200",
      "https://images.bisnis-cdn.com/posts/2021/08/02/1424719/steve-jobs1.jpg",
      "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Elon_Musk_Royal_Society.jpg/1200px-Elon_Musk_Royal_Society.jpg",
      "https://img.idxchannel.com/media/700/images/idx/2019/06/27/mark.jpg",
      "https://cdnwpedutorenews.gramedia.net/wp-content/uploads/2022/01/14112539/Bill-Gates-810x544.jpg",
      "https://1.bp.blogspot.com/-QtR0zDdjt3s/XZYrn9L5SLI/AAAAAAABJ3o/fvGKyvF290wIDU2w0J2VTouPP1DYgCkKACLcBGAsYHQ/s1600/Larry%2BPage%2Bentrepeneur%2Bcom.jpg",
      "https://img.idxchannel.com/media/700/images/idx/2022/05/23/Saham_Pilihan_Warren_Buffet.jpg",
      "https://disk.mediaindonesia.com/thumbs/1800x1200/news/2021/11/d1c2d76521812fad0db58abecb7132d4.jpg",
      "https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Tesla_circa_1890.jpeg/220px-Tesla_circa_1890.jpeg",
      "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Albert_Einstein_%28Nobel%29.png/170px-Albert_Einstein_%28Nobel%29.png",
    ];
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 4;
    final double itemWidth = size.width / 2;

    String getImage() {
      Random random = new Random();
      int randomNumber = random.nextInt(9);
      return images[randomNumber];
    }

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
            future: Provider.of<EmployeeProvider>(context, listen: false)
                .getEmployee(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Consumer<EmployeeProvider>(
                builder: (context, data, _) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: (itemWidth / itemHeight),
                        crossAxisCount: 2,
                    ),
                    itemCount: data.dataEmployee.length,
                    itemBuilder: (_, i) => InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmployeeEdit(id: data.dataEmployee[i].id)));
                      },
                      child: Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (DismissDirection direction) async {
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
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: SizedBox.fromSize(
                                      child: Image.network(getImage(),
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  GenerateText("Nama",
                                      data.dataEmployee[i].employeeName),
                                  GenerateText("Umur",
                                      "${data.dataEmployee[i].employeeAge}"),
                                  GenerateText("Gaji",
                                      "\Rp.${data.dataEmployee[i].employeeSalary}"),
                                ],
                              ),
                            ),
                          )),
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

  GenerateText(this.title, this.value) {}

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 40,
            child: Text(
              title,
              style: GoogleFonts.poppins(fontSize: 12, color: ColorBlack),
            )),
        Text(
          " : ",
          style: GoogleFonts.poppins(fontSize: 12, color: ColorBlack),
        ),
        // Text(value),
        SizedBox(
          width: 90,
          child: Text(
            value,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(fontSize: 12, color: ColorBlack),
          ),
        ),
      ],
    );
  }
}
