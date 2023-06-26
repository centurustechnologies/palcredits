import 'package:palcredits/accountdetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Credit extends StatefulWidget {
  final String bankname;

  const Credit({
    super.key,
    required this.bankname,
  });

  @override
  State<Credit> createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  final CollectionReference chat =
      FirebaseFirestore.instance.collection('Banks');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 71, 123),
        title: const Text(
          'Credit Card Options',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: StreamBuilder(
          stream: chat.doc(widget.bankname).collection('cards').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ResponsiveGridList(
                  horizontalGridSpacing:
                      0, // Horizontal space between grid items
                  // Vertical space between grid items
                  horizontalGridMargin: 0, // Horizontal space around the grid
                  verticalGridMargin: 0, // Vertical space around the grid
                  minItemWidth:
                      300, // The minimum item width (can be smaller, if the layout constraints are smaller)
                  minItemsPerRow:
                      1, // The minimum items to show in a single row. Takes precedence over minItemWidth
                  maxItemsPerRow:
                      1, // The maximum items to show in a single row. Can be useful on large screens
                  listViewBuilderOptions:
                      ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                  children:
                      List.generate(streamSnapshot.data!.docs.length, (index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountDetail(
                                bankname: widget.bankname,
                                cardtype: documentSnapshot['card_name'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 110,
                          width: 320,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 102, 100, 100)
                                            .withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 19, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  //crossAxisAlignment: CrossAxisAlignment.ce,
                                  children: [
                                    SizedBox(
                                      height: 80,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            documentSnapshot['card_name'],
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                          Container(
                                              height: 31,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Color.fromARGB(
                                                    255, 8, 71, 123),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Apply Now',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 90,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                documentSnapshot['image'],
                                              ),
                                              fit: BoxFit.cover)),
                                    ),
                                  ],
                                ),
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
    );
  }
}
