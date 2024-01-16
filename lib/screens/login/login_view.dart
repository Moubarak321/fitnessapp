import "package:fitnessapp/common/color_extension.dart";
import "package:fitnessapp/common_widget/round_button.dart";
import "package:fitnessapp/common_widget/round_textField.dart";
// import "package:fitnessapp/screens/login/complete_profile_view.dart";
// import "package:fitnessapp/screens/login/signup_view.dart";
import "package:flutter/material.dart";

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Tcolor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: media.height,
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
                  "Welcome Back !!!",
                  style: TextStyle(
                      color: Tcolor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),

                // SizedBox(
                //   height: media.width * 0.04,
                // ),
                const RoundTextField(
                    hitText: "Email",
                    icon: "assets/images/email.png",
                    keyboardType: TextInputType.emailAddress),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  hitText: "Password",
                  icon: "assets/images/lock.png",
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  rightIcon: TextButton(
                    onPressed: () {},
                    child: Container(
                      alignment: Alignment.center,
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "assets/images/show_password.png",
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                        color: Tcolor.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // IconButton(
                    //   onPressed: () {
                    //     setState(() {
                    //       isCheck = !isCheck;
                    //     });
                    //   },
                    //   icon: Icon(
                    //       isCheck
                    //           ? Icons.check_box_outlined
                    //           : Icons.check_box_outline_blank_outlined,
                    //       color: Tcolor.grey,
                    //       size: 20),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Forgot your password ?",
                        style: TextStyle(
                            color: Tcolor.grey,
                            fontSize: 10,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                // const Spacer(),
                SizedBox(
                  height: media.width * 0.8,
                ),
                RoundButton(
                    title: "Login",
                    onPressed: () {
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
                // SizedBox(
                //   height: media.width * 0.04,
                // ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an account yet ?",
                        style: TextStyle(
                          color: Tcolor.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Register",
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