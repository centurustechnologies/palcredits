import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:url_launcher/url_launcher.dart';

class Company extends StatefulWidget {
  const Company({super.key});

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  bool search = false;
  TextEditingController searchController = TextEditingController();

  void _launchURL(
    link,
  ) async {
    if (!await launchUrl(
      Uri.parse(link),
      mode: LaunchMode.externalApplication,
    )) throw 'Could not launch $link';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            color: const Color.fromARGB(255, 8, 71, 123),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 23),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BackButton(
                          color: Colors.white,
                        ),
                        search
                            ? Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  height: 40,
                                  width: 260,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
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
                                        left: 15, bottom: 6),
                                    child: TextField(
                                      controller: searchController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Search",
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    search = true;
                                  });
                                },
                                child: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 22),
                    child: Text(
                      'Search your Company here',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.7)),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'AG Financial Services',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: Container(
                height: MediaQuery.of(context).size.height - 200,
                width: double.infinity,
                //color: Colors.amber,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        _launchURL(
                          'https://firebasestorage.googleapis.com/v0/b/ag-financial-services.appspot.com/o/company%2Faucompany.csv?alt=media&token=b8c317f1-8fa8-4be2-9a70-95ba7934420b',
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 21),
                        child: Container(
                          height: 75,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 102, 100, 100)
                                            .withOpacity(0.1),
                                    spreadRadius: 0.6,
                                    blurRadius: 1)
                              ]),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 20),
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.business_sharp,
                                    size: 40,
                                    color: Color.fromARGB(255, 8, 71, 123),
                                  ),
                                ),
                              ),
                              Text(
                                'Au Banks Companies',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Spacer(),

                              // const Spacer(),
                              // const Icon(Icons.arrow_forward_ios),
                              // const SizedBox(
                              //   width: 21,
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        _launchURL(
                            'https://firebasestorage.googleapis.com/v0/b/ag-financial-services.appspot.com/o/company%2FAU%20BANK%20NEW%20AREA%20PIN%20CODE.xlsx?alt=media&token=97f0bca0-f447-4abe-ac74-7977666784fb');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 21),
                        child: Container(
                          height: 75,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 102, 100, 100)
                                            .withOpacity(0.1),
                                    spreadRadius: 0.6,
                                    blurRadius: 1)
                              ]),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 20),
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.business_sharp,
                                    size: 40,
                                    color: Color.fromARGB(255, 8, 71, 123),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Au Banks pincodes',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                              const Spacer(),

                              // const Spacer(),
                              // const Icon(Icons.arrow_forward_ios),
                              // const SizedBox(
                              //   width: 21,
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        _launchURL(
                          'https://firebasestorage.googleapis.com/v0/b/ag-financial-services.appspot.com/o/company%2Faucompany.csv?alt=media&token=b8c317f1-8fa8-4be2-9a70-95ba7934420b',
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 21),
                        child: Container(
                          height: 75,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 102, 100, 100)
                                            .withOpacity(0.1),
                                    spreadRadius: 0.6,
                                    blurRadius: 1)
                              ]),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 20),
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.business_sharp,
                                    size: 40,
                                    color: Color.fromARGB(255, 8, 71, 123),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Au Banks Companies',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                              const Spacer(),

                              // const Spacer(),
                              // const Icon(Icons.arrow_forward_ios),
                              // const SizedBox(
                              //   width: 21,
                              // )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
