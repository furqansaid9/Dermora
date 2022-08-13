// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontenddermora/screens/auth/models/Profile_model.dart';
import 'package:frontenddermora/util/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../services/api_service.dart';
import './doctorDetails.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Profile? userData;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Map> patients = [];

  void _onRefresh() async {
    _get();
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    _get();
  }

  _get() async {
    Profile? user = await APIService.getUserData();
    setState(() {
      patients.clear();
      userData = user!;
      for (var element in user.data.friendRequests) {
        patients.add({
          "friendId": element.id,
          "image": element.image,
          "label": element.name,
          "Key": "${element.city}   ${element.age} years old",
          "time": "Request time ${element.time}",
          "isAccepted": false,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: SafeArea(
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
                      padding: EdgeInsets.symmetric(
                        vertical: 1.0,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 30.0),
                            child: _buildTextDoctors(),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.0,
                            ),
                            child: userData == null
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Center(
                                        child: LoadingAnimationWidget
                                            .staggeredDotsWave(
                                      color: kSecBlue,
                                      size: 50,
                                    )),
                                  )
                                : DoctorsDetails(
                                    list: patients, userData: userData!),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildTextDoctors() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        "Today’s patient chat Request",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
