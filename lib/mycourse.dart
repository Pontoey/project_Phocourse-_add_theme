import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniproject/screen.dart';

import 'course.dart';

class Mycourse extends StatefulWidget {
  Mycourse({
    Key? key,
    required this.member,
    // required this.Courses,
  }) : super(key: key);

  final List member;
  // final List Courses;

  @override
  State<Mycourse> createState() => _MycourseState();
}

class _MycourseState extends State<Mycourse> {

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 550,
              ),
              Container(
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 8, 104, 159),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(80)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemExtent: 95.0,
                          itemCount: widget.member.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              margin: EdgeInsets.only(left: 15, right: 25),
                              //color: Colors.red,
                              child: ListTile(
                                visualDensity: VisualDensity(vertical: 4),
                                // leading: CircleAvatar(
                                //   backgroundImage: NetworkImage(
                                //     member[index]['picture'],scale: 100
                                //   ),
                                // ),

                                leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                        width: 65,
                                        height: 65,
                                        child: Image.asset(
                                          'img/logo300x300.png',
                                          fit: BoxFit.cover,
                                        ))),
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Container(
                                    height: 38,
                                    //color: Color.fromARGB(255, 255, 0, 0),
                                    child: Text(
                                      widget.member[index]['username'],
                                      style: GoogleFonts.kanit(
                                          fontSize: 30,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                subtitle: Container(
                                  color: null,
                                  child: Text(
                                    widget.member[index]['email'],
                                    style: GoogleFonts.kanit(
                                        fontSize: 17,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Positioned(
                  child: Text(
                    'Continue your last course',
                    style: GoogleFonts.kanit(fontSize: 25, color: Colors.white),
                  ),
                  top: 150,
                  left: 25,
                  right: 0),
              Positioned(
                top: 200,
                left: 30,
                right: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    height: 330,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 250,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => screen1()));
                            },
                            child: Image.asset(
                              'img/img1.jpg',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Beginning for beginners',
                            style: GoogleFonts.kanit(
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 220,
            // color: Color.fromARGB(255, 18, 142, 57),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Your subscriptions ',
                    style: GoogleFonts.kanit(fontSize: 20),
                  ),
                ),
                // Container(
                //   child: Expanded(
                //     child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       itemCount: widget.Courses.length,
                //       itemBuilder: (context, index) {
                //         return Course(
                //             name: widget.Courses[index]['name'],
                //             image: widget.Courses[index]['image']);
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
