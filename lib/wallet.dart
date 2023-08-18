import 'package:palcredits/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Wallet extends StatefulWidget {
  final String ids;
  const Wallet({
    super.key,
    required this.ids,
  });

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool trans = false;
  TextEditingController withdrawcontroller = TextEditingController();

  Future transactions() async {
    await FirebaseFirestore.instance
        .collection('userwallet')
        .doc(widget.ids)
        .collection('transactions')
        .add({
      'request': withdrawcontroller.text,
      'date':
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
      'status': '0'
    });
  }

//  Future updatewallet() async {
//     //getwalletdata();

//     await FirebaseFirestore.instance
//         .collection('userwallet')
//         .doc(widget.ids)
//         .update({
//       'balance':

//     });
//   }

  @override
  void initState() {
    // TODO: implement initState
    //getwalletdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 8, 71, 123),
        title: Text("Wallet"),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     //updatewallet();
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(6),
                    //       color: Color.fromARGB(255, 7, 82, 144),
                    //     ),
                    //     child: Text(
                    //       'Details',
                    //       style: TextStyle(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w600,
                    //           color: Colors.white),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  height: 148,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [
                          0.1,
                          0.3,
                          0.6,
                          0.9,
                        ],
                        colors: [
                          Color.fromARGB(255, 15, 59, 94),
                          Color.fromARGB(255, 18, 102, 171),
                          Color.fromARGB(255, 78, 140, 191),
                          Color.fromARGB(255, 53, 87, 114),
                        ],
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Balance',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.9)),
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('userwallet')
                              .where('id', isEqualTo: widget.ids)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                            if (streamSnapshot.hasData) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: streamSnapshot.data!.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final DocumentSnapshot documentSnapshot =
                                        streamSnapshot.data!.docs[index];

                                    return Center(
                                      child: Text(
                                        documentSnapshot['balance'],
                                        style: const TextStyle(
                                            fontSize: 21,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.start,
                                      ),
                                    );
                                  });
                            }
                            return const Text(
                              '0',
                              style: TextStyle(
                                  fontSize: 21,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.start,
                            );
                          }),
                      SizedBox(
                        height: 11,
                      ),
                      Text(
                        'Updated today , 45 transaction till date',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.8)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 21),
                  child: InkWell(
                    onTap: () {
                      bottom();
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 38, 107, 164),
                      ),
                      child: Center(
                        child: Text(
                          'Withdraw',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Transaction History',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 383,
                  width: double.infinity,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('userwallet')
                          .doc(widget.ids)
                          .collection('transactions')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          return ResponsiveGridList(
                              horizontalGridSpacing:
                                  6, // Horizontal space between grid items

                              horizontalGridMargin:
                                  0, // Horizontal space around the grid
                              verticalGridMargin:
                                  0, // Vertical space around the grid
                              minItemWidth:
                                  300, // The minimum item width (can be smaller, if the layout constraints are smaller)
                              minItemsPerRow:
                                  1, // The minimum items to show in a single row. Takes precedence over minItemWidth
                              maxItemsPerRow:
                                  1, // The maximum items to show in a single row. Can be useful on large screens

                              listViewBuilderOptions:
                                  ListViewBuilderOptions(shrinkWrap: true),
                              children: List.generate(
                                  streamSnapshot.data!.docs.length,
                                  //,
                                  (index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                return InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: Container(
                                      height: 65,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: const Color.fromARGB(
                                                        255, 102, 100, 100)
                                                    .withOpacity(0.1),
                                                spreadRadius: 0.6,
                                                blurRadius: 1)
                                          ]),
                                      child: Row(
                                        children: [
                                          documentSnapshot['status'] == '1'
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 20),
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: Color.fromARGB(
                                                            255, 20, 130, 24)),
                                                    child: const Icon(
                                                      Icons.done_outline,
                                                      size: 25,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 20),
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: Color.fromARGB(
                                                            255, 255, 145, 0)),
                                                    child: const Icon(
                                                      Icons.request_quote,
                                                      size: 25,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                documentSnapshot['status'] ==
                                                        '1'
                                                    ? "Completed"
                                                    : "Withdrawl Request",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black
                                                        .withOpacity(0.8),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                documentSnapshot['date'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Text(
                                            documentSnapshot['request'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            width: 25,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }));
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bottom() {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                color: const Color.fromARGB(255, 114, 113, 113),
                child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),
                        color: Colors.white),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 20),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Container(
                                height: 45,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color.fromARGB(
                                                  255, 102, 100, 100)
                                              .withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 1)
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 8),
                                  child: TextField(
                                    controller: withdrawcontroller,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter Amount',
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: MaterialButton(
                              height: 38,
                              onPressed: () {
                                transactions();
                                Navigator.pop(context);
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
                                      'Request',
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
                    )),
              ),
            ));
  }
}
