import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'controller/controller.dart';

class Bottom1 extends StatefulWidget {
  const Bottom1({super.key});

  @override
  State<Bottom1> createState() => _Bottom1State();
}

class _Bottom1State extends State<Bottom1> {
  final CollectionReference chat =
      FirebaseFirestore.instance.collection('leads');

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
    //log('user number is splash $token');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 140,
      child: StreamBuilder(
          stream: chat.where('token', isEqualTo: localtoken).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 185,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 102, 100, 100)
                                          .withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 1)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 11),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ),
                                  Text(
                                    ' : ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    documentSnapshot['first_name'],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      'Bank Name',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ),
                                  Text(
                                    ' : ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    documentSnapshot['Bank_name'],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      'Card Type',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ),
                                  Text(
                                    ' : ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    documentSnapshot['card_type'],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      'Application No.',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ),
                                  Text(
                                    ' : ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.8)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    documentSnapshot['lead_id'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      'Lead Id',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ),
                                  Text(
                                    ' : ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.8)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    documentSnapshot.id,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.8)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      'Application Status',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ),
                                  Text(
                                    ' : ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.8)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 190,
                                    child: Text(
                                      documentSnapshot['application_status'],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: documentSnapshot[
                                                      'application_status'] ==
                                                  'Pending'
                                              ? Colors.orange
                                              : Colors.green),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //trailing: ,
                      ),
                    );
                  });
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
