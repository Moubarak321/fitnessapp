import "package:fitnessapp/common/color_extension.dart";
import "package:fitnessapp/common_widget/on_boarding_page.dart";
import "package:fitnessapp/screens/login/signup_view.dart";
import "package:flutter/material.dart";

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int selectPage = 0;
  PageController controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      selectPage = controller.page?.round() ?? 0;
    });
    setState(() {});
  }

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
    // var media = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Tcolor.white,
        body: Stack(
          alignment: Alignment.bottomRight,
          children: [
            PageView.builder(
                controller: controller,
                itemCount: pageList.length,
                itemBuilder: (context, index) {
                  var pObj = pageList[index] as Map? ?? {};
                  return OnBoardingPage(pObj: pObj);
                }),
            SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(
                      color: Tcolor.primaryColor1,
                      value: (selectPage + 1) / 4,
                      strokeWidth: 2,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 25),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Tcolor.primaryColor1,
                          borderRadius: BorderRadius.circular(35)),
                      child: IconButton(
                        icon: Icon(
                          Icons.navigate_next,
                          color: Tcolor.white,
                        ),
                        onPressed: () {
                          if (selectPage < 3) {
                            // if (pageList.length <= selectPage -1) {
                            // open welcome screen
                            selectPage = selectPage + 1;
                            controller.animateToPage(selectPage,
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeInExpo);
                            // controller.jumpToPage(selectPage);
                            setState(() {});
                          } else {
                            // print("open welcome project");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupView()),
                            );
                          }
                        },
                      )),
                ],
              ),
            )
          ],
        ));
  }
}
