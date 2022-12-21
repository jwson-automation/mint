import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String username;
  final String region;
  final String sex; // true is man
  final int age;
  // final Int usernumber;

  const User({
    required this.email,
    required this.uid,
    required this.username,
    required this.region,
    required this.sex,
    required this.age,
    // required this.usernumber,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "uid": uid,
        "username": username,
        "region": region,
        "sex": sex,
        "age": age,
        // "usernumber": usernumber,
      };

  // for provider
  // 원래라면 아래와 같이 데이터를 가져올때 하나씩 맵 데이터라 가져와줘야한다.
  // model.User(
  //     followers: (snap.data() as Map<String, dynamic>)['followers']);
  // 하지만 아래 static을 만들어주면 그냥 가져와서 바로 쓸 수 있다!
  // 리팩토링의 개념!
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      email: snapshot['email'],
      uid: snapshot['uid'],
      username: snapshot['username'],
      region: snapshot['region'],
      sex: snapshot['sex'],
      age: snapshot['age'],
      // usernumber: snapshot['usernumber'],
    );
  }
}
