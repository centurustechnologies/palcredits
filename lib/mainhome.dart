import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:palcredits/bottom.dart';
import 'package:palcredits/company.dart';
import 'package:palcredits/pincode.dart';
import 'package:palcredits/profile.dart';
import 'package:palcredits/searckbank.dart';

import 'controller/controller.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

Future<bool> willPop() async {
  return false;
}

class _MainHomeState extends State<MainHome> {
  final CollectionReference chat =
      FirebaseFirestore.instance.collection('agents');
  List imgList = [
    'assets/ooo1.jpg',
    'assets/ooo2.png',
    'assets/ooo3.jpg',
  ];
  bool insurance = false;
  bool loan = false;

  // logOut() async {
  //   DateTime now = DateTime.now();
  //   String time = DateFormat('HH:mm:ss').format(now);
  //   print(time);
  //   if (time == '17:24:00') {
  //     setState(() {
  //       storage.delete(key: 'token');
  //       //homePage = PhoneLogin();
  //     });
  //   } else {}
  // }

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

  // Future walletcheck() async {
  //   //DateTime now = DateTime.now();
  //   final Query query = FirebaseFirestore.instance
  //       .collection('wallet')
  //       .where('token', isEqualTo: localtoken);

  //   query.get().then((querySnapshot) {
  //     if (querySnapshot.size == 0) {
  //       wallet();
  //     } else {}
  //   }).catchError((error) {});
  // }

  // Future wallet() async {
  //   await FirebaseFirestore.instance.collection('wallet').doc(localtoken).set({
  //     'balance': '0',
  //     'token': localtoken,
  //   });
  // }

  // String yourid = '';
  // void getDeviceInfo() async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isAndroid) {
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

  //     yourid = androidInfo.androidId;
  //     print('Device id: ${androidInfo.androidId}');
  //   } else {
  //     Null;
  //   }
  // }

  bool update = true;

  String id = '';
  Future getadmindata() async {
    await FirebaseFirestore.instance
        .collection('update')
        .doc('1')
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          id = value.get('update_id');
        });
        print(id);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    checkLogin();
    getadmindata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: willPop,
        child: id == '1'
            ? Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: const Color.fromARGB(255, 8, 71, 123),
                  automaticallyImplyLeading: false,
                  title: const Text(
                    'Pal Credits',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 15),
                      child: Center(
                        child: IconButton(
                          icon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            //walletcheck();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile(
                                        ids: localtoken,
                                      )),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 140,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 25,
                              width: 250,
                              child: StreamBuilder(
                                  stream: chat
                                      .where('password', isEqualTo: localtoken)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot>
                                          streamSnapshot) {
                                    //streamSnapshot.data!.docs.length,
                                    if (streamSnapshot.hasData) {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              streamSnapshot.data!.docs.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final DocumentSnapshot
                                                documentSnapshot =
                                                streamSnapshot
                                                    .data!.docs[index];

                                            return Text(
                                              documentSnapshot['name'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromARGB(
                                                      255, 1, 70, 4)),
                                            );
                                          });
                                    }
                                    return const Text(
                                      '0',
                                      style: TextStyle(
                                          fontSize: 21,
                                          color: Color.fromARGB(255, 1, 70, 4),
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.start,
                                    );
                                  }),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            insurance
                                ? const Text(
                                    'We Provide Insurances',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 1, 70, 4)),
                                  )
                                : loan
                                    ? const Text(
                                        'We Provide Loans',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromARGB(255, 1, 70, 4)),
                                      )
                                    : const Text(
                                        'Credit card we deal in',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromARGB(255, 1, 70, 4)),
                                      ),
                            const SizedBox(
                              height: 15,
                            ),
                            insurance
                                ? Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: const Color.fromARGB(
                                                      255, 102, 100, 100)
                                                  .withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 10)
                                        ]),
                                    child: Center(
                                      child: Lottie.asset(
                                          'assets/insurance.json',
                                          fit: BoxFit.cover,
                                          repeat: true),
                                    ),
                                  )
                                : loan
                                    ? Container(
                                        height: 150,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: const Color.fromARGB(
                                                          255, 102, 100, 100)
                                                      .withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 10)
                                            ]),
                                        child: Center(
                                          child: Lottie.asset(
                                              'assets/loan5.json',
                                              fit: BoxFit.cover,
                                              repeat: true),
                                        ),
                                      )
                                    : Container(
                                        height: 150,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: const Color.fromARGB(
                                                          255, 102, 100, 100)
                                                      .withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 10)
                                            ]),
                                        child: CarouselSlider(
                                            items: imgList
                                                .map((item) => Container(
                                                      height: 150,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(11),
                                                        image: DecorationImage(
                                                          image:
                                                              AssetImage(item),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            options: CarouselOptions(
                                                autoPlay: true,
                                                aspectRatio: 2,
                                                viewportFraction: 0.8,
                                                enlargeCenterPage: true,
                                                autoPlayInterval:
                                                    const Duration(
                                                        seconds: 3))),
                                      ),
                            const SizedBox(
                              height: 10,
                            ),
                            insurance
                                ? const Text(
                                    'Insurances options',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 1, 70, 4)),
                                  )
                                : loan
                                    ? const Text(
                                        'Easy Loans options',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromARGB(255, 1, 70, 4)),
                                      )
                                    : const Text(
                                        'Credit card options',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromARGB(255, 1, 70, 4)),
                                      ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 102, 100, 100)
                                            .withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 10)
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      insurance
                                          ? card('Insurance Leads',
                                              Icons.credit_card)
                                          : loan
                                              ? card('Loans Leads',
                                                  Icons.credit_card)
                                              : card('Credit card leads',
                                                  Icons.credit_card),
                                      card(
                                          'View my leads', Icons.leak_add_sharp)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      card('Search company', Icons.search),
                                      card('Search pincodes', Icons.code)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            insurance
                                ? SizedBox(
                                    height: 125,
                                    width: double.infinity,
                                    child: Image.asset(
                                      'assets/insurance2.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : loan
                                    ? SizedBox(
                                        height: 125,
                                        width: double.infinity,
                                        child: Image.asset(
                                          'assets/loan2.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : SizedBox(
                                        height: 125,
                                        width: double.infinity,
                                        child: Image.asset(
                                          'assets/jpg8.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                            const SizedBox(
                              height: 11,
                            )
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(255, 102, 100, 100)
                                .withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 10)
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          card1('Credit Card', Icons.credit_card),
                          card1('Easy Loans', Icons.leak_add_sharp),
                          card1('Insurances', Icons.account_balance),
                          card1('My Leads', Icons.leaderboard_sharp),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color.fromARGB(255, 8, 71, 123),
                  automaticallyImplyLeading: false,
                  title: const Text(
                    'AG Financial Services',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      child: Center(
                        child: Lottie.asset('assets/update.json',
                            fit: BoxFit.cover, repeat: true),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Please Update your app',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 13, 1)),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45),
                      child: MaterialButton(
                        height: 38,
                        onPressed: () {
                          setState(() {
                            update = false;
                          });
                        },
                        color: Color.fromARGB(255, 30, 90, 139),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Update',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              //Icon(Icons.arrow_forward_ios_sharp)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }

  card(text, ttt) {
    return InkWell(
      onTap: () {
        text == 'Search pincodes'
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PinCode(),
                ),
              )
            : text == 'Search company'
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Company(),
                    ),
                  )
                : text == 'View my leads'
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => loan
                                ? Bottom(
                                    number: 2,
                                  )
                                : insurance
                                    ? Bottom(
                                        number: 1,
                                      )
                                    : Bottom(
                                        number: 0,
                                      )),
                      )
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchBank()),
                      );
      },
      child: SizedBox(
        height: 55,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              ttt,
              color: const Color.fromARGB(255, 1, 70, 4),
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  card1(text, ttt) {
    return InkWell(
      onTap: () {
        text == 'Credit Card'
            ? setState(() {
                insurance = false;
                loan = false;
              })
            : text == 'Insurances'
                ? setState(() {
                    insurance = true;
                    loan = false;
                  })
                : text == 'Easy Loans'
                    ? setState(() {
                        loan = true;
                        insurance = false;
                      })
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Bottom(number: 0),
                        ),
                      );
      },
      child: Container(
        height: 55,
        width: 70,
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
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
