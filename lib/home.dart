import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  const Home({super.key, this.data, this.addData});

  final data;
  final addData;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //현재 스크롤 위치 파악 컨트롤러
  var scroll = ScrollController();
  var first = 0;

  @override
  void initState() {
    super.initState();
    scroll.addListener((){
      print('현재 위치 : ${scroll.position.pixels}');
      print('스크롤 방향 : ${scroll.position.userScrollDirection}');
      print('맨밑 : ${scroll.position.maxScrollExtent}');
      if(scroll.position.pixels == scroll.position.maxScrollExtent){
        if(first == 0){
          getMore();
          first = 1;
        }
      }
    });
  }


  getMore() async{
    try{
      var result = await http.get(
          Uri.parse('https://zzzmini.github.io/js/instar_data_add.json')
      );
      if(result.statusCode == 200){
        var instaData = jsonDecode(result.body);
        widget.addData(instaData);
      }else{
        print('Error : ${result.statusCode}');
      }
    }catch(e){
      print('예외 : $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    if(widget.data.isNotEmpty){
      return
        ListView.builder(
          controller: scroll,
            itemCount: widget.data.length,
            itemBuilder: (context, index){
              return Column(
                children: [
                  Image.network(widget.data[index]['image']),
                  Container(
                    constraints: BoxConstraints(maxWidth: 600),
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('좋아요 ${widget.data[index]['likes']}'),
                        Text('글쓴이 ${widget.data[index]['user']}'),
                        Text('글내용 ${widget.data[index]['content']}'),
                      ],
                    ),
                  )
                ],
              );
            });
    }else{
      return Text('로딩중');
    }
  }
}