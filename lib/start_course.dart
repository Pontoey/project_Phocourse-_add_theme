import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color.dart';
import 'model/mycoursemodel.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class StartCourse extends StatefulWidget {
  final String? courseid;
  final String? courseName;
  final String? courseDescription;
  final String? courseImg;

  List<ModelcourseVDO> VDO;

  StartCourse(
      {super.key,
      required this.courseid,
      required this.courseName,
      required this.courseDescription,
      required this.courseImg,
      required this.VDO});

  @override
  State<StartCourse> createState() => _StartCourseState();
}

class _StartCourseState extends State<StartCourse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    }

  Future<void> _launchUrl(Uri vdourl) async {
    if (!await launchUrl(vdourl)) {
      throw 'Could not launch $vdourl';
    }
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
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.courseName!,
                          style: GoogleFonts.kanit(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 550,
                          child: Text(
                            widget.courseDescription!,
                            style: GoogleFonts.kanit(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'About this course',
                                  style: GoogleFonts.kanit(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  child: ListView.builder(
                                    itemCount: widget.VDO.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[50],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          width: 550,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 300,
                                                  child: Text(
                                                    '${widget.VDO[index].vdoname}',
                                                    style: GoogleFonts.kanit(
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: IconButton(
                                                  onPressed: () {
                                                    launchUrl(Uri.parse(
                                                        '${widget.VDO[index].url}'));
                                                  },
                                                  icon: Icon(
                                                    Icons.play_circle_filled,
                                                    size: 30,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
