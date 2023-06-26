import 'package:palcredits/bottom1.dart';
import 'package:palcredits/insurance.dart';
import 'package:palcredits/searckbank.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Bottom extends StatefulWidget {
  final int number;
  const Bottom({
    super.key,
    required this.number,
  });

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.index = widget.number;
  }

  @override
  Widget build(BuildContext context) {
    tabController.index = widget.number;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 71, 123),
        title: const Text(
          'Your Leads',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchBank()),
                );
              },
              child: Container(
                  height: 35,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(255, 27, 124, 203),
                      border: Border.all(color: Colors.black.withOpacity(0.2))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Add Lead',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TabBar(
              controller: tabController,
              indicatorColor: const Color.fromARGB(255, 8, 71, 123),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: const Color.fromARGB(255, 8, 71, 123),
              isScrollable: false,
              unselectedLabelColor: Color.fromARGB(255, 105, 105, 105),
              tabs: const [
                Tab(child: Text('Credit Cards')),
                Tab(child: Text('Insurance')),
                Tab(child: Text('Loans')),
              ]),
          SizedBox(
            height: MediaQuery.of(context).size.height - 140,
            width: double.infinity,
            child: TabBarView(
                controller: tabController,
                children: const [Bottom1(), Insurance(), Insurance()]),
          )
        ],
      ),
    );
  }
}
