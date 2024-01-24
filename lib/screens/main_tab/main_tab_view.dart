import 'package:fitnessapp/common_widget/tab_button.dart';
import "package:flutter/material.dart";
import 'package:fitnessapp/common/color_extension.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 65,
        height: 65,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: Tcolor.primaryG),
              borderRadius: BorderRadius.circular(32.5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                ),
              ],
            ),
            child: const Icon(
              Icons.search,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(color: Tcolor.white, boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 2, offset: Offset(0, -2))
          ]),
          height: kToolbarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabButton(
                  icon: "assets/images/home_tab.png",
                  selectIcon: "assets/images/home_tab_select.png",
                  onTap: () {
                    selectTab = 0;
                    if (mounted) {
                      setState(
                        () {},
                      );
                    }
                  },
                  isActive: selectTab == 0),
              TabButton(
                  icon: "assets/images/activity_tab.png",
                  selectIcon: "assets/images/activity_tab_select.png",
                  onTap: () {
                    selectTab = 1;
                    if (mounted) {
                      setState(
                        () {},
                      );
                    }
                  },
                  isActive: selectTab == 1),
              const SizedBox(
                width: 40,
              ),
              TabButton(
                  icon: "assets/images/camera_tab.png",
                  selectIcon: "assets/images/camera_tab_select.png",
                  onTap: () {
                    selectTab = 2;
                    if (mounted) {
                      setState(
                        () {},
                      );
                    }
                  },
                  isActive: selectTab == 2),
              TabButton(
                  icon: "assets/images/profile_tab.png",
                  selectIcon: "assets/images/profile_tab_select.png",
                  onTap: () {
                    selectTab = 3;
                    if (mounted) {
                      setState(
                        () {},
                      );
                    }
                  },
                  isActive: selectTab == 3),
            ],
          ),
        ),
      ),
    );
  }
}
