// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/styles.dart';

class SelfScanningScreen extends StatefulWidget {
  const SelfScanningScreen({Key? key}) : super(key: key);

  @override
  State<SelfScanningScreen> createState() => _SelfScanningScreenState();
}

class _SelfScanningScreenState extends State<SelfScanningScreen> {
  bool _loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker(); //allows us to pick image from gallery or camera

  @override
  void initState() {
    //initS is the first function that is executed by default when this class is called
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    //dis function disposes and clears our memory
    super.dispose();
    Tflite.close();
  }

  classifyImage(File image) async {
    //this function runs the model on the image
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults:
          3, //the amout of categories our neural network can predict (here no. of animals)
      threshold: 0.1,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  loadModel() async {
    //this function loads our model
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
  }

  pickImage() async {
    //this function to grab the image from camera
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async {
    //this function to grab the image from gallery
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                buildAppBar(),
              ],
          body: Scaffold(
            body: SingleChildScrollView(
              //color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Column(
                      children: [
                        Text("DISCLAIMER:",
                            style: GoogleFonts.poppins(
                                color: Colors.redAccent,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 5,
                        ),
                        Text("The result may not be 100% accurate.",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14.0,
                            )),
                        Text("Please consult with our Doctors",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14.0,
                            )),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    )),
                    Container(
                      child: Center(
                        child: _loading == true
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        200)) //show nothing if no picture selected
                            : Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.6,
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          _image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 25,
                                      thickness: 1,
                                    ),
                                    // ignore: unnecessary_null_comparison
                                    _output != null
                                        ? Text(' ${_output[0]['label']}',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                            ))
                                        : Container(),
                                    Divider(
                                      height: 25,
                                      thickness: 1,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text("Select image from camera or gallery",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14.0,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: pickImage,
                            child: Container(
                                height: 50,
                                width: 140,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    stops: [0.0, 1.0],
                                    colors: [
                                      Color(0xFF9DCEFF),
                                      Color(0XFF92A3FD),
                                    ],
                                  ),
                                  color: Colors.deepPurple.shade300,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Camera",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ))
                                  ],
                                )),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: pickGalleryImage,
                            child: Container(
                                height: 50,
                                width: 140,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    stops: [0.0, 1.0],
                                    colors: [
                                      Color(0xFF9DCEFF),
                                      Color(0XFF92A3FD),
                                    ],
                                  ),
                                  color: Colors.deepPurple.shade300,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.file_upload,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Gallery",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ))
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  SliverAppBar buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      // Color(0xFFCCD9FD),
      toolbarHeight: 90,
      forceElevated: true,
      elevation: 10,
      shadowColor: kSecBlue,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(70),
        bottomLeft: Radius.circular(70),
      )),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(children: [
            Text(
              'Identify Your Skin Condition',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
