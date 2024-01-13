import "package:fitnessapp/common/color_extension.dart";
import "package:fitnessapp/common_widget/round_button.dart";
import "package:fitnessapp/common_widget/round_textField.dart";
import "package:flutter/material.dart";

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool isCheck = false;
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
                  height: media.width * 0.4,
                ),
                RoundButton(title: "Register", onPressed: () {}),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Tcolor.white,
                          border: Border.all(
                            width: 1,
                            color: Tcolor.grey.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Image.asset(
                          'assets/images/google.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: media.width * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Tcolor.white,
                          border: Border.all(
                            width: 1,
                            color: Tcolor.grey.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Image.asset(
                          'assets/images/facebook.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                TextButton(
                  onPressed: () {},
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
