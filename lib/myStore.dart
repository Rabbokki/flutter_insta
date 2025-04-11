import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MyStore extends ChangeNotifier {
  var name = 'JJJzz';
  var follower = 0;
  var friend = false;

  List<dynamic> profileImage = [];

  getData() async{
    var result = await http.get(Uri.parse('https://zzzmini.github.io/js/profile.json')
    );
    List<dynamic> userDetailData = jsonDecode(result.body);
    profileImage = userDetailData;
    notifyListeners();
  }

  changeName() {
    name = '장원영';
    notifyListeners();
  }

  changeFollower() {
    if (!friend) {
      follower++;
      friend = true;
    } else {
      follower--;
      friend = false;
    }
    notifyListeners();
  }
}
