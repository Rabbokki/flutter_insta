import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //메인 페이지 시작되면.... 게시글 읽어서 뿌려주기


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 1,
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
              actionsIconTheme: IconThemeData(color: Colors.black)
          )
      ),
      home: Instagram(),
    );
  }
}

class Instagram extends StatefulWidget {
  const Instagram({super.key});

  @override
  State<Instagram> createState() => _InstagramState();
}

class _InstagramState extends State<Instagram> {
  // 변수 선언 -> setState() 변경
  var tab = 0;
  var data = [];
  //카메라 사진 변수
  var UserImage;

  //화면에서 보낸 내용
  var newContent;

  setUserNewContent(content){
    setState(() {
      newContent = content;
    });
  }

  addMyData(){
    DateTime now = DateTime.now();
    var date = DateFormat('MMMM dd').format(now);
    var myData = {
      "id": 0,
      "user": "나",
      "image": userImage,
      "likes": 0,
      "date": date,
      "liked": "false",
      "content": newContent
    };
    setState(() {
      data.insert(0, myData);
    });
  }

  //홈에서 보낸 추가 데이터를 data에 추가하기
  addData(addContents){
    setState(() {
      data.addAll(addContents);
    });
  }


  //데이터 가져오기
  getData() async{
    try{
      var result = await http.get(
        Uri.parse('https://zzzmini.github.io/js/instar_data.json')
      );
      if(result.statusCode == 200){
        var instaData = jsonDecode(result.body);
        setState(() {
          data = instaData;
        });
      }else{
        print('Error : ${result.statusCode}');
      }
    }catch(e){
      print('예외 : $e');
    }
  }
  @override
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.add_box_outlined),
            iconSize: 30,)
        ],
      ),
      body:
      [
        Home(data : data, addData : addData),
        Text('Shop')
      ]
      [tab],

      bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            setState(() {
              tab = index;
              print(tab);
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: 'Shop'
            ),
          ]
      ),
    );
  }
}