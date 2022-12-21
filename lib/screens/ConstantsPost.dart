import 'package:flutter/material.dart';
import 'package:mint/utils/colors.dart';
import 'package:provider/provider.dart';

import '../models/user.dart' as model;
import '../provider/user_provider.dart';
import '../resources/like_methods.dart';
import '../resources/userCheck.dart';

class ConstantsPost extends StatefulWidget {
  final snap;
  const ConstantsPost({Key? key, required this.snap}) : super(key: key);

  @override
  State<ConstantsPost> createState() => _ConstantsPostState();
}

class _ConstantsPostState extends State<ConstantsPost> {
  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;
    final currentUseruid = authManage().getUser()!.uid;

    return Flexible(
      child: Center(
        child: Container(
          // width: 50,
          // height: 50,
          child: Text("현재까지 가입자 수 : ${widget.snap['user'].length}"),
        ),
      ),
    );
  }
}
