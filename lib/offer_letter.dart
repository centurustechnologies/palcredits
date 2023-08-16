import 'package:flutter/material.dart';

class OfferLetter extends StatefulWidget {
  const OfferLetter({super.key});

  @override
  State<OfferLetter> createState() => _OfferLetterState();
}

class _OfferLetterState extends State<OfferLetter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          splashRadius: 24,
        ),
        title: Text(
          "Offer Letter",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: Column(
            children: [
              Text(
                'Here you can check Letters',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add button functionality
                },
                child: Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
