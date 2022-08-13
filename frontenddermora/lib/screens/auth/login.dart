// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontenddermora/screens/auth/models/login_request_model.dart';
import 'package:frontenddermora/screens/home/homepage_screen.dart';
import 'package:frontenddermora/screens/primary_questions/intro.dart';
import 'package:frontenddermora/services/api_service.dart';
import 'package:frontenddermora/util/styles.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../config.dart';
import '../../doctor_screens/doctorEntery.dart';
import '../entry.dart';
import './register.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isAPIProcess = false;
  bool _rememberMe = false;
  bool passwordVisible = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? email;
  String? password;

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _loginUI(context),
          ),
          inAsyncCall: isAPIProcess,
          key: UniqueKey(),
          opacity: 0.3,
        ),
      ),
    );
  } //

  Widget _loginUI(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
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
                  horizontal: 40.0,
                  vertical: 80.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Welcome Back',
                      style: GoogleFonts.poppins(
                        color: const Color(0xff1D1617),
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "You've been missed!",
                      style: GoogleFonts.poppins(
                        color: const Color(0xff1D1617),
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 35.0),
                    FormHelper.inputFieldWidget(
                      context,
                      "email",
                      "Email",
                      (onValidateVal) {
                        if (onValidateVal.isEmpty) {
                          return 'Username cant\'t be empty.';
                        }
                        return null;
                      },
                      (onSavedVal) {
                        this.email = onSavedVal;
                        // print(email);
                      },
                      paddingLeft: 0,
                      paddingRight: 0,
                      borderFocusColor: kSecBlue.withOpacity(0.2),
                      borderColor: Colors.white,
                      prefixIconColor: Color(0xff7B6F72),
                      textColor: kSecBlue,
                      borderRadius: 15,
                      hintFontSize: 15,
                      showPrefixIcon: true,
                      prefixIcon: Icon(Icons.email_outlined),
                      backgroundColor: Color(0xffF7F8F8),
                      hintColor: const Color(0xff7B6F72).withOpacity(0.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: FormHelper.inputFieldWidget(
                        context,
                        "password",
                        "Password",
                        (onValidateVal) {
                          if (onValidateVal.isEmpty) {
                            return 'Password cant\'t be empty.';
                          }
                          return null;
                        },
                        (onSavedVal) {
                          password = onSavedVal;
                        },
                        paddingLeft: 0,
                        paddingRight: 0,
                        borderFocusColor: kSecBlue.withOpacity(0.2),
                        borderColor: Colors.white,
                        prefixIconColor: Color(0xff7B6F72),
                        textColor: kSecBlue,
                        borderRadius: 15,
                        hintFontSize: 15,
                        showPrefixIcon: true,
                        prefixIcon: Icon(Icons.lock_outline),
                        backgroundColor: Color(0xffF7F8F8),
                        hintColor: const Color(0xff7B6F72).withOpacity(0.5),
                        obscureText: passwordVisible,
                        suffixIcon: IconButton(
                          color: const Color(0xff7B6F72),
                          splashRadius: 1,
                          onPressed: togglePassword,
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 35.0),
                    _buildForgotPasswordBtn(),
                    _buildRememberMeCheckbox(),
                    SizedBox(
                      height: 50.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 25.0),
                      child: Container(
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
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(99.0),
                              ),
                            ),
                            minimumSize:
                                MaterialStateProperty.all(Size(315, 60)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            // elevation: MaterialStateProperty.all(3),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          onPressed: () {
                            print(email);
                            if (validateAndSave()) {
                              setState(() {
                                isAPIProcess = true;
                              });
                              LoginRequestModel model = LoginRequestModel(
                                  email: email!, password: password!);

                              APIService.login(model).then((response) => {
                                    setState(() {
                                      isAPIProcess = false;
                                    }),
                                    if (response != null)
                                      {
                                        if (response.data.user.kind == "doctor")
                                          {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DoctorEntryWidget(
                                                            selectedIndex: 0)),
                                                (route) => false)
                                          }
                                        else
                                          {
                                            if (response.data.user.isFirst)
                                              {
                                                APIService.updateIsFirst()
                                                    .then((res) => {
                                                          Navigator.pushAndRemoveUntil(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          PrimaryQuestionsScreen()),
                                                              (route) => false)
                                                        })
                                              }
                                            else
                                              {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EntryWidget(
                                                                selectedIndex:
                                                                    0)),
                                                    (route) => false)
                                              }
                                          }
                                      }
                                    else
                                      {
                                        FormHelper.showSimpleAlertDialog(
                                            context,
                                            Config.appName,
                                            "Invalid Username/Password !",
                                            "OK", () {
                                          Navigator.pop(context);
                                        })
                                      }
                                  });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: Text('Login',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 18.0,
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildSignInWithText(),
                    SizedBox(
                      height: 40.0,
                    ),
                    _buildSignupBtn(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text('Forgot Password?',
            style: GoogleFonts.poppins(
              color: const Color(0xffADA4A5),
              decoration: TextDecoration.underline,
            )),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              //checkColor: Color.fromARGB(255, 100, 191, 233),
              activeColor: const Color(0xff7B6F72),
              side: MaterialStateBorderSide.resolveWith(
                (states) =>
                    BorderSide(width: 1, color: const Color(0xff7B6F72)),
              ),
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: GoogleFonts.poppins(
              color: const Color(0xffADA4A5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black,
                  height: 36,
                )),
          ),
          Text(
            'OR',
            style: GoogleFonts.poppins(
              color: Color(0xff1D1617),
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: Divider(
                  color: Colors.black,
                  height: 36,
                )),
          ),
        ]),
      ],
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => RegisterScreen()),
            ModalRoute.withName("/register"));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account yet? ',
              style: GoogleFonts.poppins(
                color: Color(0xff1D1617),
                fontSize: 16.0,
              ),
            ),
            TextSpan(
              text: 'Register',
              style: GoogleFonts.poppins(
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: <Color>[
                      Color(0xffEEA4CE),
                      Color(0xffC58BF2),
                    ],
                  ).createShader(
                    const Rect.fromLTWH(
                      0.0,
                      0.0,
                      200.0,
                      70.0,
                    ),
                  ),
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
