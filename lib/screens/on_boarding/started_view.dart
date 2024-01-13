import "package:fitnessapp/common/color_extension.dart";
import "package:fitnessapp/common_widget/round_button.dart";
import "package:fitnessapp/screens/on_boarding/on_boarding_view.dart";
import "package:flutter/material.dart";

class StartedView extends StatefulWidget {
  const StartedView({super.key});

  @override
  State<StartedView> createState() => _StartedViewState();
}

class _StartedViewState extends State<StartedView> {
  bool isChangedColor = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Tcolor.white,
      body: Container(
          width: media.width,
          decoration: BoxDecoration(
            gradient: isChangedColor
                ? LinearGradient(
                    colors: Tcolor.primaryG,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "Fitness",
                style: TextStyle(
                    color: Tcolor.black,
                    fontSize: 36,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "Everybody Can Train",
                style: TextStyle(
                  color: Tcolor.grey,
                  fontSize: 18,
                  // fontWeight: FontWeight.w700
                ),
              ),
              const Spacer(),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: RoundButton(
                      title: "Get Started",
                      type: isChangedColor
                          ? RoundButtonType.textGradient
                          : RoundButtonType.bgGradient,
                      onPressed: () {
                        if (isChangedColor) {
                          //go next screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OnboardingView()),
                          );
                        } else {
                          //change color
                          setState(() {
                            isChangedColor = true;
                          });
                        }
                      }),
                ),
              ),
            ],
          )),
    );
  }
}
