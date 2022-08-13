// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontenddermora/doctor_screens/models/doctor_model.dart';
import 'package:frontenddermora/screens/auth/models/Profile_model.dart';
import 'package:frontenddermora/screens/routine/components/edit_routine.dart';
import 'package:frontenddermora/services/api_service.dart';
import 'package:frontenddermora/util/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../services/api_doctors.dart';
import '../../routine/routine_screen.dart';
import './DoctorsDetails.dart';
import './cardDetails.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Map> doctorsList = [];
  DoctorModel? availableDoctors;
  late Socket socket;
  @override
  void initState() {
    super.initState();
    initializeSocket();
    socket.connect();
    _get();
  }

  void initializeSocket() {
    socket = io("https://dermora.herokuapp.com/", <String, dynamic>{
      // socket = io("http://192.168.43.143:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.on('connect', (data) {
      print("client is connected to the socket");
    });
    socket.on('accepted', (data) {
      print('accepted');
      setState(() {
        for (var ele in doctorsList) {
          if (data["id"] == ele["id"]) {
            ele["isRequestAccepted"] = true;
            break;
          }
        }
      });
    });
    socket.on('disconnect', (data) {
      print('disconnect');
    });
  }

  _get() async {
    DoctorModel? doctors = await APIDoctors.getAvailableDoctors();
    Profile? userData = await APIService.getUserData();

    setState(() {
      availableDoctors = doctors!;
      var chatId;
      for (var element in availableDoctors!.data) {
        var res = false;
        var notIncluded = true;
        for (var ele in userData!.data.friends) {
          if (ele.id == element.id) {
            print("hi i got here twice");
            res = true;
            chatId = ele.chatId;
            if (!ele.status) {
              notIncluded = false;
            }
          }
        }
        if (!notIncluded) continue;
        doctorsList.add({
          "userId": userData.data.id,
          "userImage": userData.data.image,
          "userName": userData.data.fullName,
          "id": element.id,
          "image": element.image,
          "name": element.fullName,
          "myCity": userData.data.address.city,
          "myAge": userData.data.age,
          "label": "Dr. ${element.fullName}",
          "Key":
              "Dermatologist   ${element.doctorInfo.workDetails.experience} Years Experience",
          "isRequestSent": false,
          "isRequestAccepted": res,
          "isRequestDenied": false,
          "chatId": chatId
        });
      }
      socket.emit('joinNotificationRoom', doctorsList[0]["userId"]);
    });
  }

  @override
  void dispose() {
    socket
        .disconnect(); // --> disconnects the Socket.IO client once the screen is disposed
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  // padding: EdgeInsets.symmetric(
                  //   vertical: 1.0,
                  // ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                        ),
                        child: _buildTextBeforeBanner(),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: BannerCard(),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                        ),
                        child: _buildTextTodaysPlan(),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                        ),
                        child: _buildMorningRoutine(),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                        ),
                        child: _buildNightRoutine(),
                      ),
                      SizedBox(height: 30.0),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                        ),
                        child: _buildTextDoctors(),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                        ),
                        child: availableDoctors != null
                            ? DoctorsDetails(list: doctorsList, socket: socket)
                            : Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Center(
                                    child: LoadingAnimationWidget
                                        .staggeredDotsWave(
                                  color: kSecBlue,
                                  size: 25,
                                )),
                              ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextBeforeBanner() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        "Tips for a better Skin",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget _buildTextTodaysPlan() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        "Today’s plan",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget _buildMorningRoutine() {
    return Container(
      padding: const EdgeInsets.all(0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: kSecBlue),
        borderRadius: BorderRadius.circular(10.25),
        boxShadow: [
          BoxShadow(
            color: klightGrey.withOpacity(.8),
            offset: Offset(2, 4),
            blurRadius: 1,
            spreadRadius: 0,
          )
        ],
      ),
      child: ListTile(
          leading: Image.asset('assets/images/sun.png'),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Morning Routine ",
                  style: TextStyle(
                    fontSize: 14,
                    color: kSecBlue,
                  ),
                  softWrap: true,
                  maxLines: 3,
                  textAlign: TextAlign.center),
              SizedBox(height: 5.0),
              Text(
                "9:00 AM ",
                style: TextStyle(
                  fontSize: 14,
                  color: kSecBlue,
                ),
                softWrap: true,
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.0),
              Text(
                "Everyday ",
                style: TextStyle(
                  fontSize: 14,
                  color: kSecBlue,
                ),
                softWrap: true,
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_right,
              size: 30,
              color: kSecBlue,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RoutineScreen(kind: "morning")),
              );
            },
          )),
    );
  }

  Widget _buildNightRoutine() {
    return Container(
      padding: const EdgeInsets.all(0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: kSecBlue),
        borderRadius: BorderRadius.circular(10.25),
        boxShadow: [
          BoxShadow(
            color: klightGrey.withOpacity(.8),
            offset: Offset(2, 4),
            blurRadius: 1,
            spreadRadius: 0,
          )
        ],
      ),
      child: ListTile(
          leading: Image.asset('assets/images/moon.png'),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Night Routine ",
                style: TextStyle(
                  fontSize: 14,
                  color: kSecBlue,
                ),
                softWrap: true,
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.0),
              Text(
                "10:00 PM ",
                style: TextStyle(
                  fontSize: 14,
                  color: kSecBlue,
                ),
                softWrap: true,
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.0),
              Text(
                "Everyday ",
                style: TextStyle(
                  fontSize: 14,
                  color: kSecBlue,
                ),
                softWrap: true,
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_right,
              size: 30,
              color: kSecBlue,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RoutineScreen(kind: "night")),
              );
            },
          )),
    );
  }

  Widget _buildTextDoctors() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        "Dermatologists for you ",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
