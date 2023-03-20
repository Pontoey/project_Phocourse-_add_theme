import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniproject/home.dart';
import 'package:miniproject/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
FToast fToast = FToast();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }
  final formusersname = TextEditingController();
  final formpassword = TextEditingController();

  void checkLogin(String username, String password) async {
    var url = Uri.parse('http://10.0.2.2/photo/login.php');
    var response = await http.post(url, body: {
      'username': username,
      'password': password,
    });
    var data = jsonDecode(response.body);
    if (data == "Fail") {
      _showToast();
      print("Login Fail");
      return;
    } else {
      String userid = data[0]['userid'].toString();
      goHome(userid);
    }
  }

  void goHome(String userid) {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: home(
          id: userid,
        ),
      ),
    );
  }

  _showToast() {
   Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color.fromARGB(255, 230, 81, 55),
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            Icon(Icons.error_outline),
            SizedBox(
            width: 12.0,
            ),
            Text("กรุณากรอกข้อมูลให้ถูกต้อง"),
        ],
        ),
    );


    fToast.showToast(
        
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
    );
    
    // Custom Toast Position
    // fToast.showToast(
    //     child: toast,
    //     toastDuration: Duration(seconds: 2),
    //     positionedToastBuilder: (context, child) {
    //       return Positioned(
    //         child: child,
    //         top: 16.0,
    //         left: 16.0,
    //       );
    //     });
  }

  TextStyle heading1 = GoogleFonts.kanit(
      fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle Chike = GoogleFonts.kanit(
      decoration: TextDecoration.underline,
      decorationThickness: 2,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white);
  TextStyle Input = GoogleFonts.kanit(color: Colors.white);
  TextStyle password = GoogleFonts.kanit(color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 8, 104, 159),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Welcome back',
                  style: heading1,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 350,
                      child: TextField(
                        controller: formusersname,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'User name',
                          labelStyle: Input,
                          contentPadding: EdgeInsets.all(20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 255, 255, 255)),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      width: 350,
                      child: TextField(
                        controller: formpassword,
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'password',
                          labelStyle: Input,
                          contentPadding: EdgeInsets.all(20),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              )),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 255, 255, 255)),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Ready to Start?',
                      style: Chike,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: SizedBox(
                      width: 350,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () =>
                            {checkLogin(formusersname.text, formpassword.text)},
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 255, 255, 255),
                          onPrimary: Color.fromARGB(255, 0, 0, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t have account yet?',
                          style: GoogleFonts.kanit(
                              color: Colors.white, fontSize: 15),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: register()));
                            },
                            child: Text(
                              'Sign up',
                              style: Chike,
                            )),
                        Text(
                          'now!',
                          style: GoogleFonts.kanit(
                              color: Colors.white, fontSize: 15),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final formkey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final FullnameController = TextEditingController();

  void checkregister(
      String username, String password, String email, String fullname) async {
    var url = Uri.parse('http://10.0.2.2/photo/reginter.php');
    var response = await http.post(url, body: {
      'username': username,
      'password': password,
      'email': email,
      'fullname': fullname,
    });
    var data = jsonDecode(response.body);
    if (data == "Error") {
      print("register Fail");
      return;
    } else {
      gologin();
    }
  }

  void gologin() {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: login(),
      ),
    );
  }

  TextStyle heading1 = GoogleFonts.kanit(
      fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle Chike = GoogleFonts.kanit(
      decoration: TextDecoration.underline,
      decorationThickness: 2,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white);
  TextStyle Input = GoogleFonts.kanit(color: Colors.white);
  TextStyle password = GoogleFonts.kanit(color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 8, 104, 159),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 300,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Create Account',
                    style: heading1,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: emailController,
                            // validator: MultiValidator([
                            //   RequiredValidator(errorText: 'กรุณากรอกอีเมล'),
                            //   EmailValidator(errorText: 'รูปแบบอีเมลไม่ถูกต้อง'),
                            // ]),
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: Input,
                              contentPadding: EdgeInsets.all(20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: FullnameController,
                            // validator: MultiValidator([
                            //   RequiredValidator(errorText: 'กรุณากรอกอีเมล'),
                            //   EmailValidator(errorText: 'รูปแบบอีเมลไม่ถูกต้อง'),
                            // ]),
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              labelStyle: Input,
                              contentPadding: EdgeInsets.all(20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: usernameController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'User Name',
                              labelStyle: Input,
                              contentPadding: EdgeInsets.all(20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'password',
                              labelStyle: Input,
                              contentPadding: EdgeInsets.all(20),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: SizedBox(
                          width: 350,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => {
                              if (formkey.currentState!.validate())
                                {
                                  checkregister(
                                      usernameController.text,
                                      passwordController.text,
                                      emailController.text,
                                      FullnameController.text)
                                }
                            },
                            // Navigator.pushReplacement(
                            //     context,
                            //     PageTransition(
                            //         type: PageTransitionType.rightToLeft,
                            //         child: login()));

                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 255, 255, 255),
                              onPrimary: Color.fromARGB(255, 0, 0, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: login()));
                                },
                                child: Text(
                                  'Back to login.',
                                  style: Chike,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
