import "package:fitnessapp/common/color_extension.dart";
import "package:fitnessapp/common_widget/round_button.dart";
import "package:fitnessapp/screens/login/welcome_view.dart";
import "package:flutter/material.dart";
import 'package:carousel_slider/carousel_slider.dart';

class WhatYourGoalView extends StatefulWidget {
  const WhatYourGoalView({super.key});

  @override
  State<WhatYourGoalView> createState() => _WhatYourGoalViewState();
}

class _WhatYourGoalViewState extends State<WhatYourGoalView> {
  CarouselController buttonCarouselController = CarouselController();

  List goalArr = [
    {
      "image": "assets/images/goal_1.png",
      "title": "Improve Shape",
      "subtitle":
          "Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit.\nUt fermentum ultricies convallis"
    },
    {
      "image": "assets/images/goal_2.png",
      "title": "Lean and Tone",
      "subtitle":
          "Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit.\nUt fermentum ultricies convallis"
    },
    {
      "image": "assets/images/goal_3.png",
      "title": "Lose a fat",
      "subtitle":
          "Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit.\nUt fermentum ultricies convallis"
    },
  ];
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Tcolor.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: CarouselSlider(
                items: goalArr
                    .map(
                      (gObj) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: Tcolor.primaryG,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: media.width * 0.1, horizontal: 25),
                        alignment: Alignment.center,
                        child: FittedBox(
                          child: Column(
                            children: [
                              Image.asset(
                                gObj["image"].toString(),
                                width: media.width * 0.5,
                                fit: BoxFit.fitWidth,
                              ),
                              SizedBox(
                                height: media.width * 0.1,
                              ),
                              Text(
                                gObj["title"].toString(),
                                style: TextStyle(
                                    color: Tcolor.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              Container(
                                width: media.width * 0.1,
                                height: 1,
                                color: Tcolor.white,
                              ),
                              SizedBox(
                                height: media.width * 0.02,
                              ),
                              Text(
                                gObj["subtitle"].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Tcolor.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.7,
                  aspectRatio: 0.74,
                  initialPage: 0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              width: media.width,
              child: Column(
                children: [
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  Text(
                    "What is your goal ?",
                    style: TextStyle(
                        color: Tcolor.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "It will help us to choose the best\nprogram for you",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Tcolor.grey, fontSize: 12),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  RoundButton(
                    title: "Confirm",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const WelcomeView()),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
