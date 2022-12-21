import 'package:cloud_firestore/cloud_firestore.dart';

class Constants {
  final user;

  const Constants({
    required this.user,
  });

  Map<String, dynamic> toJson() => {
        "user": user,
      };

  // for provider
  // 원래라면 아래와 같이 데이터를 가져올때 하나씩 맵 데이터라 가져와줘야한다.
  // model.Constants(
  //     followers: (snap.data() as Map<String, dynamic>)['followers']);
  // 하지만 아래 static을 만들어주면 그냥 가져와서 바로 쓸 수 있다!
  // 리팩토링의 개념!
  static Constants fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Constants(
      user: snapshot['user'],
    );
  }
}
