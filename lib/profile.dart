import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:palcredits/Offer_letter.dart';
import 'package:palcredits/visiting_card.dart';
import 'package:palcredits/attendance.dart';
import 'package:palcredits/wallet.dart';

import 'controller/controller.dart';
import 'main.dart';

class Profile extends StatefulWidget {
  final String ids;
  const Profile({
    super.key,
    required this.ids,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with WidgetsBindingObserver {
  final CollectionReference chat =
      FirebaseFirestore.instance.collection('agents');

  String localtoken = '';

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
  }

  Future updateattendance(String id) async {
    DateTime now = DateTime.now();
    await FirebaseFirestore.instance
        .collection('agents')
        .doc(widget.ids)
        .collection('attendance')
        .doc(id)
        .update({
      'checkout_time': '${now.hour}:${now.minute}',
    });
  }

  bool attendance = false;
  bool wallet = false;

  @override
  void initState() {
    // TODO: implement initState
    // DateTime now = DateTime.now();
    // String time = "${now.hour}:${now.minute}";
    // print(time);
    checkLogin();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: const Color.fromARGB(255, 8, 71, 123),
      ),
      body: Column(
        children: [
          wallet
              ? Wallet(ids: widget.ids)
              : attendance
                  ? Attendance(ids: widget.ids)
                  : Column(
                      children: [
                        StreamBuilder(
                            stream: chat
                                .where('password', isEqualTo: localtoken)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                              if (streamSnapshot.hasData) {
                                return ListView.builder(
                                    itemCount: streamSnapshot.data!.docs.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final DocumentSnapshot documentSnapshot =
                                          streamSnapshot.data!.docs[index];
                                      return Container(
                                        padding: EdgeInsets.only(top: 5),
                                        height: 150,
                                        width: double.infinity,
                                        color: const Color.fromARGB(
                                            255, 8, 71, 123),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      102,
                                                                      100,
                                                                      100)
                                                                  .withOpacity(
                                                                      0.2),
                                                              spreadRadius: 1,
                                                              blurRadius: 10)
                                                        ],
                                                        image: const DecorationImage(
                                                            image: AssetImage(
                                                                'assets/user.png'),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 12),
                                                        child: Text(
                                                          documentSnapshot[
                                                              'name'],
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 12),
                                                        child: Text(
                                                          documentSnapshot[
                                                              'email'],
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.7)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 12),
                                                        child: Text(
                                                          documentSnapshot[
                                                              'mobile_number'],
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.7)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 12),
                                                        child: Text(
                                                          documentSnapshot[
                                                              'Area'],
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.7)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: StreamBuilder(
                                  stream: chat
                                      .doc(widget.ids)
                                      .collection('attendance')
                                      .where('date',
                                          isEqualTo:
                                              "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}")
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot>
                                          streamSnapshot) {
                                    if (streamSnapshot.hasData) {
                                      return ListView.builder(
                                          itemCount:
                                              streamSnapshot.data!.docs.length,
                                          physics: ScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final DocumentSnapshot
                                                documentSnapshot =
                                                streamSnapshot
                                                    .data!.docs[index];
                                            if (documentSnapshot['date'] ==
                                                "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}") {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1,
                                                width: double.infinity,
                                                color: Colors.white,
                                                child: Column(
                                                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 20,
                                                              right: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Welcome',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.6)),
                                                              ),
                                                              const SizedBox(
                                                                height: 2,
                                                              ),
                                                              Text(
                                                                'Pal credits',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Date',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.6)),
                                                              ),
                                                              const SizedBox(
                                                                height: 2,
                                                              ),
                                                              Text(
                                                                documentSnapshot[
                                                                    'date'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Divider(
                                                      height: 0,
                                                    ),
                                                    ExpansionTile(
                                                      leading: Icon(Icons
                                                          .online_prediction),
                                                      title: Text(
                                                        'Today Status',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  'Check In',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.6)),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  documentSnapshot[
                                                                      'checkin_time'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  'Check Out',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.6)),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                documentSnapshot[
                                                                            'checkout_time'] ==
                                                                        '23:50'
                                                                    ? Text(
                                                                        '--/--',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color: Colors.black),
                                                                      )
                                                                    : Text(
                                                                        documentSnapshot[
                                                                            'checkout_time'],
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color: Colors.black),
                                                                      ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      height: 0,
                                                    ),

                                                    Container(
                                                      height: 52,
                                                      child: ListTile(
                                                        leading:
                                                            Icon(Icons.mail),
                                                        title: Text(
                                                            "Offer Letter"),
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  OfferLetter(),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Divider(),

                                                    Container(
                                                      height: 45,
                                                      child: ListTile(
                                                        leading: Icon(Icons
                                                            .card_giftcard),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 14),
                                                          child: Text(
                                                              "Visiting Card"),
                                                        ),
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  VisitingCard(),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Divider(),
                                                    Container(
                                                      height: 45,
                                                      child: ListTile(
                                                        leading:
                                                            Icon(Icons.wallet),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 14),
                                                          child: Text("Wallet"),
                                                        ),
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Wallet(
                                                                          ids:
                                                                              localtoken,
                                                                        )),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Divider(),
                                                    Container(
                                                      height: 45,
                                                      child: ListTile(
                                                        leading: Icon(
                                                            Icons.location_on),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 14),
                                                          child:
                                                              Text("Addresses"),
                                                        ),
                                                        onTap: () {},
                                                      ),
                                                    ),
                                                    Divider(),
                                                    Container(
                                                      height: 45,
                                                      child: ListTile(
                                                        leading: Icon(
                                                            Icons.contacts),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 14),
                                                          child: Text(
                                                              "Contact Details"),
                                                        ),
                                                        onTap: () {},
                                                      ),
                                                    ),
                                                    Divider(),
                                                    Container(
                                                      height: 45,
                                                      child: ListTile(
                                                        leading:
                                                            Icon(Icons.details),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 14),
                                                          child: Text(
                                                              "Bank Details"),
                                                        ),
                                                        onTap: () {},
                                                      ),
                                                    ),

                                                    Divider(),
                                                    Container(
                                                      height: 45,
                                                      child: ListTile(
                                                        leading:
                                                            Icon(Icons.help),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 14),
                                                          child: Text("Help"),
                                                        ),
                                                        onTap: () {},
                                                      ),
                                                    ),
                                                    Divider(),
                                                    Container(
                                                      height: 45,
                                                      child: ListTile(
                                                        leading: Icon(
                                                            Icons.privacy_tip),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 14),
                                                          child: Text(
                                                              "Privacy Policy"),
                                                        ),
                                                        onTap: () {},
                                                      ),
                                                    ),

                                                    Divider(),
                                                    Container(
                                                      height: 45,
                                                      child: ListTile(
                                                        leading:
                                                            Icon(Icons.person),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 14),
                                                          child: Text(
                                                              "Attendence"),
                                                        ),
                                                        onTap: () {},
                                                      ),
                                                    ),
                                                    Divider(),
                                                    Container(
                                                      height: 45,
                                                      child: ListTile(
                                                        leading:
                                                            Icon(Icons.logout),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 14),
                                                          child: Text("Logout"),
                                                        ),
                                                        onTap: () {
                                                          storage.delete(
                                                              key: 'token');
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MyApp()),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Divider(),

                                                    //Spacer(),
                                                    // Padding(
                                                    //   padding:
                                                    //       const EdgeInsets
                                                    //               .symmetric(
                                                    //           horizontal: 0,
                                                    //           vertical: 20),
                                                    //   child: Container(
                                                    //     decoration:
                                                    //         BoxDecoration(
                                                    //       borderRadius:
                                                    //           BorderRadius
                                                    //               .circular(
                                                    //                   12),
                                                    //       gradient: const LinearGradient(
                                                    //           colors: [
                                                    //             Colors.blue,
                                                    //             Color
                                                    //                 .fromARGB(
                                                    //                     255,
                                                    //                     8,
                                                    //                     71,
                                                    //                     123)
                                                    //           ],
                                                    //           begin: Alignment
                                                    //               .bottomLeft,
                                                    //           end: Alignment
                                                    //               .topRight),
                                                    //     ),
                                                    //     child:
                                                    //         MaterialButton(
                                                    //       onPressed: () {
                                                    //         updateattendance(
                                                    //             documentSnapshot
                                                    //                 .id);
                                                    //         storage.delete(
                                                    //             key:
                                                    //                 'token');
                                                    //         Navigator.push(
                                                    //           context,
                                                    //           MaterialPageRoute(
                                                    //             builder:
                                                    //                 (context) =>
                                                    //                     MyApp(),
                                                    //           ),
                                                    //         );
                                                    //       },
                                                    //       height: 30,
                                                    //       shape: RoundedRectangleBorder(
                                                    //           borderRadius:
                                                    //               BorderRadius
                                                    //                   .circular(
                                                    //                       7)),
                                                    //       child: Padding(
                                                    //         padding: const EdgeInsets
                                                    //                 .symmetric(
                                                    //             horizontal:
                                                    //                 30,
                                                    //             vertical:
                                                    //                 5),
                                                    //         child: Row(
                                                    //           mainAxisAlignment:
                                                    //               MainAxisAlignment
                                                    //                   .center,
                                                    //           children: const [
                                                    //             Text(
                                                    //               'Click here to Check Out',
                                                    //               style: TextStyle(
                                                    //                   fontSize:
                                                    //                       14,
                                                    //                   fontWeight: FontWeight
                                                    //                       .w500,
                                                    //                   color:
                                                    //                       Colors.white),
                                                    //             ),
                                                    //           ],
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return Container(
                                                color: Colors.white,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height -
                                                    280,
                                                width: double.infinity,
                                                child: Center(
                                                  child: Lottie.asset(
                                                      'assets/loan5.json',
                                                      fit: BoxFit.cover,
                                                      repeat: true),
                                                ),
                                              );
                                            }
                                          });
                                    }
                                    return Container(
                                      color: Colors.white,
                                      height:
                                          MediaQuery.of(context).size.height -
                                              280,
                                      width: double.infinity,
                                      child: Center(
                                        child: Lottie.asset('assets/loan5.json',
                                            fit: BoxFit.cover, repeat: true),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
        ],
      ),
    );
  }

  card1(text, ttt) {
    return InkWell(
      onTap: () {
        text == 'Attendance'
            ? setState(() {
                attendance = true;
                wallet = false;
              })
            : text == 'wallet'
                ? setState(() {
                    wallet = true;
                    attendance = false;
                  })
                : setState(() {
                    wallet = false;
                    attendance = false;
                  });
      },
      child: Container(
        height: 55,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              ttt,
              size: 20,
              color: const Color.fromARGB(255, 8, 71, 123),
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
