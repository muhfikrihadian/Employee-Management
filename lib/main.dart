import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manajemen_karyawan/assets/colors.dart';
import 'package:provider/provider.dart';

import 'providers/employee_provider.dart';
import 'features/employee.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EmployeeProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Employee(),
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSecondWhite,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorWhite),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          // Image border
                          child: SizedBox.fromSize(
                            // size: Size.fromRadius(40), // Image radius
                            child: Image.network(
                                "https://awsimages.detik.net.id/community/media/visual/2022/01/12/ardhito-pramono-10_169.jpeg?w=1200",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "MuhFikriHadian",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Fullstack Developer",
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  color: ColorGrey),
                            ),
                          ],
                        ),
                        SizedBox(width: 50,),
                        SvgPicture.asset("assets/images/ic_setting.svg",
                            semanticsLabel: 'Setting')
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Image border
                  child: SizedBox.fromSize(
                    // size: Size.fromRadius(40), // Image radius
                    child: Image.asset("assets/images/img_banner1.jpg",
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Menu",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorGrey),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Features(1, "assets/images/ic_team.png", "Employees"),
                    Features(2, "assets/images/ic_calendar.png", "Attendance"),
                    Features(
                        3, "assets/images/ic_paid_leave.png", "Paid Leave"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Features extends StatelessWidget {
  int id;
  String image;
  String title;

  Features(this.id, this.image, this.title) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (id == 1) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Employee()));
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: ColorWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Image.asset(
                image,
                width: 50,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 5,
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
