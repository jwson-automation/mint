import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mint/models/user.dart' as model;
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import '../utils/colors.dart';
import 'ConstantsPost.dart';
import 'mintPost.dart';

class MintPage extends StatelessWidget {
  const MintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20),
          child: Image.asset(
            'mint_logo.png',
            width: 350,
          ),
        ),

        Flexible(
          flex: 1,
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('constants').snapshots(),
            // 특정 문서만 가져올때는 아래와 같이
            // FirebaseFirestore.instance.collection('posts').doc(여기에 원하는 문서).snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState != ConnectionState.active) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => ConstantsPost(
                  snap: snapshot.data!.docs[index].data(),
                ),
              );
            },
          ),
        ),

        //어택바
        Container(
          width: double.infinity,
          height: 1,
          decoration: BoxDecoration(border: Border.all(color: mintColor)),
        ),

        Expanded(
          flex: 9,
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('mintPost').snapshots(),
            // 특정 문서만 가져올때는 아래와 같이
            // FirebaseFirestore.instance.collection('posts').doc(여기에 원하는 문서).snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState != ConnectionState.active) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => MintPost(
                  snap: snapshot.data!.docs[index].data(),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
