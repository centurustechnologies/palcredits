import 'package:csv/csv.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:cloud_firestore/cloud_firestore.dart';




class Pdf extends StatefulWidget {
  const Pdf({super.key});

  @override
  State<Pdf> createState() => _PdfState();
}

class _PdfState extends State<Pdf> {



void parseAndSaveCsvData() async {
  final mydata = await rootBundle.loadString(('res/aucompany.csv'));
  List<List<dynamic>> csvTable = CsvToListConverter().convert(mydata);

  CollectionReference dbRef = FirebaseFirestore.instance.collection("aucompany");

   for (var row in csvTable) {
    String COMPANYCODE = row[0].toString();
    String COMPANYNAME = row[1].toString();
    String COMPANY_CATEGORY = row[2].toString();
    
   
    
    // Save the data to Firebase
    await dbRef.add({
      'COMPANYCODE':COMPANYCODE,
      'COMPANYNAME': COMPANYNAME,
      'COMPANY_CATEGORY': COMPANY_CATEGORY,
     
      
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
                onPressed: parseAndSaveCsvData, child: Text('import data'))));
  }
}
