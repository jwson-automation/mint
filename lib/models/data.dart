import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  final likes;
  final age;

  const Data({required this.likes, required this.age});

  Map<String, dynamic> toJson() => {
        "likes": likes,
        "age": age,
        // "usernumber": usernumber,
      };

  static Data fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Data(
      likes: snapshot['likes'],
      age: snapshot['age'],
    );
  }
}
