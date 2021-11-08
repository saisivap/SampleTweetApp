import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glints_assignment/models/user_model.dart';

class DatabaseMethods {
  uploadUserInfo(Map<String, String?> userInfo, String uid) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(userInfo)
        .catchError((e) {
      print(e.toString());
    });
  }

  createTweet(Map<String, dynamic> tweetInfo, String docId) {
    FirebaseFirestore.instance
        .collection("tweets")
        .doc(docId)
        .set(tweetInfo)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future getTweets() async {
    List listOfTweets = [];
    try {
      await FirebaseFirestore.instance
          .collection("tweets")
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) {
          final tweet = element.data();
          // print(DateTime.fromMillisecondsSinceEpoch(tweet![''] * 1000),);
          listOfTweets.add(tweet);
        });
      });
      // print(listOfTweets);
      return listOfTweets;
    } catch (e) {
      e.toString();
      return null;
    }
  }

  // getUserInfo(String uid) {
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(uid)
  //       .snapshots()
  //       .map((snapshot) {
  //     print(snapshot.data());
  //     UserModel.fromMap(
  //       snapshot.data(),
  //     );
  //   });
  // }
  getUserInfo(String uid) async {
    // late UserModel user;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      final UserModel user =
          UserModel.fromJson(snapshot.data()! as Map<dynamic, dynamic>);
      print(user.username);
      return user;
      // print(user.email);
    });
  }

  deleteTweet(String docId) async {
    await FirebaseFirestore.instance.collection("tweets").doc(docId).delete();
  //  final sampleData= await FirebaseFirestore.instance
  //       .collection("tweets")
  //       .where("docId", isEqualTo: docId).get();
  //   print(sampleData.docs.length);
  }

  DocumentSnapshot<Map<String, dynamic>>? getTweet(String docId) {
    Map<String, dynamic>? tweet;
    print(docId);
    FirebaseFirestore.instance
        .collection("tweets")
        .doc("R8CCkqGq1rMeBqsYl7yDn2aicO622021-11-08 13:49:41.326103")
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      tweet = snapshot.data();
      print(tweet);
      tweet!['tweet'];
    });
  }
}
