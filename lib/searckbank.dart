import 'package:palcredits/accountdetail.dart';
import 'package:palcredits/creditcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class SearchBank extends StatefulWidget {
  const SearchBank({super.key});

  @override
  State<SearchBank> createState() => _SearchBankState();
}

class _SearchBankState extends State<SearchBank> {
  final CollectionReference chat =
      FirebaseFirestore.instance.collection('Banks');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 71, 123),
        title: const Text(
          'Search Banks',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Popular Banks',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.4)),
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              Container(
                height: 600,
                child: StreamBuilder(
                    stream: chat.snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return ResponsiveGridList(
                            horizontalGridSpacing:
                                16, // Horizontal space between grid items

                            horizontalGridMargin:
                                0, // Horizontal space around the grid
                            verticalGridMargin:
                                0, // Vertical space around the grid
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
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Credit(
                                        bankname: documentSnapshot['bank_name'],
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 21),
                                  child: Container(
                                    height: 90,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
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
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding:  EdgeInsets.only(
                                              left: 10, right: 20),
                                          child: Container(
                                            height: 55,
                                            width: 55,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                                image: DecorationImage(
                                            image: NetworkImage(
                                              documentSnapshot['image'],
                                            ),
                                            fit: BoxFit.cover)
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
                                              documentSnapshot['bank_name'],
                                           
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black
                                                      .withOpacity(0.8),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "One of Indias best bank",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
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
              )
            ],
          ),
        ),
      ),
    );
  }

  card1(text, ttt) {
    return Container(
      height: 60,
      width: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color:
                    const Color.fromARGB(255, 102, 100, 100).withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            ttt,
            size: 20,
            color: Colors.grey,
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
    );
  }
}
