
                    // // FormHelper.inputFieldWidget(
                    // //   context,
                    // //   "email",
                    // //   "Email",
                    // //   (onValidateVal) {
                    // //     if (onValidateVal.isEmpty) {
                    // //       return 'Username cant\'t be empty.';
                    // //     }
                    // //     return null;
                    // //   },
                    // //   (onSavedVal) {
                    // //     username = onSavedVal;
                    // //   },
                    // //   paddingLeft: 0,
                    // //   paddingRight: 0,
                    // //   borderFocusColor: kSecBlue.withOpacity(0.2),
                    // //   borderColor: Colors.white,
                    // //   prefixIconColor: Color(0xff7B6F72),
                    // //   textColor: Colors.red,
                    // //   borderRadius: 15,
                    // //   hintFontSize: 15,
                    // //   showPrefixIcon: true,
                    // //   prefixIcon: Icon(Icons.email_outlined),
                    // //   backgroundColor: Color(0xffF7F8F8),
                    // //   hintColor: const Color(0xff7B6F72).withOpacity(0.5),
                    // // ),
                    // // Padding(
                    // //   padding: const EdgeInsets.only(top: 15.0),
                    // //   child: FormHelper.inputFieldWidget(
                    // //     context,
                    // //     "password",
                    // //     "Password",
                    // //     (onValidateVal) {
                    // //       if (onValidateVal.isEmpty) {
                    // //         return 'Password cant\'t be empty.';
                    // //       }
                    // //       return null;
                    // //     },
                    // //     (onSavedVal) {
                    // //       password = onSavedVal;
                    // //     },
                    // //     paddingLeft: 0,
                    // //     paddingRight: 0,
                    // //     borderFocusColor: kSecBlue.withOpacity(0.2),
                    // //     borderColor: Colors.white,
                    // //     prefixIconColor: Color(0xff7B6F72),
                    // //     textColor: Colors.red,
                    // //     borderRadius: 15,
                    // //     hintFontSize: 15,
                    // //     showPrefixIcon: true,
                    // //     prefixIcon: Icon(Icons.lock_outline),
                    // //     backgroundColor: Color(0xffF7F8F8),
                    // //     hintColor: const Color(0xff7B6F72).withOpacity(0.5),
                    // //     obscureText: passwordVisible,
                    // //     suffixIcon: IconButton(
                    // //       color: const Color(0xff7B6F72),
                    // //       splashRadius: 1,
                    // //       onPressed: togglePassword,
                    // //       icon: Icon(
                    // //         passwordVisible
                    // //             ? Icons.visibility_outlined
                    // //             : Icons.visibility_off_outlined,
                    // //       ),
                    // //     ),
                    // //   ),
                    // // ),




                    //  Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 25.0),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       gradient: LinearGradient(
                    //         begin: Alignment.topLeft,
                    //         end: Alignment.bottomRight,
                    //         stops: [0.0, 1.0],
                    //         colors: [
                    //           Color(0xFF9DCEFF),
                    //           Color(0XFF92A3FD),
                    //         ],
                    //       ),
                    //       color: Colors.deepPurple.shade300,
                    //       borderRadius: BorderRadius.circular(99),
                    //     ),
                    //     child: FormHelper.submitButton(
                    //       "Login",
                    //       () {
                    //         print(email);
                    //         if (validateAndSave()) {
                    //           setState(() {
                    //             isAPIProcess = true;
                    //           });
                    //           LoginRequestModel model = LoginRequestModel(
                    //               email: email!, password: password!);

                    //           APIService.login(model).then((response) => {
                    //                 setState(() {
                    //                   isAPIProcess = false;
                    //                 }),
                    //                 print("hi2"),
                    //                 if (response)
                    //                   {
                    //                     Navigator.pushAndRemoveUntil(
                    //                         context,
                    //                         MaterialPageRoute(
                    //                             builder: (context) =>
                    //                                 HomePageScreen()),
                    //                         (route) => false)
                    //                   }
                    //                 else
                    //                   {
                    //                     FormHelper.showSimpleAlertDialog(
                    //                         context,
                    //                         Config.appName,
                    //                         "Invalid Username/Password !",
                    //                         "OK", () {
                    //                       Navigator.pop(context);
                    //                     })
                    //                   }
                    //               });
                    //         }
                    //       },
                    //       btnColor: Colors.transparent,
                    //       borderColor: Colors.transparent,
                    //       borderRadius: 99,
                    //       width: double.infinity,
                    //       height: 60,
                    //     ),
