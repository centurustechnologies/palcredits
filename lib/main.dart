import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:palcredits/login.dart';
import 'package:palcredits/phonelogin.dart';

import 'controller/controller.dart';
// import 'dart:async'show Future;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget homePage = PhoneLogin(
    ids: '',
  );

  @override
  void initState() {
    checkLogin();
    super.initState();
    //logOut();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pal Credits',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: // Profile(ids: "ids"),

          //VisitingCard(),
          const PhoneLogin(
        ids: '',
      ),
      // AccountDetail(
      //   bankname: '',
      //   cardtype: '',
      // ),
      //VoiceCallScreen()//Pdf()
    );
  }

  String phoneid = '';

  String localtoken = '';
  checkLogin() async {
    String? token = await getToken();

    if (token != null) {
      setState(() {
        localtoken = token;
      });
      //getadmindata();
      attendancecheck();
    } else {
      setState(() {
        homePage = PhoneLogin(
          ids: phoneid,
        );
      });
    }
    //log('user number is splash $token');
  }

  Future attendancecheck() async {
    //DateTime now = DateTime.now();
    final Query query = FirebaseFirestore.instance
        .collection('agents')
        .doc(localtoken)
        .collection('attendance')
        .where('date',
            isEqualTo:
                "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}");

    query.get().then((querySnapshot) {
      if (querySnapshot.size == 0) {
        setState(() {
          homePage = PhoneLogin(
            ids: phoneid,
          );
        });
      } else {
        setState(() {
          homePage = Login();
        });
      }
    }).catchError((error) {});
  }
}
