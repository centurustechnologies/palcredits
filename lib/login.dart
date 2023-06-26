import 'package:palcredits/mainhome.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'controller/controller.dart';
import 'otppage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //NotificationsServices notificationsServices = NotificationsServices();

  //TextEditingController useridcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  static const storage = FlutterSecureStorage();

  String localtoken = '';

  //AuthClass authClass = AuthClass();
  checkLogin() async {
    String? token = await getToken();

    if (token != null) {
      setState(() {
        localtoken = token;
      });
    } else {
      setState(() {
        localtoken = '';
      });
    }
    //log('user number is splash $token');
  }

  @override
  void initState() {
    // TODO: implement initState

    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Container(
                              height: 200,
                              width: 200,
                              child: Lottie.asset('assets/blue2.json',
                                  fit: BoxFit.cover, repeat: true),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30, top: 31),
                      child: Text(
                        'Enter Your Passcode',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 19, 19, 19)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        'Passcode is Necessary to fill',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.withOpacity(0.8)),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 30),
                    //   child: Container(
                    //     height: 45,
                    //     width: 300,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(15),
                    //         color: Colors.white,
                    //         boxShadow: [
                    //           BoxShadow(
                    //               color:
                    //                   const Color.fromARGB(255, 102, 100, 100)
                    //                       .withOpacity(0.2),
                    //               spreadRadius: 1,
                    //               blurRadius: 2)
                    //         ]),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 10),
                    //       child: SizedBox(
                    //         width: 200,
                    //         height: 45,
                    //         child: Center(
                    //           child: TextField(
                    //             controller: useridcontroller,
                    //             keyboardType: TextInputType.emailAddress,
                    //             decoration: InputDecoration(
                    //               hintText: 'Enter Userid here',
                    //               hintStyle: TextStyle(
                    //                   fontSize: 13,
                    //                   color: Colors.grey.withOpacity(0.8)),
                    //               border: const OutlineInputBorder(
                    //                 borderSide: BorderSide(
                    //                     color: Colors.white, width: 5.0),
                    //               ),
                    //               enabledBorder: const OutlineInputBorder(
                    //                   borderSide:
                    //                       BorderSide(color: Colors.white)),
                    //               focusedBorder: const OutlineInputBorder(
                    //                   borderSide:
                    //                       BorderSide(color: Colors.white)),
                    //               labelStyle: const TextStyle(
                    //                   color: Colors.black,
                    //                   fontSize: 15,
                    //                   fontWeight: FontWeight.w400),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 25),
                      child: Container(
                        height: 45,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 102, 100, 100)
                                          .withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: 200,
                            height: 45,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 11),
                                child: TextField(
                                  controller: passwordcontroller,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Password here',
                                    hintStyle: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.withOpacity(0.8)),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 5.0),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                    //hintText: 'ENTER',
                                    //labelText: 'Phone Number'
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 180, right: 40, top: 40),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  Colors.blue,
                                  Color.fromARGB(255, 8, 71, 123)
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                            borderRadius: BorderRadius.circular(21)),
                        child: MaterialButton(
                          onPressed: () {
                            if (passwordcontroller.text == localtoken) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainHome(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      'Please Enter correct Passcode'),
                                  backgroundColor:
                                      Color.fromARGB(255, 8, 71, 123),
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              );
                            }
                          },

                          //color: Colors.amber,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 22,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        const SizedBox(
                          height: 270,
                          width: double.infinity,
                        ),
                        Positioned(
                          left: -50, //top: 10,
                          bottom: 0,
                          child: Container(
                            height: 150,
                            width: 150,
                            child: Lottie.asset('assets/blue2.json',
                                fit: BoxFit.cover, repeat: true),
                          ),
                        ),
                        Positioned(
                          right: 40,
                          bottom: 20,
                          child: SizedBox(
                            height: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Color.fromARGB(255, 179, 178, 178)),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 2, 80, 148)),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
