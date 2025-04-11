import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instagram/myStore.dart';
import 'package:instagram/upload.dart';
import 'dart:convert';
import 'home.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
        create: (c)=> MyStore(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  // 카메라 사진을 담을 변수
  var userImage;
  // 업로드 화면에서 보낸 내용
  var newContent;

  //로컬 저장 영역 테스트
  localStorageTest() async{
    var storage = await SharedPreferences.getInstance();

    storage.setString('name', '장원영');
    var myName = storage.get('name');
    print('name = ${myName}');

    //배열 저장
    storage.setStringList('list', ['jang','lee']);
    var myList = storage.get('list');
    print('list = ${myList}');

    //삭제 처리
    storage.remove('name');

    //전체 저장 공간 지우기
    storage.clear();

    //맵 자료 저장하기
    //map = {'name' : 'JJJ'}
    var testMap = {'name' : 'JJJ' , 'age' : 24};
    storage.setString('JJJ', jsonEncode(testMap));
    var encode = storage.get('JJJ');

    var decode = jsonDecode(encode.toString());

    print('map data : ${decode}');
  }

  setNewContent(content){
    setState(() {
      newContent = content;
    });
  }

  addMyData(){
    DateTime now = DateTime.now();
    // 형식 지정
    var date = DateFormat('MMMM dd').format(now);

    var myData = {
      "id" : data.length,
      "user": "zzzmini",
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

  // 홈에서 보낸 추가 데이터를 data에 추가하기
  addData(addContents){
    setState(() {
      data.addAll(addContents);
    });
  }


  // 데이터 가져오기
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
      } else {
        print('Error : ${result.statusCode}');
      }
    } catch (e){
      print('예외 : $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    //로컬 스토리지 테스트
    localStorageTest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(
            onPressed: () async{
              // 카메라에 사진 찾기
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery);

              setState(() {
                if(image != null){
                  userImage = File(image.path);
                  print(userImage);
                }
              });

              // 사진 업로드 화면 보이기
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context)=>
                          UpLoad(
                              userImage : userImage,
                              setNewContent : setNewContent,
                              addMyData : addMyData
                          )
                  )
              );
            },
            icon: Icon(Icons.add_box_outlined),
            iconSize: 30,)
        ],
      ),
      body:
      [
        Home(data : data, addData : addData),
        Text('Shop')
      ][tab],

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