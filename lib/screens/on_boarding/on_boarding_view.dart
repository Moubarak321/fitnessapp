import "package:fitnessapp/common/color_extension.dart";
import "package:flutter/material.dart";

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Tcolor.white,
        body: Stack(
          children: [
            PageView.builder(
                controller: controller,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: media.width,
                    height: media.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("assets/images/on_1.png", width: media.width, fit: BoxFit.fitWidth,),

                        SizedBox(height: media.width *0.1,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Track your Goal", style: TextStyle(color: Tcolor.black, fontSize: 24, fontWeight: FontWeight.w700),),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut fermentum ultricies convallis. Duis tincidunt, sem eu fermentum faucibus, mauris erat elementum sapien, sed rhoncus augue elit a diam. In eu nisi at lectus interdum fermentum. ", style: TextStyle(color: Tcolor.grey, fontSize: 14,),),
                        )
                      ],
                    ),
                  );
                })
          ],
        ));
  }
}
