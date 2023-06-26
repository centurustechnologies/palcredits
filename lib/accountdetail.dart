import 'package:palcredits/mainhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import 'controller/controller.dart';

class AccountDetail extends StatefulWidget {
  final String bankname;
  final String cardtype;

  const AccountDetail({
    super.key,
    required this.bankname,
    required this.cardtype,
  });

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  bool detail = false;
  String? gender;
  String? gender1;
  bool hascard = false;
  bool selfemploy = true;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController mothernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController currentadressController = TextEditingController();
  TextEditingController currentadressController1 = TextEditingController();
  
  TextEditingController landmarkController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController officeController = TextEditingController();

  TextEditingController companynameController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  TextEditingController yearlyreturndetailsController = TextEditingController();
  TextEditingController grossmonthlyincomeController = TextEditingController();
  TextEditingController existingcardController = TextEditingController();
  TextEditingController existingbankController = TextEditingController();
  TextEditingController existinglimitController = TextEditingController();
  TextEditingController existingvintageController = TextEditingController();
  TextEditingController mortagepaymentController = TextEditingController();

  String area = '';
  String name='';
  Future getadmindata(String id) async {
    await FirebaseFirestore.instance
        .collection('agents')
        .doc(id)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          area = value.get('location');
          name = value.get('name');
        });
      }
    });
  }

  Future<void> userlead() async {
    await FirebaseFirestore.instance.collection('leads').add({
      'token': localtoken,
      'location': area,
      'Bank_name': widget.bankname,
      'card_type': widget.cardtype,
      'userid': name,
      'lead_id': '',
      'application_status': 'Pending',
      'first_name': ("${firstnameController.text} ${lastnameController.text}"),
      'last_name': "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
      'Date_of_birth': dobController.text,
      'mother_name': mothernameController.text,
      'email': emailController.text,
      'mobile_number': mobilenumberController.text,
      'national_id': idController.text,
      'current_adress':
          ("${currentadressController.text},${currentadressController1.text}"),
      'landmark': landmarkController.text,
      'state':stateController.text,
      'companyname': companynameController.text,
      'work_place': officeController.text,
      'pin_code': pincodeController.text,
      'Designation': designationController.text,
      'yearly_return_details': yearlyreturndetailsController.text,
      'gross_monthly_icome': grossmonthlyincomeController.text,
      'existing_card_holder': existingcardController.text,
      'existing_card_bank_name': existingbankController.text,
      'existing_card_limit': existinglimitController.text,
      'existing_card_vintage': existingvintageController.text,
      'mortage_payment': mortagepaymentController.text,
    }).whenComplete(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainHome()),
      );
    });
  }

  String? selectedValue1;
  final List<String> items1 = [
    'Salaried',
    'Self Employed',
    'Other',
  ];

  //static const storage = FlutterSecureStorage();

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

  DateTime selectedDate = DateTime(2003, 1);
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2003, 1));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dobController.text =
            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 8, 71, 123),
          title: const Text(
            'Credit Card application form',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        body: ListView(children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: Text(
              'Personal Informations',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.9)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              children: [
                Text(
                  "Title",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.4)),
                ),
                const Text(
                  '*',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  height: 35,
                  child: RadioListTile(
                    title: const Text("Mr."),
                    value: "Mr.",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 120,
                  height: 35,
                  child: RadioListTile(
                    title: const Text("Mrs."),
                    value: "Mrs.",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 15),
            child: Row(
              children: [
                Text(
                  "Name",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.4)),
                ),
                const Text(
                  '*',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Container(
                  height: 40,
                  width: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(255, 102, 100, 100)
                                .withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 1)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 6),
                    child: TextField(
                      controller: firstnameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "First name",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Container(
                  height: 40,
                  width: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(255, 102, 100, 100)
                                .withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 1)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 6),
                    child: TextField(
                      controller: lastnameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "last name",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              children: [
                Text(
                  "Marital Status",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.4)),
                ),
                const Text(
                  '*',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  width: 150,
                  height: 35,
                  child: RadioListTile(
                    title: const Text("Married"),
                    value: "Married",
                    groupValue: gender1,
                    onChanged: (value) {
                      setState(() {
                        gender1 = value.toString();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 170,
                  height: 35,
                  child: RadioListTile(
                    title: const Text("Unmarried"),
                    value: "Unmarried",
                    groupValue: gender1,
                    onChanged: (value) {
                      setState(() {
                        gender1 = value.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          //info('Date Of Birth', 'Enter', dobController),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Text(
                        'Pick DOB',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.4)),
                      ),
                      const Text(
                        '*',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(255, 102, 100, 100)
                                  .withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 6),
                      child: TextField(
                        onTap: () {
                          _selectDate(context);
                        },
                        controller: dobController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Select Dob',
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          info(
              'Mother Name',
              'Enter',
              mothernameController,
              TextInputType.emailAddress,
              [LengthLimitingTextInputFormatter(30)]),
          info('Email', 'Enter', emailController, TextInputType.emailAddress,
              [LengthLimitingTextInputFormatter(30)]),
          info('Mobile Number', 'Enter number', mobilenumberController,
              TextInputType.number, [LengthLimitingTextInputFormatter(10)]),

          info('Pan Number', 'Enter', idController, TextInputType.emailAddress,
              [LengthLimitingTextInputFormatter(30)]),
          info('Pin Code', 'Enter', pincodeController, TextInputType.number,
              [LengthLimitingTextInputFormatter(6)]),
          info(
              'House and Street Number',
              'Enter no.',
              currentadressController,
              TextInputType.emailAddress,
              [LengthLimitingTextInputFormatter(50)]),

          info(
              'Landmark',
              'Enter',
              landmarkController,
              TextInputType.emailAddress,
              [LengthLimitingTextInputFormatter(30)]),
          info(
              'City Name',
              'Enter no.',
              currentadressController1,
              TextInputType.emailAddress,
              [LengthLimitingTextInputFormatter(30)]),

          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Container(
                  height: 40,
                  width: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(255, 102, 100, 100)
                                .withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 1)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 6),
                    child: TextField(
                      controller: stateController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "State",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Container(
                  height: 40,
                  width: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(255, 102, 100, 100)
                                .withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 1)
                      ]),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 6),
                    child: TextField(
                      //controller: placeofbirthController,

                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Country",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: Text(
              'Financial Informations',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.9)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              children: [
                Text(
                  "Are You a",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.4)),
                ),
                const Text(
                  '*',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Container(
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: const Color.fromARGB(255, 102, 100, 100)
                            .withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                      'Select source of income',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                    ),
                    items: items1
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue1,
                    onChanged: (value) {
                      setState(() {
                        selectedValue1 = value as String;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),

          info(
              'Company Name',
              'Enter',
              companynameController,
              TextInputType.emailAddress,
              [LengthLimitingTextInputFormatter(30)]),
          info(
              'Designation',
              'Enter',
              designationController,
              TextInputType.emailAddress,
              [LengthLimitingTextInputFormatter(30)]),
          info(
              'Office Adress',
              'Enter',
              officeController,
              TextInputType.emailAddress,
              [LengthLimitingTextInputFormatter(50)]),

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              children: [
                Text(
                  "Existing card holder",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.4)),
                ),
                const Text(
                  '*',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  width: 130,
                  height: 35,
                  child: RadioListTile(
                    title: const Text("Yes"),
                    value: "Yes",
                    groupValue: gender1,
                    onChanged: (value) {
                      setState(() {
                        gender1 = value.toString();
                        hascard = true;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 130,
                  height: 35,
                  child: RadioListTile(
                    title: const Text("No"),
                    value: "No",
                    groupValue: gender1,
                    onChanged: (value) {
                      setState(() {
                        gender1 = value.toString();
                        hascard = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          hascard
              ? info(
                  'Existing card Bank Name',
                  'Enter',
                  existingbankController,
                  TextInputType.emailAddress,
                  [LengthLimitingTextInputFormatter(30)])
              : selectedValue1 == 'Self Employed'
                  ? info(
                      'Gross Income',
                      'Enter',
                      grossmonthlyincomeController,
                      TextInputType.emailAddress,
                      [LengthLimitingTextInputFormatter(30)])
                  : info(
                      'Net Monthly Income',
                      'Enter',
                      grossmonthlyincomeController,
                      TextInputType.emailAddress,
                      [LengthLimitingTextInputFormatter(30)]),
          hascard
              ? info(
                  'Existing card limit',
                  'Enter',
                  existinglimitController,
                  TextInputType.emailAddress,
                  [LengthLimitingTextInputFormatter(30)])
              : info(
                  'Yearly Return Detail',
                  'Enter',
                  yearlyreturndetailsController,
                  TextInputType.emailAddress,
                  [LengthLimitingTextInputFormatter(30)]),
          hascard
              ? info(
                  'Existing card vintage',
                  'Enter',
                  existingvintageController,
                  TextInputType.emailAddress,
                  [LengthLimitingTextInputFormatter(30)])
              : selectedValue1 == 'Self Employed'
                  ? const SizedBox(
                      height: 1,
                      width: 1,
                    )
                  : info(
                      'Salary slip',
                      'Enter',
                      existingvintageController,
                      TextInputType.emailAddress,
                      [LengthLimitingTextInputFormatter(30)]),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                    colors: [Colors.blue, Color.fromARGB(255, 8, 71, 123)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight),
              ),
              child: MaterialButton(
                onPressed: () {
                  if (firstnameController.text.isNotEmpty &&
                      dobController.text.isNotEmpty &&
                      mothernameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      mobilenumberController.text.isNotEmpty &&
                      idController.text.isNotEmpty &&
                      currentadressController.text.isNotEmpty &&
                      landmarkController.text.isNotEmpty &&
                      companynameController.text.isNotEmpty &&
                      designationController.text.isNotEmpty &&
                      idController.text.isNotEmpty) {
                    getadmindata(localtoken);
                    dialog(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Please fill all mandatory fields'),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  }
                },
                //color: Colors.blue,
                height: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]));
  }

  dialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 250,
                    width: 300,
                    child: Lottie.asset('assets/conform.json',
                        fit: BoxFit.cover, repeat: true),
                  ),
                ),
                const Text(
                  "You'r all set!",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    'Click ok button to submit application of Applicant',
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 94, 94, 94),
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 250,
                  child: MaterialButton(
                    onPressed: () {
                      userlead();
                    },
                    color: Color.fromARGB(255, 4, 53, 94),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 80),
                      child: Text(
                        'ok',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  info(name, name1, control, type, length) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.4)),
                ),
                const Text(
                  '*',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: const Color.fromARGB(255, 102, 100, 100)
                            .withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1)
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 6),
                child: TextField(
                  controller: control,
                  keyboardType: type,
                  //maxLength: length,
                  expands: false,
                  //maxLengthEnforcement: false,
                  inputFormatters: length,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: name1,
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.7), fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
