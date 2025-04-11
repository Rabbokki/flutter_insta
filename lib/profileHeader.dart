import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'myStore.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.green,
        ),
        Text('팔로워 ${context.watch<MyStore>().follower}명'),
        _button(
            label: '팔로워 ${context.watch<MyStore>().follower} 명',
            onPress: () => {
              context.read<MyStore>().changeFollower()
            }
        ),
        _button(
            label: '사진 가져오기',
            onPress: () => {
              context.read<MyStore>().getData()
            }
        )
      ],
    );
  }
}

Widget _button({required String label, required VoidCallback onPress}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero
          )
      ),
      onPressed: onPress,
      child: Text(label)
  );
}
