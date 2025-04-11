import 'package:flutter/material.dart';
import 'package:instagram/myStore.dart';
import 'package:instagram/profileHeader.dart';
import 'package:provider/provider.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({super.key});

  @override
  Widget build(BuildContext context) {

    final getStore = context.watch<MyStore>();
    final setStore = context.read<MyStore>();

    return Scaffold(
      appBar: AppBar(
        title: Text('${context.watch<MyStore>().name}님'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ProfileHeader(),
            ),
            SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                      Image.network(getStore.profileImage[index]),
                  childCount: getStore.profileImage.length
                ),
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                   mainAxisSpacing: 10,
                   crossAxisSpacing: 10
                 )
            )
          ],
        ),
      )
    );
  }
}



