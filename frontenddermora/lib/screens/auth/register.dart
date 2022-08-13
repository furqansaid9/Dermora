// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontenddermora/screens/auth/login.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../config.dart';
import '../../services/api_service.dart';
import '../../util/styles.dart';
import '../primary_questions/intro.dart';
import 'models/register_request_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isAPIProcess = false;
  bool passwordVisible = false;
  bool checkedValue = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String? fName;
  String? lName;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _registerUI(context),
          ),
          inAsyncCall: isAPIProcess,
          key: UniqueKey(),
          opacity: 0.3,
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
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
                        'Hey There!',
                        style: GoogleFonts.poppins(
                          color: const Color(0xff1D1617),
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        "Create an Account",
                        style: GoogleFonts.poppins(
                          color: const Color(0xff1D1617),
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      FormHelper.inputFieldWidget(
                        context,
                        "fName",
                        "First Name",
                        (onValidateVal) {
                          if (onValidateVal.isEmpty) {
                            return 'First name cant\'t be empty.';
                          }
                          return null;
                        },
                        (onSavedVal) {
                          fName = onSavedVal;
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
                        prefixIcon: Icon(Icons.person_outlined),
                        backgroundColor: Color(0xffF7F8F8),
                        hintColor: const Color(0xff7B6F72).withOpacity(0.5),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: FormHelper.inputFieldWidget(
                          context,
                          "lName",
                          "Last Name",
                          (onValidateVal) {
                            if (onValidateVal.isEmpty) {
                              return 'Last Name cant\'t be empty.';
                            }
                            return null;
                          },
                          (onSavedVal) {
                            lName = onSavedVal;
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: FormHelper.inputFieldWidget(
                          context,
                          "email",
                          "Email",
                          (onValidateVal) {
                            if (onValidateVal.isEmpty) {
                              return 'Email cant\'t be empty.';
                            }
                            return null;
                          },
                          (onSavedVal) {
                            email = onSavedVal;
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
                      SizedBox(
                        height: 25.0,
                      ),
                      _buildCondtionPrivacyCheckbox(),
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
                              if (validateAndSave()) {
                                setState(() {
                                  isAPIProcess = true;
                                });
                                RegisterRequestModel model =
                                    RegisterRequestModel(
                                  firstName: fName!,
                                  lastName: lName!,
                                  email: email!,
                                  password: password!,
                                );

                                APIService.register(model).then((response) => {
                                      setState(() {
                                        isAPIProcess = false;
                                      }),
                                      if (response)
                                        {
                                          FormHelper.showSimpleAlertDialog(
                                              context,
                                              Config.appName,
                                              "Successful Registration, Please Login",
                                              "OK", () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen()),
                                                ModalRoute.withName("/login"));
                                          })
                                        }
                                      else
                                        {
                                          FormHelper.showSimpleAlertDialog(
                                              context,
                                              Config.appName,
                                              "Invalid",
                                              "OK", () {
                                            Navigator.pop(context);
                                          })
                                        }
                                    });
                              }

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           const PrimaryQuestionsScreen()),
                              // );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ),
                              child: Text('Register',
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
                      _buildSigninBtn(),
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

  Widget _buildCondtionPrivacyCheckbox() {
    return Container(
      width: double.infinity,
      child: CheckboxListTile(
        title: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            children: [
              TextSpan(
                text: "By creating an account, you agree to our ",
                style: TextStyle(
                  color: const Color(0xffADA4A5),
                  fontSize: 12,
                ),
              ),
              WidgetSpan(
                child: InkWell(
                  onTap: () {
                    // ignore: avoid_print
                    print('Conditions of Use');
                  },
                  child: Text(
                    "Conditions of Use",
                    style: TextStyle(
                      color: const Color(0xffADA4A5),
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              TextSpan(
                text: " and ",
                style: TextStyle(
                  color: const Color(0xffADA4A5),
                  fontSize: 12,
                ),
              ),
              WidgetSpan(
                child: InkWell(
                  onTap: () {
                    // ignore: avoid_print
                    print('Privacy Notice');
                  },
                  child: Text(
                    "Privacy Notice",
                    style: TextStyle(
                      color: const Color(0xffADA4A5),
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        activeColor: const Color(0xff7B6F72),
        value: checkedValue,
        onChanged: (newValue) {
          setState(() {
            checkedValue = newValue!;
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  Widget _buildSignUpWithText() {
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

  Widget _buildSigninBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            ModalRoute.withName("/login"));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account? ',
              style: GoogleFonts.poppins(
                color: Color(0xff1D1617),
                fontSize: 16.0,
              ),
            ),
            TextSpan(
              text: 'Login',
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
