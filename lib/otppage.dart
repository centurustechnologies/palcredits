import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:lottie/lottie.dart';



class Otp extends StatelessWidget {
  const Otp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'AG Financial Services',
          style: TextStyle(color: Colors.white),
        ),
        //leading: Icon(Icons.cancel,size: 25,),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 40,top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                   // color: Colors.green,
                  child:  Lottie.asset('assets/cccc.json',fit: BoxFit.cover),
                  ),
                ],
              ),
            ) ,
            const Text(
              'Verification Code',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),const SizedBox(height: 12,),
             const Text(
              'Please enter the code below',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 86, 86, 86)),
            ),const SizedBox(height: 70,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OtpTextField(
                  numberOfFields: 5,
                  borderColor: Colors.blue,
                  enabledBorderColor: Colors.blue,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Verification Code"),
                            content: Text('Code entered is $verificationCode'),
                          );
                        });
                  }, // end onSubmit
                ),
              ],
            ),
              Padding(
          padding: const EdgeInsets.only(right: 70,top: 50),
          child: Container(
            decoration: const BoxDecoration( gradient: LinearGradient(
                                  colors: [
                                    Colors.blue,
                                Color.fromARGB(255, 8, 71, 123)
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight),),
            child: MaterialButton(
              onPressed: () {
               
              },
              //color: Colors.blue,
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
         



          ],
        ),
      ),
    );
  }
}
