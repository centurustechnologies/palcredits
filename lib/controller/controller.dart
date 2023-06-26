import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();


 void storeTokenAndData(username) async {
    print("storing token and data");
    await storage.write(key: "token", value: username.toString());
    log('user number is phone $username');
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }
