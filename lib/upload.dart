import 'package:flutter/material.dart';

class UpLoad extends StatelessWidget {
  UpLoad({super.key, this.userImage, this.setNewContent, this.addMyData});
  final userImage;
  final setNewContent;
  final addMyData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 키보드가 화면 일부를 가리도록 허용
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            addMyData();
            Navigator.pop(context);
          },
              icon: Icon(Icons.send))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(userImage),
          Text('이미지 업로드 화면'),
          TextField(
            onChanged: (text){setNewContent(text);},
          ),
          IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.close))
        ],
      ),
    );
  }
}