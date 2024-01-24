import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/common/color_extension.dart';
import 'package:fitnessapp/common_widget/round_button.dart';
import 'package:fitnessapp/screens/home/home_view.dart';
import 'package:fitnessapp/screens/main_tab/main_tab_view.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  String userName = ""; // Variable to store the user's first name

  @override
  void initState() {
    super.initState();

    // Call the userName function when the WelcomeView is initialized
    getUserName();
  }

  Future<void> getUserName() async {
    // Check if the user is authenticated
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is authenticated
      String userId = user.uid;

      try {
        // Access the user document in the "users" collection
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        // Retrieve the user's first name
        String firstName = userSnapshot['prenoms'];

        // Update the state variable to store the user's first name
        setState(() {
          userName = firstName;
        });
      } catch (e) {
        print("Error retrieving user information: $e");
        // Handle error, show a message to the user, etc.
        setState(() {
          userName = "John";
        });
      }
    } else {
      // User is not authenticated
      print("User not authenticated");
      // Handle accordingly, show an error message, ask the user to log in, etc.
      setState(() {
        userName = "John";
      });
    }
  }

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
                width: media.width * 0.75,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(
                height: media.width * 0.1,
              ),
              Text(
                "Welcome $userName",
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const MainTabView()),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
