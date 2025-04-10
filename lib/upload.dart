import 'package:flutter/material.dart';

class UpLoad extends StatelessWidget {
  UpLoad({super.key, this.userImage, this.setNewContent});
  final userImage;
  final setNewContent;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){

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
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.c))
        ],
      ),
    );
  }
}
