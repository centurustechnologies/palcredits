import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:responsive_grid_list/responsive_grid_list.dart';

class Attendance extends StatefulWidget {
  final String ids;
  const Attendance({
    super.key,
    required this.ids,
  });

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final CollectionReference chat =
      FirebaseFirestore.instance.collection('agents');
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 50,
      color: Colors.white,

      width: double.infinity,
      //color: Colors.amber,
      child: Column(
        children: [
          Container(
            height: 30,
            color: Color.fromARGB(255, 4, 41, 72),
          ),
          Container(
            height: 40,
            width: double.infinity,
            color: Color.fromARGB(255, 4, 41, 72),
            child: Center(
                child: Text(
              'Attendance Record',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 120,
            child: StreamBuilder(
                stream:
                    chat.doc(widget.ids).collection('attendance').snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ResponsiveGridList(
                        horizontalGridSpacing:
                            16, // Horizontal space between grid items

                        horizontalGridMargin:
                            0, // Horizontal space around the grid
                        verticalGridMargin: 0, // Vertical space around the grid
                        minItemWidth:
                            300, // The minimum item width (can be smaller, if the layout constraints are smaller)
                        minItemsPerRow:
                            1, // The minimum items to show in a single row. Takes precedence over minItemWidth
                        maxItemsPerRow:
                            4, // The maximum items to show in a single row. Can be useful on large screens

                        listViewBuilderOptions: ListViewBuilderOptions(
                            shrinkWrap:
                                true), // Options that are getting passed to the ListView.builder() function
                        children:
                            List.generate(streamSnapshot.data!.docs.length,
                                //,
                                (index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 21),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 102, 100, 100)
                                            .withOpacity(0.4),
                                        spreadRadius: 0.6,
                                        blurRadius: 1)
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    documentSnapshot['date'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "check in",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        documentSnapshot['checkin_time'],
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "check out",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        documentSnapshot['checkout_time'] ==
                                                '23:50'
                                            ? '23:50'
                                            : documentSnapshot['checkout_time'],
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
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
    );
  }
}
