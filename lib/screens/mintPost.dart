import 'package:flutter/material.dart';
import 'package:mint/utils/colors.dart';
import 'package:provider/provider.dart';

import '../models/user.dart' as model;
import '../provider/user_provider.dart';
import '../resources/like_methods.dart';
import '../resources/userCheck.dart';

class MintPost extends StatefulWidget {
  final snap;
  const MintPost({Key? key, required this.snap}) : super(key: key);

  @override
  State<MintPost> createState() => _MintPostState();
}

class _MintPostState extends State<MintPost> {
  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;
    final currentUseruid = authManage().getUser()!.uid;
    int _mintlength = widget.snap['likes'].length;

    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text("민초단 : ${_mintlength}"),
          ),
          Container(
            width: _mintlength + 100,
            height: _mintlength + 100,
            decoration: BoxDecoration(border: Border.all(color: mintColor)),
          ),
          IconButton(
            icon: Icon(Icons.abc),
            onPressed: () => print(widget.snap['postId']),
          ),
          IconButton(
            onPressed: () async {
              await FirestoreMethods().likePost(widget.snap['postId'],
                  currentUseruid, widget.snap['likes'], true);
            },
            icon: widget.snap['likes'].contains(currentUseruid)
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.favorite_border,
                  ),
          ),
        ],
      ),
    );
  }
}
