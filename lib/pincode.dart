import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class PinCode extends StatefulWidget {
  const PinCode({super.key});

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  bool search = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
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
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, bottom: 6),
                                    child: TextField(
                                      //controller: placeofbirthController,

                                      decoration: InputDecoration(
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
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12, top: 22),
                    child: Text(
                      'Search your pincode here',
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
              child: ResponsiveGridList(
                  horizontalGridSpacing:
                      16, // Horizontal space between grid items

                  horizontalGridMargin: 0, // Horizontal space around the grid
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
                  children: List.generate(12,
                      //,
                      (index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const Credit(),
                        //   ),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 21),
                        child: Container(
                          height: 80,
                          width: 70,
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
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  child: Icon(
                                    Icons.dashboard,
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
                                    index == 0
                                        ? 'Ludhiana'
                                        : index == 1
                                            ? 'Hoshiarpur'
                                            : index == 2
                                                ? 'Jalandhar'
                                                : index == 3
                                                    ? 'Amritsar'
                                                    : "sangrur",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Baba Deep singh nagar",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black.withOpacity(0.3),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                "141006",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              // const Spacer(),
                              // const Icon(Icons.arrow_forward_ios),
                              // const SizedBox(
                              //   width: 21,
                              // )
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
            ),
          )
        ],
      ),
    );
  }
}
