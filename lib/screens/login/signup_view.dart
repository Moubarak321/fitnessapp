import "package:firebase_auth/firebase_auth.dart";
import "package:fitnessapp/common/color_extension.dart";
import "package:fitnessapp/common_widget/round_button.dart";
import "package:fitnessapp/common_widget/round_textField.dart";
import "package:fitnessapp/screens/login/complete_profile_view.dart";
import "package:fitnessapp/screens/login/function.dart";
import "package:fitnessapp/screens/login/login_view.dart";
import "package:fitnessapp/screens/login/otp.dart";
import "package:flutter/material.dart";
import 'package:intl_phone_field/intl_phone_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool isCheck = false;
  bool loading = false;
  String phoneNumber = '';
  String countryCode = '';
  final TextEditingController _phoneNumberController = TextEditingController();

  void sendOtpCode() {
    loading = true;
    setState(() {});
    final _auth = FirebaseAuth.instance;
    if (phoneNumber.isNotEmpty) {
      authWithPhoneNumber(phoneNumber, onCodeSend: (verificationId, v) {
        loading = false;
        setState(() {});
        Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => VerificationOtp(
                  verificationId: verificationId,
                  phoneNumber: phoneNumber,
                )));
      }, onAutoVerify: (v) async {
        await _auth.signInWithCredential(v);
        Navigator.of(context).pop();
      }, onFailed: (e) {
        loading = false;
        setState(() {});
        print("Le code est erroné");
      }, autoRetrieval: (v) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Tcolor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Hey there",
                  style: TextStyle(color: Tcolor.grey, fontSize: 16),
                ),
                Text(
                  "Create an Account",
                  style: TextStyle(
                      color: Tcolor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                const RoundTextField(
                  hitText: "First Name",
                  icon: "assets/images/user_text.png",
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                const RoundTextField(
                  hitText: "Last Name",
                  icon: "assets/images/user_text.png",
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                // const RoundTextField(
                //     hitText: "Email",
                //     icon: "assets/images/email.png",
                //     keyboardType: TextInputType.emailAddress),
                // SizedBox(
                //   height: media.width * 0.04,
                // ),
                IntlPhoneField(
                  controller: _phoneNumberController,
                  flagsButtonPadding: const EdgeInsets.all(1),
                  dropdownIconPosition: IconPosition.trailing,
                  initialCountryCode: 'BJ',
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    labelText: 'Numéro de téléphone',
                    labelStyle: TextStyle(color: Tcolor.ligthGrey),
                    filled: true,
                    fillColor: Tcolor.ligthGrey,
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onChanged: (value) {
                    phoneNumber = value.completeNumber;
                  },
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Tcolor.grey, fontSize: 12),
                  // Vous pouvez également ajuster d'autres propriétés comme icon, rightIcon, etc.
                ),

                // SizedBox(
                //   height: media.width * 0.04,
                // ),
                // RoundTextField(
                //   hitText: "Password",
                //   icon: "assets/images/lock.png",
                //   keyboardType: TextInputType.emailAddress,
                //   obscureText: true,
                //   rightIcon: TextButton(
                //     onPressed: () {},
                //     child: Container(
                //       alignment: Alignment.center,
                //       width: 20,
                //       height: 20,
                //       child: Image.asset(
                //         "assets/images/show_password.png",
                //         width: 20,
                //         height: 20,
                //         fit: BoxFit.contain,
                //         color: Tcolor.grey,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isCheck = !isCheck;
                        });
                      },
                      icon: Icon(
                          isCheck
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank_outlined,
                          color: Tcolor.grey,
                          size: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "By continuing, you accept our Privacy and\nTerm of Uses",
                        style: TextStyle(color: Tcolor.grey, fontSize: 10),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: media.width * 0.3,
                ),
                RoundButton(
                    title: "Register",
                    onPressed: () {
                      sendOtpCode();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: ((context) => const CompleteProfileView()),
                      //   ),
                      // );
                    }),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Tcolor.grey.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      " Or ",
                      style: TextStyle(color: Tcolor.grey, fontSize: 12),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Tcolor.grey.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () {},
                //       child: Container(
                //         width: 50,
                //         height: 50,
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           color: Tcolor.white,
                //           border: Border.all(
                //             width: 1,
                //             color: Tcolor.grey.withOpacity(0.4),
                //           ),
                //           borderRadius: BorderRadius.circular(25),
                //         ),
                //         child: Image.asset(
                //           'assets/images/google.png',
                //           width: 20,
                //           height: 20,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: media.width * 0.04,
                //     ),
                //     GestureDetector(
                //       onTap: () {},
                //       child: Container(
                //         width: 50,
                //         height: 50,
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           color: Tcolor.white,
                //           border: Border.all(
                //             width: 1,
                //             color: Tcolor.grey.withOpacity(0.4),
                //           ),
                //           borderRadius: BorderRadius.circular(25),
                //         ),
                //         child: Image.asset(
                //           'assets/images/facebook.png',
                //           width: 20,
                //           height: 20,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const LoginView()),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Already have an account ?",
                        style: TextStyle(
                          color: Tcolor.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                            color: Tcolor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
