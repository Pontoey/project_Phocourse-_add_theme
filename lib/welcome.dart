import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniproject/login_register.dart';
import 'package:page_transition/page_transition.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  TextStyle heading1 =  GoogleFonts.kanit(
    fontSize: 25,
    //fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 207,231,246),
      body: Column(
        children: [
          Container(
            width: 500,
            height: 600,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 8,104,159),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(135))),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.all(11),
                  child: Image.asset(
                    'img/logo300x300.png',
                    width: 100,
                  ),
                ),
                Text(
                  'PhoCourse',
                  style: GoogleFonts.kanit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                            //color: Colors.red,
                            width: 270,
                            child: Text(
                              'Welcome to PhoCourse ',
                              style: GoogleFonts.kanit(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Container(
                            //color: Colors.red,
                            width: 285,
                            child: Text(
                              'A Photo Library for beginners and advanced ',
                              style: GoogleFonts.kanit(
                                fontSize: 23,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Column(children: [
              SizedBox(
                width: 350,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 255, 255),
                    onPrimary: Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: login()));
                    // Navigator.pop(
                    //     context, MaterialPageRoute(builder: ((context) => Home())));
                    //Navigator.pop(context);
                  },
                  child: Text(
                    'Login',
                    style: heading1,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 350,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255,126,103),
                    onPrimary: Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: register()));
                    // Navigator.pop(
                    //     context, MaterialPageRoute(builder: ((context) => Home())));
                    //Navigator.pop(context);
                  },
                  child: Text(
                    'Sign Up',
                    style: heading1,
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
