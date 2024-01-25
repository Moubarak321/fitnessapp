import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitnessapp/common/color_extension.dart';
import 'package:fitnessapp/common_widget/round_button.dart';
import 'package:fitnessapp/common_widget/round_textField.dart';
import 'package:fitnessapp/screens/home/home_view.dart';
import 'package:fitnessapp/screens/login/complete_profile_view.dart';
import 'package:fitnessapp/screens/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:get/get.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class MyFirebaseMessaging {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getFCMToken() async {
    String? token;

    try {
      token = await _firebaseMessaging.getToken();
    } catch (e) {
      //  print('Erreur lors de la récupération du token FCM ');
    }
    print('token ======${token!}');
    return token;
  }
}

class _SignupViewState extends State<SignupView> {
  bool isCheck = false;
  bool loading = false;
  String phoneNumber = '';
  String countryCode = '';
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  bool _isPasswordValid(String value) {
    if (value.length < 6) {
      setState(() {});
      return false;
    } else {
      setState(() {});
      return true;
    }
  }

  bool _isEmailValid(String value) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(value);
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final phoneNumber = _phoneNumberController.text;
      final lastName = _lastNameController.text;
      final firstName = _firstNameController.text;

      try {
        setState(() {
          _isSubmitting = true; // Afficher l'indicateur de chargement
        });

        // Créez un utilisateur Firebase Auth
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        print("=================${userCredential.user!.uid}");
        print(
            "==================================user created auth==================================");

        // Si l'utilisateur Firebase Auth est créé avec succès, enregistrez les données dans Firebase Firestore
        if (userCredential.user != null) {
          String userId = userCredential.user!.uid;
          print(
              "==================================ajout base et crea firestore==================================");

          // Créez une référence à la collection "users" dans Firestore
          CollectionReference usersCollection =
              FirebaseFirestore.instance.collection('users');
          print(usersCollection);

          // Enregistrez l'utilisateur dans Firestore avec l'e-mail, le mot de passe et le numéro de téléphone
          await usersCollection.doc(userId).set({
            'noms': lastName,
            'prenoms': firstName,
            'phoneNumber': "229$phoneNumber",
            'role': "Utilisateur",
            // 'fcmToken': fcmToken,
          });

          // Sign in the user with the created credentials
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          print("Utilisateur enregistré dans Firebase Firestore avec succès.");
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const CompleteProfileView()),
            ),
          );
        } else {
          print("L'utilisateur Firebase Auth n'a pas été créé avec succès.");
          Get.snackbar(
            "Erreur",
            "User non créé",
          );
        }
      } catch (e) {
        // Gérez les erreurs d'inscription ici
        print("Erreur d'inscription : $e");
        setState(() {
          _isSubmitting = false; // Mettre fin à l'indicateur de chargement
        });
      }
    }
  }

// handlesubmit avec autorisation firebase messaging
  // void _handleSubmit() async {
  //   if (_formKey.currentState!.validate()) {
  //     final email = _emailController.text;
  //     final password = _passwordController.text;
  //     final phoneNumber = _phoneNumberController.text;
  //     final lastName = _lastNameController.text;
  //     final firstName = _firstNameController.text;
  //     print("phone ======${phoneNumber}");
  //     print("last ======${lastName}");
  //     print("firstName ======${firstName}");
  //     // Obtenez la permission de notification
  //     NotificationSettings settings =
  //         await FirebaseMessaging.instance.requestPermission(
  //       alert: true,
  //       announcement: false,
  //       badge: true,
  //       criticalAlert: true,
  //       provisional: false,
  //       sound: true,
  //     );
  //     //// Utilisez le contrôleur _phoneNumberController

  //     try {
  //       setState(() {
  //         _isSubmitting = true; // Afficher l'indicateur de chargement
  //       });
  //       // Créez un utilisateur Firebase Auth
  //       UserCredential userCredential =
  //           await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );
  //       print(userCredential.user);
  //       print("=================${userCredential.user!.uid}");
  //       print(
  //           "==================================user created auth==================================");
  //       // Si l'utilisateur Firebase Auth est créé avec succès, enregistrez les données dans Firebase Firestore
  //       if (userCredential.user != null) {
  //         String userId = userCredential.user!.uid;
  //         print(userId);
  //         print(
  //             "==================================ajout base et crea firestore==================================");
  //         Get.snackbar("Ok", "User créé");

  //         // Créez une référence à la collection "users" dans Firestore
  //         CollectionReference usersCollection =
  //             FirebaseFirestore.instance.collection('users');
  //         print(usersCollection);
  //         if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //           // Si l'autorisation est accordée, obtenez le token FCM
  //           String? fcmToken = await MyFirebaseMessaging().getFCMToken();
  //           print('token ======${fcmToken!}');

  //           // Enregistrez l'utilisateur dans Firestore avec l'e-mail, le mot de passe et le numéro de téléphone
  //           await usersCollection.doc(userId).set({
  //             'noms': lastName,
  //             'prenoms': firstName,
  //             'phoneNumber': "229$phoneNumber",
  //             'role': "Utilisateur",
  //             'fcmToken': fcmToken,
  //           });
  //         } else {
  //           // Gestion si l'autorisation est refusée ou bloquée
  //           await usersCollection.doc(userId).set({
  //             'noms': lastName,
  //             'prenoms': firstName,
  //             'phoneNumber': "229$phoneNumber",
  //             'role': "Utilisateur",
  //           });
  //           _showErrorDialog(
  //               'Veuillez autoriser les notifications pour utiliser cette application.');
  //           Get.snackbar("infos", "Autorisez les notfs");
  //         }
  //         print("Utilisateur enregistré dans Firebase Firestore avec succès.");
  //         // ignore: use_build_context_synchronously
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: ((context) => const CompleteProfileView()),
  //           ),
  //         );
  //       } else {
  //         print("L'utilisateur Firebase Auth n'a pas été créé avec succès.");
  //       }
  //     } catch (e) {
  //       // Gérez les erreurs d'inscription ici
  //       // print("Erreur d'inscription : $e");
  //       setState(() {
  //         _isSubmitting = false; // Mettre fin à l'indicateur de chargement
  //       });
  //     }
  //   }
  // }

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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: media.width * 0.1,
                  ),
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
                  RoundTextField(
                    hitText: "First Name",
                    icon: "assets/images/user_text.png",
                    controller: _firstNameController,
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  RoundTextField(
                    hitText: "Last Name",
                    icon: "assets/images/user_text.png",
                    controller: _lastNameController,
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  RoundTextField(
                    hitText: "Email",
                    icon: "assets/images/email.png",
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) {
                      if (!_isEmailValid(value ?? '')) {
                        return 'Entrez une adresse e-mail valide';
                      }
                      print(_emailController.text);
                      return null;
                    },
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  RoundTextField(
                    hitText: "Password",
                    icon: "assets/images/lock.png",
                    controller: _passwordController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    validator: (value) {
                      if (!_isPasswordValid(value ?? '')) {
                        return 'Le mot de passe doit contenir au moins 6 caractères.';
                      }
                      return null;
                    },
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
                  IntlPhoneField(
                    controller: _phoneNumberController,
                    flagsButtonPadding: const EdgeInsets.all(1),
                    dropdownIconPosition: IconPosition.trailing,
                    initialCountryCode: 'BJ',
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      labelText: 'Numéro de téléphone',
                      labelStyle: TextStyle(color: Tcolor.ligthGrey),
                      filled: true,
                      fillColor: Tcolor.ligthGrey,
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onChanged: (value) {
                      phoneNumber = value.completeNumber;
                    },
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Tcolor.grey, fontSize: 12),
                    // Vous pouvez également ajuster d'autres propriétés comme icon, rightIcon, etc.
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
                    height: media.width * 0.04,
                  ),
                  RoundButton(
                    title: "Register",
                    onPressed: () {
                       if (_formKey.currentState?.validate() ?? false) {
                         _handleSubmit();
                       }
                     },

                   // onPressed: _isSubmitting ? null : () => _handleSubmit(),
                  ),
                  if (_isSubmitting)
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                  if (_isSubmitting)
                    const CircularProgressIndicator(), // Indicateur de chargement

                  // SizedBox(
                  //   height: media.width * 0.04,
                  // ),
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
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const LoginView()),
                        ),
                      );
                    },
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
      ),
    );
  }
}


































































































































































//========================= fonctionne ===================
// import "package:firebase_auth/firebase_auth.dart";
// import "package:fitnessapp/common/color_extension.dart";
// import "package:fitnessapp/common_widget/round_button.dart";
// import "package:fitnessapp/common_widget/round_textField.dart";
// // import "package:fitnessapp/screens/login/complete_profile_view.dart";
// import 'package:firebase_messaging/firebase_messaging.dart';
// import "package:fitnessapp/screens/login/login_view.dart";
// // import "package:fitnessapp/screens/login/otp.dart";
// import "package:flutter/material.dart";
// import 'package:intl_phone_field/intl_phone_field.dart';

// class SignupView extends StatefulWidget {
//   const SignupView({super.key});

//   @override
//   State<SignupView> createState() => _SignupViewState();
// }

// class MyFirebaseMessaging {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   Future<String?> getFCMToken() async {
//     String? token;

//     try {
//       token = await _firebaseMessaging.getToken();
//     } catch (e) {
//       //  print('Erreur lors de la récupération du token FCM ');
//     }

//     return token;
//   }
// }

// class _SignupViewState extends State<SignupView> {
//   bool isCheck = false;
//   bool loading = false;
//   String phoneNumber = '';
//   String countryCode = '';
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   String? _passwordErrorText;


// bool _isPasswordValid(String value) {
//     if (value.length < 6) {
//       setState(() {
//         _passwordErrorText =
//             "Le mot de passe doit contenir au moins 6 caractères.";
//       });
//       return false;
//     } else {
//       setState(() {
//         _passwordErrorText = null;
//       });
//       return true;
//     }
//   }

// bool isEmailValid(String email) {
//   final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
//   return emailRegex.hasMatch(email);
// }



  

//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Tcolor.white,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 20,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   "Hey there",
//                   style: TextStyle(color: Tcolor.grey, fontSize: 16),
//                 ),
//                 Text(
//                   "Create an Account",
//                   style: TextStyle(
//                       color: Tcolor.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700),
//                 ),
//                 SizedBox(
//                   height: media.width * 0.05,
//                 ),
//                  RoundTextField(
//                   hitText: "First Name",
//                   icon: "assets/images/user_text.png",
//                   controller: _firstNameController,
//                 ),
//                 SizedBox(
//                   height: media.width * 0.04,
//                 ),
//                  RoundTextField(
//                   hitText: "Last Name",
//                   icon: "assets/images/user_text.png",
//                   controller: _lastNameController,

//                 ),
//                 SizedBox(
//                   height: media.width * 0.04,
//                 ),
//                  RoundTextField(
//                     hitText: "Email",
//                     icon: "assets/images/email.png",
//                     keyboardType: TextInputType.emailAddress,
//                   controller: _emailController,

//                   ),
//                 SizedBox(
//                   height: media.width * 0.04,
//                 ),

//                 // SizedBox(
//                 //   height: media.width * 0.04,
//                 // ),
//                 RoundTextField(
//                   hitText: "Password",
//                   icon: "assets/images/lock.png",
//                   controller: _passwordController,
//                   keyboardType: TextInputType.emailAddress,
//                   obscureText: true,
//                   rightIcon: TextButton(
//                     onPressed: () {},
//                     child: Container(
//                       alignment: Alignment.center,
//                       width: 20,
//                       height: 20,
//                       child: Image.asset(
//                         "assets/images/show_password.png",
//                         width: 20,
//                         height: 20,
//                         fit: BoxFit.contain,
//                         color: Tcolor.grey,
//                       ),
//                     ),
//                   ),
                  
//                 ),
//                 SizedBox(
//                   height: media.width * 0.04,
//                 ),
//                 IntlPhoneField(
//                   controller: _phoneNumberController,
//                   flagsButtonPadding: const EdgeInsets.all(1),
//                   dropdownIconPosition: IconPosition.trailing,
//                   initialCountryCode: 'BJ',
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 15),
//                     labelText: 'Numéro de téléphone',
//                     labelStyle: TextStyle(color: Tcolor.ligthGrey),
//                     filled: true,
//                     fillColor: Tcolor.ligthGrey,
//                     alignLabelWithHint: true,
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     phoneNumber = value.completeNumber;
//                   },
//                   keyboardType: TextInputType.number,
//                   style: TextStyle(color: Tcolor.grey, fontSize: 12),
//                   // Vous pouvez également ajuster d'autres propriétés comme icon, rightIcon, etc.
//                 ),
//                 SizedBox(
//                   height: media.width * 0.04,
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         setState(() {
//                           isCheck = !isCheck;
//                         });
//                       },
//                       icon: Icon(
//                           isCheck
//                               ? Icons.check_box_outlined
//                               : Icons.check_box_outline_blank_outlined,
//                           color: Tcolor.grey,
//                           size: 20),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Text(
//                         "By continuing, you accept our Privacy and\nTerm of Uses",
//                         style: TextStyle(color: Tcolor.grey, fontSize: 10),
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: media.width * 0.3,
//                 ),
//                 RoundButton(
//                     title: "Register",
//                     onPressed: () {
//                       // sendOtpCode();
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: ((context) => const CompleteProfileView()),
//                       //   ),
//                       // );
//                     }),
//                 SizedBox(
//                   height: media.width * 0.04,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 1,
//                         color: Tcolor.grey.withOpacity(0.5),
//                       ),
//                     ),
//                     Text(
//                       " Or ",
//                       style: TextStyle(color: Tcolor.grey, fontSize: 12),
//                     ),
//                     Expanded(
//                       child: Container(
//                         height: 1,
//                         color: Tcolor.grey.withOpacity(0.5),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // SizedBox(
//                 //   height: media.width * 0.04,
//                 // ),
                
//                 SizedBox(
//                   height: media.width * 0.04,
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: ((context) => const LoginView()),
//                       ),
//                     );
//                   },
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         "Already have an account ?",
//                         style: TextStyle(
//                           color: Tcolor.black,
//                           fontSize: 14,
//                         ),
//                       ),
//                       Text(
//                         "Login",
//                         style: TextStyle(
//                             color: Tcolor.black,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w700),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: media.width * 0.04,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

















































































































































// Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () {},
                //       child: Container(
                //         width: 50,
                //         height: 50,
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           color: Tcolor.white,
                //           border: Border.all(
                //             width: 1,
                //             color: Tcolor.grey.withOpacity(0.4),
                //           ),
                //           borderRadius: BorderRadius.circular(25),
                //         ),
                //         child: Image.asset(
                //           'assets/images/google.png',
                //           width: 20,
                //           height: 20,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: media.width * 0.04,
                //     ),
                //     GestureDetector(
                //       onTap: () {},
                //       child: Container(
                //         width: 50,
                //         height: 50,
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           color: Tcolor.white,
                //           border: Border.all(
                //             width: 1,
                //             color: Tcolor.grey.withOpacity(0.4),
                //           ),
                //           borderRadius: BorderRadius.circular(25),
                //         ),
                //         child: Image.asset(
                //           'assets/images/facebook.png',
                //           width: 20,
                //           height: 20,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),










// ================== verification otp=====================

// import "package:firebase_auth/firebase_auth.dart";
// import "package:fitnessapp/common/color_extension.dart";
// import "package:fitnessapp/common_widget/round_button.dart";
// import "package:fitnessapp/common_widget/round_textField.dart";
// // import "package:fitnessapp/screens/login/complete_profile_view.dart";
// import "package:fitnessapp/screens/login/function.dart";
// import "package:fitnessapp/screens/login/login_view.dart";
// import "package:fitnessapp/screens/login/otp.dart";
// import "package:flutter/material.dart";
// import 'package:intl_phone_field/intl_phone_field.dart';

// class SignupView extends StatefulWidget {
//   const SignupView({super.key});

//   @override
//   State<SignupView> createState() => _SignupViewState();
// }

// class _SignupViewState extends State<SignupView> {
//   bool isCheck = false;
//   bool loading = false;
//   String phoneNumber = '';
//   String countryCode = '';
//   final TextEditingController _phoneNumberController = TextEditingController();

//   void sendOtpCode() {
//     loading = true;
//     setState(() {});
//     final auth = FirebaseAuth.instance;
//     if (phoneNumber.isNotEmpty) {
//       authWithPhoneNumber(phoneNumber, onCodeSend: (verificationId, v) {
//         loading = false;
//         setState(() {});
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => VerificationOtp(
//               verificationId: verificationId,
//               phoneNumber: phoneNumber,
//             ),
//           ),
//         );
//       }, onAutoVerify: (v) async {
//         await auth.signInWithCredential(v);
//         // ignore: use_build_context_synchronously
//         Navigator.of(context).pop();
//       }, onFailed: (e) {
//         loading = false;
//         setState(() {});
//         print("Le code est erroné");
//       }, autoRetrieval: (v) {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Tcolor.white,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 20,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   "Hey there",
//                   style: TextStyle(color: Tcolor.grey, fontSize: 16),
//                 ),
//                 Text(
//                   "Create an Account",
//                   style: TextStyle(
//                       color: Tcolor.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700),
//                 ),
//                 SizedBox(
//                   height: media.width * 0.05,
//                 ),
//                 const RoundTextField(
//                   hitText: "First Name",
//                   icon: "assets/images/user_text.png",
//                 ),
//                 SizedBox(
//                   height: media.width * 0.04,
//                 ),
//                 const RoundTextField(
//                   hitText: "Last Name",
//                   icon: "assets/images/user_text.png",
//                 ),
//                 SizedBox(
//                   height: media.width * 0.04,
//                 ),
//                 // const RoundTextField(
//                 //     hitText: "Email",
//                 //     icon: "assets/images/email.png",
//                 //     keyboardType: TextInputType.emailAddress),
//                 // SizedBox(
//                 //   height: media.width * 0.04,
//                 // ),
//                 IntlPhoneField(
//                   controller: _phoneNumberController,
//                   flagsButtonPadding: const EdgeInsets.all(1),
//                   dropdownIconPosition: IconPosition.trailing,
//                   initialCountryCode: 'BJ',
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 15),
//                     labelText: 'Numéro de téléphone',
//                     labelStyle: TextStyle(color: Tcolor.ligthGrey),
//                     filled: true,
//                     fillColor: Tcolor.ligthGrey,
//                     alignLabelWithHint: true,
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     phoneNumber = value.completeNumber;
//                   },
//                   keyboardType: TextInputType.number,
//                   style: TextStyle(color: Tcolor.grey, fontSize: 12),
//                   // Vous pouvez également ajuster d'autres propriétés comme icon, rightIcon, etc.
//                 ),

               
//                 SizedBox(
//                   height: media.width * 0.04,
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         setState(() {
//                           isCheck = !isCheck;
//                         });
//                       },
//                       icon: Icon(
//                           isCheck
//                               ? Icons.check_box_outlined
//                               : Icons.check_box_outline_blank_outlined,
//                           color: Tcolor.grey,
//                           size: 20),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Text(
//                         "By continuing, you accept our Privacy and\nTerm of Uses",
//                         style: TextStyle(color: Tcolor.grey, fontSize: 10),
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: media.width * 0.3,
//                 ),
//                 RoundButton(
//                     title: "Register",
//                     onPressed: () {
//                       sendOtpCode();
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: ((context) => const CompleteProfileView()),
//                       //   ),
//                       // );
//                     }),
//                 SizedBox(
//                   height: media.width * 0.04,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 1,
//                         color: Tcolor.grey.withOpacity(0.5),
//                       ),
//                     ),
//                     Text(
//                       " Or ",
//                       style: TextStyle(color: Tcolor.grey, fontSize: 12),
//                     ),
//                     Expanded(
//                       child: Container(
//                         height: 1,
//                         color: Tcolor.grey.withOpacity(0.5),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: media.width * 0.04,
//                 ),
               
//                 SizedBox(
//                   height: media.width * 0.04,
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: ((context) => const LoginView()),
//                       ),
//                     );
//                   },
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         "Already have an account ?",
//                         style: TextStyle(
//                           color: Tcolor.black,
//                           fontSize: 14,
//                         ),
//                       ),
//                       Text(
//                         "Login",
//                         style: TextStyle(
//                             color: Tcolor.black,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w700),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: media.width * 0.04,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }






























































































