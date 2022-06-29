import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manajemen_karyawan/assets/colors.dart';
import 'package:provider/provider.dart';

import 'providers/employee_provider.dart';
import 'features/employee.dart';

final List<String> imgList = [
  'assets/images/img_banner1.jpg',
  'assets/images/img_banner4.png',
  'assets/images/img_banner2.jpg',
  'assets/images/img_banner5.png',
  'assets/images/img_banner3.jpg'
];

final List<Widget> imageSliders = imgList.map((item) => Container(
  child: Container(
    height: 250,
    margin: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: ColorWhite
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20), // Image border
      child: SizedBox.fromSize(
        child: Image.asset(
          item,
          fit: BoxFit.cover,
          height: 250,
          width: 1000,
        ),
      ),
    ),
  ),
)).toList();

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
                        SizedBox(
                          width: 50,
                        ),
                        SvgPicture.asset("assets/images/ic_setting.svg",
                            semanticsLabel: 'Setting')
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ComplicatedImageDemo(),
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
                        color: ColorBlack),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Features(1, "assets/images/ic_team.png", "Employees"),
                    Features(2, "assets/images/ic_calendar.png", "Attendance"),
                    Features(
                        3, "assets/images/ic_paid_leave.png", "Paid Leave"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "News",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorBlack),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                News(),
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
      child: Card(
        margin: EdgeInsets.only(left: 5, right: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Container(
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
              Text(
                title,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;

    return FutureBuilder(
      future: Provider.of<EmployeeProvider>(context, listen: false).getNews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Consumer<EmployeeProvider>(
          builder: (context, data, _) {
            return Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 300,
                    child: ListView.builder(
                      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: data.dataNews.length,
                      itemBuilder: (_, i) => InkWell(
                        // onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmployeeEdit(id: data.dataEmployee[i].id)));},
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorWhite),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox.fromSize(
                                  child: Image.network(
                                      data.dataNews[i].urlToImage,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 200,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.dataNews[i].title,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: ColorBlack),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data.dataNews[i].source.name,
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: ColorGrey),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class ComplicatedImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: imageSliders,
    );
  }
}
