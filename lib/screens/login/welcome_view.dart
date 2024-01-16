import "package:fitnessapp/common/color_extension.dart";
import "package:fitnessapp/common_widget/round_button.dart";
import "package:flutter/material.dart";

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Tcolor.white,
      body: SafeArea(
        child: Container(
          width: media.width,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,

            children: [
              SizedBox(
                height: media.width * 0.1,
              ),
              Image.asset(
                "assets/images/welcome.png",
                width: media.width*0.75,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(
                height: media.width * 0.1,
              ),
              Text(
                "Welcome John",
                style: TextStyle(
                    color: Tcolor.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "You are all set now, Let's reach your\ngoals together with us",
                textAlign: TextAlign.center,
                style: TextStyle(color: Tcolor.grey, fontSize: 12),
              ),
             const Spacer(),

              RoundButton(
                    title: "Go to Home",
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: ((context) => const WelcomeView()),
                      //   ),
                      // );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
