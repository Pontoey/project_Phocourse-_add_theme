import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:miniproject/main.dart';
import 'package:miniproject/welcome.dart';
import 'package:page_transition/page_transition.dart';

class screen1 extends StatefulWidget {
  const screen1({Key? key}) : super(key: key);

  @override
  State<screen1> createState() => _screen1State();
}

class _screen1State extends State<screen1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nextscreen();
  }

  _nextscreen() async {
    await Future.delayed(Duration(milliseconds: 900), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen2()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 104, 159),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'img/logo300x300.png',
            width: 230,
          ))
        ],
      ),
    );
  }
}

class screen2 extends StatefulWidget {
  const screen2({Key? key}) : super(key: key);

  @override
  State<screen2> createState() => _screen2State();
}

class _screen2State extends State<screen2> {
  TextStyle heading1 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nextscreen();
  }

  _nextscreen() async {
    await Future.delayed(Duration(milliseconds: 4500), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.bottomToTop, child: Welcome()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 104, 159),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 280,
          ),
          Center(
              child: Image.asset(
            'img/logo300x300.png',
            width: 150,
          )),
          Text(
            'PhoCourse',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(
            height: 150,
          ),
          LoadingAnimationWidget.discreteCircle(
            color: Colors.white,
            size: 50,
          ),

          // CircularProgressIndicator(
          //             color: Color.fromARGB(255, 255, 255, 255),
          //           ),
          //Text('', style: TextStyle(fontSize: 30),)
        ],
      ),
    );
  }
}
