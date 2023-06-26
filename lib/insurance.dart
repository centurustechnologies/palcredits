import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

class Insurance extends StatelessWidget {
  const Insurance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 140,
          ),
          SizedBox(
            height: 210,
            width: double.infinity,
            child: Center(
              child: Lottie.asset('assets/soon.json',
                  fit: BoxFit.cover, repeat: true),
            ),
          ),
        ],
      ),
    );
  }
}
