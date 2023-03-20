import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniproject/login_register.dart';
import 'package:miniproject/model/mycoursemodel.dart';
import 'package:miniproject/screen.dart';

import 'color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'home_course.dart';
import 'model/TakecouseModel.dart';

import 'package:image_picker/image_picker.dart';

//import 'model/mycourse.dart';
// class MyPageController extends PageController {
//    @override
//    int get initialPage => 3;
// }

class home extends StatefulWidget {
  final String id;

  const home({Key? key, required this.id}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _refreshprofileKey =
      GlobalKey<RefreshIndicatorState>();

  FToast fToast = FToast();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
    //print('Test : ${widget.id}');
    allCosue();
    getmember();
    TakedCosue();
  }

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final fullnameController = TextEditingController();

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("แก้ไขสำเสร็จ"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  _showToastrefreshCoursee() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color.fromARGB(255, 240, 105, 105),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline),
          SizedBox(
            width: 12.0,
          ),
          Text("ไม่พบข้อมูล"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  //profile image
  File? _image;
  final picker = ImagePicker();

  Future uploadImage() async {
    final uri = Uri.parse('http://10.0.2.2/photo/image.php');
    var request = http.MultipartRequest(
      'POST',
      uri,
    );
    request.fields['userid'] = widget.id;
    var pic = await http.MultipartFile.fromPath("image", _image!.path);
    request.files.add(pic);
    var response = await request.send();
    var body = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print('Image Uploded');
    } else {
      print('Image Not Uploded');
    }
    setState(() {});
  }

  Future choiceImage() async {
    // ignore: deprecated_member_use
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
      uploadImage();
    });
  }

////////////////////////////////getmember

  Future<void> showlist1() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      getmember();
    });
  }

  Future<void> clearlist1() async {
    await Future.delayed(Duration(seconds: 0));
    setState(() {
      memberlist.clear();
    });
  }

  Future<void> relondprofile() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  Future refresh1() async {
    await clearlist1();
    await showlist1();
  }

  List<mycourseModel> memberlist = [];
  Future getmember() async {
    var url1 = Uri.parse('http://10.0.2.2/photo/Select.php');
    var response1 = await http.post(url1, body: {
      'userid': widget.id,
    });
    var data1 = jsonDecode(response1.body);
    print(data1);
    for (var i = 0; i < data1.length; i++) {
      mycourseModel mycourse = mycourseModel(
        name: data1[i]['username'],
        email: data1[i]['email'],
        img: data1[i]['pic'],
        fullname: data1[i]['fullname'],
      );
      this.memberlist.add(mycourse);
    }
    usernameController.text = memberlist[0].name.toString();
    emailController.text = memberlist[0].email.toString();
    fullnameController.text = memberlist[0].fullname.toString();
    return memberlist;
  }
  ////////////////////////////////getmember

  Future addCourse() async {
    var url1 = Uri.parse('http://10.0.2.2/photo/addCourseRecommend.php');
    var response1 = await http.post(url1, body: {
      'userid': widget.id,
      'courseID': '1',
    });
    var addCourse = jsonDecode(response1.body);
    if (addCourse == 'success') {
      print('success');
    } else {
      print('fail');
    }
  }

  Future<void> showlist() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      TakedCosue();
    });
  }

  Future<void> clearlist() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      takedcouse.clear();
    });
  }

  Future refresh() async {
    await clearlist();
    await showlist();
  }

  List<takedCouseModel> takedcouse = [];
  Future TakedCosue() async {
    var url1 = Uri.parse('http://10.0.2.2/photo/takedCouse.php');
    var response1 = await http.post(url1, body: {
      'userid': widget.id,
    });
    var dataTaked = jsonDecode(response1.body);
    //print(dataTaked);
    for (var i = 0; i < dataTaked.length; i++) {
      takedCouseModel taked = takedCouseModel(
        userid: dataTaked[i]['userid'],
        course_id: dataTaked[i]['course_id'],
        course_name: dataTaked[i]['course_name'],
        course_description: dataTaked[i]['course_description'],
        course_img: dataTaked[i]['course_img'],
        TypeID: dataTaked[i]['TypeID'],
      );

      this.takedcouse.add(taked);
    }

    return takedcouse;
  }

/////searchCourse
  ///
  Future<void> showlistCourse() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      searchCourse(SearchC.text);
    });
  }

  Future<void> clearlistCourse() async {
    await Future.delayed(Duration(seconds: 0));
    setState(() {
      allCouse.clear();
    });
  }

  Future refreshCourseRE() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  Future refreshCourse() async {
    await clearlistCourse();
    await showlistCourse();
  }

  final SearchC = TextEditingController();
  void searchCourse(String Search) async {
    var url = Uri.parse('http://10.0.2.2/photo/searchCourse.php');
    var response = await http.post(url, body: {
      'course_name': Search,
    });
    var data = jsonDecode(response.body);
    if (data == "Fail") {
      print("ไม่พบข้อมูล");
      _showToastrefreshCoursee();
      return;
    } else {
      for (var i = 0; i < data.length; i++) {
        takedCouseModel all = takedCouseModel(
          userid: data[i]['userid'],
          course_id: data[i]['course_id'],
          course_name: data[i]['course_name'],
          course_description: data[i]['course_description'],
          course_img: data[i]['course_img'],
          TypeID: data[i]['TypeID'],
        );

        this.allCouse.add(all);
        print(allCouse[i].course_name.toString());
      }
    }
  }
/////searchCourse

/////////allcourse
  List<takedCouseModel> allCouse = [];
  Future allCosue() async {
    var url1 = Uri.parse('http://10.0.2.2/photo/Select_couse.php');
    var response1 = await http.post(url1, body: {});

    var dataAllCouse = jsonDecode(response1.body);
    //print(dataAllCouse);
    for (var i = 0; i < dataAllCouse.length; i++) {
      takedCouseModel all = takedCouseModel(
        userid: dataAllCouse[i]['userid'],
        course_id: dataAllCouse[i]['course_id'],
        course_name: dataAllCouse[i]['course_name'],
        course_description: dataAllCouse[i]['course_description'],
        course_img: dataAllCouse[i]['course_img'],
        TypeID: dataAllCouse[i]['TypeID'],
      );

      this.allCouse.add(all);
    }

    return allCouse;
  }
  /////////allcourse

  Future Editmember(String username, String email, String fullname) async {
    var url1 = Uri.parse('http://10.0.2.2/photo/EditUser.php');
    var response1 = await http.post(url1, body: {
      'userid': widget.id,
      'username': username,
      'email': email,
      'fullname': fullname,
    });
    var data1 = jsonDecode(response1.body);
    print(data1);
  }

  int _nwepage = 2;
  int next = 2;

  PageController pageController = PageController(
    initialPage: 2,
  );

  void onTapped(int index) {
    setState(() {
      _nwepage = index;
    });
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  //URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: Color.fromARGB(255, 207, 231, 246),
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255, 8, 104, 159),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('img/logo300x300.png', width: 40),
            // IconButton(
            //     onPressed: () {
            //       //Navigator.pop(context);
            //     },
            //     icon: Icon(
            //       Icons.menu,
            //       size: 35,
            //     )),
            Text(
              'PhoCourse',
              style:
                  GoogleFonts.kanit(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: PageView(
        onPageChanged: (int next) {
          setState(() {
            _nwepage = next;
          });
        },
        controller: pageController,
        children: [
          //Mysouse
          MYcoruse(context),
          //Explore
          Explore(),
          //home
          home(),
          //recommend
          recommend(),
          //Profile
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'My Corrse',
              //backgroundColor: Color.fromARGB(255, 8, 104, 159)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: 'Explore',
              //backgroundColor: Color.fromARGB(255, 8, 104, 159)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              //backgroundColor: Color.fromARGB(255, 8, 104, 159)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Recommend',

              //backgroundColor: Color.fromARGB(255, 8, 104, 159)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
              //backgroundColor: Color.fromARGB(255, 8, 104, 159)
            ),
          ],
          currentIndex: _nwepage,
          selectedItemColor: Color.fromARGB(255, 255, 255, 255),
          unselectedItemColor: Color.fromARGB(255, 207, 231, 246),
          onTap: onTapped),
    );
  }

  Padding Profile() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 130,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      key: _refreshprofileKey,
                      onRefresh: relondprofile,
                      child: ListView.builder(
                          itemExtent: 95.0,
                          itemCount: memberlist.length,
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
                                leading: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: CircleAvatar(
                                          maxRadius: 32,
                                          backgroundImage: _image == null
                                              ? Image.network(
                                                      'http://10.0.2.2/photo/upload/${memberlist[index].img}')
                                                  .image
                                              : FileImage(File(_image!.path)),
                                        )),
                                    Positioned(
                                      child: Container(
                                        width: 65,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(147, 8, 104, 159),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            choiceImage();
                                            refresh1();
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Color.fromARGB(
                                                147, 255, 255, 255),
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Container(
                                    height: 38,
                                    //color: Color.fromARGB(255, 255, 0, 0),
                                    child: Text(
                                      memberlist[index].fullname.toString(),
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
                                    memberlist[index].email.toString(),
                                    style: GoogleFonts.kanit(
                                        fontSize: 17,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
            //EditUser
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  width: double.infinity,
                  height: 550,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: GoogleFonts.kanit(
                              fontSize: 20,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        TextFormField(
                          controller: usernameController,
                          // controller: ,
                          style: GoogleFonts.kanit(
                              fontSize: 23,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  end: 10, start: 1),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colortheme1.dark_blue(),
                                    borderRadius: BorderRadius.circular(15)),
                                child: IconButton(
                                  onPressed: () {
                                    _refreshprofileKey.currentState?.show();
                                    refresh1();
                                    _showToast();
                                    print('edit');
                                    Editmember(
                                        usernameController.text,
                                        emailController.text,
                                        fullnameController.text);
                                  },
                                  icon: Icon(
                                    size: 20,
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.all(12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
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
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Email',
                          style: GoogleFonts.kanit(
                              fontSize: 20,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        TextFormField(
                          controller: emailController,
                          // controller: ,
                          style: GoogleFonts.kanit(
                              fontSize: 23,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  end: 10, start: 1),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colortheme1.dark_blue(),
                                    borderRadius: BorderRadius.circular(15)),
                                child: IconButton(
                                  onPressed: () {
                                    _showToast();
                                    refresh1();
                                    _refreshprofileKey.currentState?.show();
                                    Editmember(
                                        usernameController.text,
                                        emailController.text,
                                        fullnameController.text);
                                  },
                                  icon: Icon(
                                    size: 20,
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.all(12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
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
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Fullname',
                          style: GoogleFonts.kanit(
                              fontSize: 20,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        TextFormField(
                          controller: fullnameController,
                          style: GoogleFonts.kanit(
                              fontSize: 23,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  end: 10, start: 1),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colortheme1.dark_blue(),
                                    borderRadius: BorderRadius.circular(15)),
                                child: IconButton(
                                  onPressed: () {
                                    _showToast();
                                    print('edit');
                                    refresh1();
                                    _refreshprofileKey.currentState?.show();
                                    Editmember(
                                        usernameController.text,
                                        emailController.text,
                                        fullnameController.text);
                                  },
                                  icon: Icon(
                                    size: 20,
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.all(12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
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
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                            width: 180,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                _showToast();
                                print('edit');
                                refresh1();
                                _refreshprofileKey.currentState?.show();
                                Editmember(
                                    usernameController.text,
                                    emailController.text,
                                    fullnameController.text);
                              },
                              child: Text(
                                'SAVE',
                                style: GoogleFonts.kanit(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colortheme1.dark_blue(),
                                onPrimary: Color.fromARGB(255, 0, 0, 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: SizedBox(
                            width: 300,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () => {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login()),
                                )
                              },
                              child: Text(
                                'Logout',
                                style: GoogleFonts.kanit(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colortheme1.light_red(),
                                onPrimary: Color.fromARGB(255, 0, 0, 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container recommend() {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          //height: 100,
          height: MediaQuery.of(context).size.height * 0.78,
          width: double.infinity,
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: refresh,
            child: ListView.builder(
              //itemExtent: 250.0,
              scrollDirection: Axis.vertical,
              itemCount: allCouse.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: double.infinity,
                    height: 400,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          child: Image.asset(
                            'img/${allCouse[index].course_img}',
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          child: Text('${allCouse[index].course_name}',
                              style: GoogleFonts.kanit(
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 0, 0, 0))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Container(
                            child: Text('${allCouse[index].course_description}',
                                style: GoogleFonts.kanit(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                //send id to homecourse
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeCourse(
                                              courseid:
                                                  allCouse[index].course_id,
                                              courseName:
                                                  allCouse[index].course_name,
                                              courseDescription: allCouse[index]
                                                  .course_description,
                                              courseImg:
                                                  allCouse[index].course_img,
                                              Userid: widget.id,
                                            )));
                              },
                              child: Text(
                                'Go to course',
                                style: GoogleFonts.kanit(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colortheme1.light_red(),
                                onPrimary: Color.fromARGB(255, 255, 255, 255),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Container home() {
    return Container(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              color: Colortheme1.light_blue(),
              //color: Color.fromARGB(255, 255, 0, 0),
              height: 720,
            ),
            Positioned(
              top: 85,
              left: 0,
              right: 0,
              child: Container(
                  height: 250,
                  width: double.infinity,
                  child: Image.asset(
                    'img/home.jpg',
                    fit: BoxFit.cover,
                  )),
            ),
            Positioned(
              top: 85,
              left: 0,
              right: 0,
              child: Container(
                color: Color.fromARGB(175, 8, 104, 159),
                height: 250,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What is PhoCourse? ',
                        style: GoogleFonts.kanit(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 300,
                        child: Text(
                          'PhoCourse is a platform for learning photography, easy to understand and has a variety of lessons.',
                          style: GoogleFonts.kanit(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Let’s started with PhoCourse!',
                      style:
                          GoogleFonts.kanit(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ],
              ),
              width: double.infinity,
              height: 115,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 0, 0, 0), blurRadius: 10)
                  ],
                  color: Colortheme1.dark_blue(),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(22))),
            )),
            Positioned(
                top: 340,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Text(
                      'Are you ready?',
                      style: GoogleFonts.kanit(
                          fontSize: 30, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    Container(
                      width: 300,
                      child: Center(
                        child: Container(
                          child: Text(
                            'Ready to learn and  with PhoCourse? let’s get started',
                            style: GoogleFonts.kanit(
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 0, 0)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: 300,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              pageController.animateToPage(1,
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.easeInOut);
                            });
                          },
                          child: Text(
                            'Get Start',
                            style: GoogleFonts.kanit(
                              fontSize: 22,
                              //fontWeight: FontWeight.bold,
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
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Container Explore() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 110),
              height: 230,
              decoration: BoxDecoration(
                  color: Colortheme1.dark_blue(),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(50))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('What would you like to learn?',
                      style: GoogleFonts.kanit(
                          fontSize: 25,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  TextFormField(
                    controller: SearchC,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search for course',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      suffixIcon: Padding(
                        padding:
                            const EdgeInsetsDirectional.only(end: 12, start: 1),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colortheme1.dark_blue(),
                              borderRadius: BorderRadius.circular(10)),
                          child: IconButton(
                            onPressed: () {
                              //searchCourse(SearchC.text);
                              setState(() {
                                refreshCourse();
                                _refreshKey.currentState?.show();
                              });
                              print('Search for course');
                            },
                            icon: Icon(
                              size: 30,
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.all(20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
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
                ],
              ),
            ),
            RefreshIndicator(
              key: _refreshKey,
              onRefresh: refreshCourseRE,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: allCouse.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 1.2),
                    itemBuilder: (context, index) {
                      return Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Stack(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(left: 5, right: 5, top: 5),
                                width: 200,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'img/${allCouse[index].course_img}',
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeCourse(
                                                courseid:
                                                    allCouse[index].course_id,
                                                courseName:
                                                    allCouse[index].course_name,
                                                courseDescription:
                                                    allCouse[index]
                                                        .course_description,
                                                courseImg:
                                                    allCouse[index].course_img,
                                                Userid: widget.id,
                                              )));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 5, right: 5, top: 5),
                                  width: 200,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(101, 8, 104, 159),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        allCouse[index].course_name.toString(),
                                        style: GoogleFonts.kanit(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "2 Lesson",
                                        style: GoogleFonts.kanit(
                                          color: Colors.white,
                                          fontSize: 15,
                                          //fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ));
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  SingleChildScrollView MYcoruse(BuildContext context) {
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
                          itemCount: memberlist.length,
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
                                        child: Image.network(
                                          //when image null show default image
                                          memberlist[index].img == null
                                              ? 'http://10.0.2.2/photo/upload/img1.jpg'
                                              : 'http://10.0.2.2/photo/upload/${memberlist[index].img}',

                                          fit: BoxFit.cover,
                                        ))),
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Container(
                                    height: 38,
                                    //color: Color.fromARGB(255, 255, 0, 0),
                                    child: Text(
                                      memberlist[index].fullname.toString(),
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
                                    memberlist[index].email.toString(),
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
                    'Recommend for beginner',
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
                              setState(() {
                                addCourse();

                                _refreshIndicatorKey.currentState?.show();
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeCourse(
                                            courseid: '1',
                                            courseName: 'Beginning',
                                            courseDescription:
                                                'This lesson will be the foundation for beginners in photography. That will make you know things in photography.',
                                            courseImg: 'img1.jpg',
                                            Userid: widget.id,
                                          )));
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
                                fontSize: 23,
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
            height: 240,
            //color: Color.fromARGB(255, 18, 142, 57),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your subscriptions ',
                        style: GoogleFonts.kanit(
                          fontSize: 25,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _refreshIndicatorKey.currentState?.show();
                            });
                          },
                          child: Icon(Icons.replay_outlined))
                    ],
                  ),
                ),
                Container(
                  height: 180,
                  width: double.infinity,
                  child: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: refresh,
                    child: ListView.builder(
                      itemExtent: 140.0,
                      scrollDirection: Axis.horizontal,
                      itemCount: takedcouse.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 140,
                                          height: 80,
                                          child: Image.asset(
                                            'img/${takedcouse[index].course_img}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          '${takedcouse[index].course_name}',
                                          style: GoogleFonts.kanit(
                                            fontSize: 18,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            //send id to homecourse
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeCourse(
                                                          courseid:
                                                              takedcouse[index]
                                                                  .course_id,
                                                          courseName:
                                                              takedcouse[index]
                                                                  .course_name,
                                                          courseDescription:
                                                              takedcouse[index]
                                                                  .course_description,
                                                          courseImg:
                                                              takedcouse[index]
                                                                  .course_img,
                                                          Userid: widget.id,
                                                        )));
                                          },
                                          child: Text(
                                            'Go to course',
                                            style: GoogleFonts.kanit(
                                              fontSize: 10,
                                              //fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colortheme1.dark_blue(),
                                            onPrimary: Color.fromARGB(
                                                255, 255, 255, 255),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
