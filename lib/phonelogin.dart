import 'dart:io';

import 'package:palcredits/mainhome.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:device_info/device_info.dart';

class PhoneLogin extends StatefulWidget {
  final String ids;
  const PhoneLogin({
    super.key,
    required this.ids,
  });

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  //NotificationsServices notificationsServices = NotificationsServices();

  TextEditingController useridcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  static const storage = FlutterSecureStorage();

  Future check() async {
    final Query query = FirebaseFirestore.instance
        .collection('agents')
        .where('userid', isEqualTo: useridcontroller.text)
        .where('password', isEqualTo: passwordcontroller.text);

    query.get().then((querySnapshot) {
      if (querySnapshot.size > 0) {
        attendancecheck();
        storeTokenAndData(passwordcontroller.text);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainHome(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please Enter correct Credentials'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }).catchError((error) {
      // Handle any errors
    });
  }

  Future attendancecheck() async {
    DateTime now = DateTime.now();
    final Query query = FirebaseFirestore.instance
        .collection('agents')
        .doc(passwordcontroller.text)
        .collection('attendance')
        .where('date',
            isEqualTo:
                "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}");

    query.get().then((querySnapshot) {
      if (querySnapshot.size == 0) {
        attendance();
      } else {}
    }).catchError((error) {});
  }

  Future attendance() async {
    DateTime now = DateTime.now();
    await FirebaseFirestore.instance
        .collection('agents')
        .doc(passwordcontroller.text)
        .collection('attendance')
        .add({
      'userid': useridcontroller.text,
      'checkin_time': '${now.hour}:${now.minute}',
      'checkout_time': '23:50',
      'date':
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
      'location': Address,
      'status':'Present'
    });
  }

  void storeTokenAndData(username) async {
    await storage.write(key: "token", value: username.toString());
  }

  Future<bool> willPop() async {
    return false;
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  String Address = '';
  String location = '';
  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode},';

    check();
  }

  String yourid = '';
  void getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      setState(() {
        yourid = androidInfo.androidId;
      });

      print('Device id: ${androidInfo.androidId}');
    } else {
      Null;
    }
  }

  Future updateid() async {
    FirebaseFirestore.instance
        .collection('agents')
        .doc(passwordcontroller.text)
        .update({'mobile_id': yourid});
  }

  String phoneid = '';
  Future getadmindata() async {
    await FirebaseFirestore.instance
        .collection('agents')
        .doc(passwordcontroller.text)
        .get()
        .then((value) async{
      if (value.exists) {
        setState(() {
          phoneid = value.get('mobile_id');
        });
          if (phoneid == yourid) {
                                  updateid();
                                  dialog(context);
                                  Position position =
                                      await _getGeoLocationPosition();
                                  location =
                                      'Lat: ${position.latitude} , Long: ${position.longitude}';
                                  GetAddressFromLatLong(position);
                                }else if(phoneid==''){
                                    updateid();
                                  dialog(context);
                                  Position position =
                                      await _getGeoLocationPosition();
                                  location =
                                      'Lat: ${position.latitude} , Long: ${position.longitude}';
                                  GetAddressFromLatLong(position);
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        'Already registered from another device'),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                );  
                                }
      }
    });
  }

  @override
  void initState() {
    getDeviceInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
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
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w900,
                              color: Color.fromARGB(255, 19, 19, 19)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
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
                                child: TextField(
                                  controller: useridcontroller,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Userid here',
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
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                                    //keyboardType: TextInputType.number,
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
                        padding: const EdgeInsets.only(
                            left: 180, right: 40, top: 40),
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
                            onPressed: () async {
                              if (useridcontroller.text.isNotEmpty &&
                                  passwordcontroller.text.isNotEmpty) {
                                getadmindata();
                              
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        'Please fill all mandatory fields'),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
      ),
    );
  }

  dialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Container(
              height: 150,
              width: 300,
              child: Center(
                child: Lottie.asset('assets/conform.json',
                    fit: BoxFit.fill, repeat: true),
              ),
            ),
          );
        });
  }
}
