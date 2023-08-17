import 'package:flutter/material.dart';

class VisitingCard extends StatefulWidget {
  const VisitingCard({super.key});

  @override
  State<VisitingCard> createState() => _VisitingCardState();
}

class _VisitingCardState extends State<VisitingCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          splashRadius: 24,
        ),
        title: Text(
          "Visiting Card",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 200,
              width: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/pic3.png'), // Replace with your image path
                  fit: BoxFit.fitWidth,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 75,
                              height: 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/logo2.jpg'),
                                    fit: BoxFit
                                        .cover // Replace with your image asset
                                    ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "PAL",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "CREDITS",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 39, left: 40, bottom: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ankit Kumar',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Software Developer ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.email,
                                        size: 12,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        'ankit.ankit.0x@gmail.com',
                                        style: TextStyle(fontSize: 11),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                    width: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 12,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        '+91 82641 04734',
                                        style: TextStyle(fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ]),
                      ),
                      Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                "Offering Loans, Credits Cards And All Financial Products Digitally",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 26,
                            width: 26,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    Colors.white, // Set the border color here
                                width: 2.0, // Set the border width
                              ),
                              borderRadius: BorderRadius.circular(
                                  50), // Apply a circular border radius
                            ),
                            child: Icon(
                              Icons.phone,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "WhatsApp",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Share",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Terms of use',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '1. Is not transferable to any other person. Ensure that their ID Cards are kept secured and are not delibrately or inadvertenatly made availabe for use by any other person.',
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '2. Alternation, falsification, or misuse of the card is a violation and will be dealt with accordingly severe disciplinary action against him/her. Fraudulent use of the card may also result in criminal charges and/or civil proceedings as deemed fit.',
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '3. Upon completion or cessation of agreement, one must no longer use the card for proof of his/her agent status for any purpose.',
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
