import "package:fitnessapp/common/color_extension.dart";
import "package:fitnessapp/common_widget/on_boarding_page.dart";
import "package:flutter/material.dart";

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController controller = PageController();

  List pageList = [
    {
      "title": "Track your Goal",
      "subtitle":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut fermentum ultricies convallis. Duis tincidunt, sem eu fermentum faucibus, mauris erat elementum sapien, sed rhoncus augue elit a diam. In eu nisi at lectus interdum fermentum. ",
      "image": "assets/images/on_1.png"
    },
    {
      "title": "Get Burn",
      "subtitle":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut fermentum ultricies convallis. Duis tincidunt, sem eu fermentum faucibus, mauris erat elementum sapien, sed rhoncus augue elit a diam. In eu nisi at lectus interdum fermentum. ",
      "image": "assets/images/on_2.png"
    },
    {
      "title": "Eate well",
      "subtitle":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut fermentum ultricies convallis. Duis tincidunt, sem eu fermentum faucibus, mauris erat elementum sapien, sed rhoncus augue elit a diam. In eu nisi at lectus interdum fermentum. ",
      "image": "assets/images/on_3.png"
    },
    {
      "title": "Improve skills",
      "subtitle":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut fermentum ultricies convallis. Duis tincidunt, sem eu fermentum faucibus, mauris erat elementum sapien, sed rhoncus augue elit a diam. In eu nisi at lectus interdum fermentum. ",
      "image": "assets/images/on_4.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Tcolor.white,
        body: Stack(
          children: [
            PageView.builder(
                controller: controller,
                itemCount: pageList.length,
                itemBuilder: (context, index) {
                  var pObj = pageList[index] as Map? ?? {};
                  return OnBoardingPage(pObj: pObj);
                })
          ],
        ));
  }
}
