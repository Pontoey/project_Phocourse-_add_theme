import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniproject/model/TakecouseModel.dart';
import 'color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'model/mycoursemodel.dart';
import 'start_course.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCourse extends StatefulWidget {
  // final List list;
  // final int index;

  final String? courseid;
  final String? courseName;
  final String? courseDescription;
  final String? courseImg;
  final String? Userid;
  //final String asd;

  HomeCourse({
    super.key,
    required this.courseid,
    required this.courseName,
    required this.courseDescription,
    required this.courseImg,
    required this.Userid,
    //required this.asd
  });

  @override
  State<HomeCourse> createState() => _HomeCourseState();
}

class _HomeCourseState extends State<HomeCourse> {
  
  Future addCourse() async {
    var url1 = Uri.parse('http://10.0.2.2/photo/addCourseRecommend.php');
    var response1 = await http.post(url1, body: {
      'userid': widget.Userid,
      'courseID': widget.courseid,
    });
    var addCourse = jsonDecode(response1.body);
    if (addCourse == 'success') {
      print('success');
    } else {
      print('fail');
    }
  }

  List<ModelcourseVDO> modelVdolist = [];
  Future getcoursvdo() async {
    var url1 = Uri.parse('http://10.0.2.2/photo/vdo_course.php');
    var response1 = await http.post(url1, body: {
      'course_id': widget.courseid,
    });
    var data1 = jsonDecode(response1.body);
    //print(data1);
    for (var i = 0; i < data1.length; i++) {
      ModelcourseVDO vdoList = ModelcourseVDO(
        vdoname: data1[i]['Vdo_name'],
        url: data1[i]['Vdo_url'],
        course_name: data1[i]['course_name'],
        course_description: data1[i]['course_description'],
        course_img: data1[i]['course_img'],
        TypeID: data1[i]['TypeID'],
        Vdo_id: data1[i]['Vdo_id'],
      );

      this.modelVdolist.add(vdoList);
    }
    //print(data1);
    return modelVdolist;
  }

  @override
  void initState() {
    super.initState();
    //getcoursvdo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: 10,
            ),
            Text(
              widget.courseName!,
              style:
                  GoogleFonts.kanit(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ]),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                child: Image.asset(
                  'img/${widget.courseImg}',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 350,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => {
                      addCourse(),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StartCourse(
                                  courseid: widget.courseid,
                                  courseName: widget.courseName,
                                  courseDescription: widget.courseDescription,
                                  courseImg: widget.courseImg,
                                  VDO: modelVdolist,
                                )),
                      ),
                      //lrk()
                    },
                    child: Text(
                      'Start Course',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colortheme1.dark_blue(),
                      onPrimary: Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.courseName}',
                        style: GoogleFonts.kanit(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 550,
                        child: Text(
                          '${widget.courseDescription}',
                          style: GoogleFonts.kanit(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Text(
                        'About this course',
                        style: GoogleFonts.kanit(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: getcoursvdo(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text('Loading...'),
                      ),
                    );
                  } else {
                    return SizedBox(
                      //height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
                              child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 550,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Lesson${index + 1} :',
                                                      style: GoogleFonts.kanit(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Container(
                                                      width: 286,
                                                      child: Text(
                                                        snapshot
                                                            .data[index].vdoname
                                                            .toString(),
                                                        style: GoogleFonts.kanit(
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                          }),
                    );
                  }
                },
              )
            ],
          ),
        ));
  }
}
