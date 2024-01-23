import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:fitnessapp/common/color_extension.dart";
import "package:fitnessapp/common_widget/round_button.dart";
import "package:fitnessapp/common_widget/round_textField.dart";
import "package:fitnessapp/screens/login/what_goal_view.dart";
import "package:flutter/material.dart";

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  TextEditingController _genderController = TextEditingController();
  TextEditingController _birthController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  bool isLoading = false;
  List<String> genderOptions = ["Male", "Female"];
  String? selectedGender;

  void submit() async {
    // Check if the user is authenticated
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is authenticated
      String userId = user.uid;

      // Add the information to the Firestore document
      try {
        setState(() {
          isLoading = true;
        });
        // Create a reference to the collection "users" in Firestore
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('users');

        // Update the user document with the new information
        await usersCollection.doc(userId).update({
          'gender': _genderController.text,
          'birthDate': _birthController.text,
          'weight': _weightController.text,
          'height': _heightController.text,
        });

        setState(() {
          isLoading = false;
        });

        // Navigate to the next screen (replace this with your actual navigation logic)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const WhatYourGoalView()),
          ),
        );
      } catch (e) {
        print("Error updating user document: $e");
        // Handle error, show a message to the user, etc.
      }
    } else {
      // User is not authenticated
      print("User not authenticated");
      // Handle accordingly, show an error message, ask the user to log in, etc.
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _birthController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Tcolor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/complete_profile.png",
                  width: media.width,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Text(
                  "Let's complete your profile",
                  style: TextStyle(
                      color: Tcolor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "It will help us to know more about you !",
                  style: TextStyle(color: Tcolor.grey, fontSize: 12),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Tcolor.ligthGrey,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 50,
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Image.asset(
                                "assets/images/gender.png",
                                width: 20,
                                height: 20,
                                fit: BoxFit.contain,
                                color: Tcolor.grey,
                              ),
                            ),
                            Expanded(
                                child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                items: genderOptions
                                    .map(
                                      (name) => DropdownMenuItem(
                                        value: name,
                                        child: Text(
                                          name,
                                          style: TextStyle(
                                              color: Tcolor.grey, fontSize: 14),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value;
                                    _genderController.text = value
                                        .toString(); // Update _genderController
                                  });
                                },
                                isExpanded: true,
                                hint: Text(
                                  "Choose Gender",
                                  style: TextStyle(
                                      color: Tcolor.grey, fontSize: 12),
                                ),
                                value: selectedGender,
                              ),
                            )),
                            const SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: RoundTextField(
                            controller: _birthController,
                            hitText: "Date of birth",
                            icon: "assets/images/date.png",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RoundTextField(
                              controller: _weightController,
                              hitText: "Your Weight",
                              icon: "assets/images/weight.png",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient:
                                  LinearGradient(colors: Tcolor.secondaryG),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "KG",
                              style:
                                  TextStyle(color: Tcolor.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.07,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RoundTextField(
                              controller: _heightController,
                              hitText: "Your Height",
                              icon: "assets/images/hight.png",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient:
                                  LinearGradient(colors: Tcolor.secondaryG),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "CM",
                              style:
                                  TextStyle(color: Tcolor.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      RoundButton(
                          title: "Next >",
                          onPressed: () {
                            isLoading = true;
                            submit();
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: ((context) =>
                            //         const WhatYourGoalView()),
                            //   ),
                            // );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
