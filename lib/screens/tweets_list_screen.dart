import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:glints_assignment/constants.dart';
import 'package:glints_assignment/controllers/firebase_controller.dart';
import 'package:glints_assignment/helper/firebase_database.dart';
import 'package:glints_assignment/models/tweet_model.dart';
import 'package:glints_assignment/models/user_model.dart';
import 'package:glints_assignment/screens/create_tweet_screen.dart';
import 'package:glints_assignment/screens/tweet_tile.dart';

import 'package:glints_assignment/widgets/profile_tile.dart';
import 'package:glints_assignment/widgets/tweet_icon.dart';
import 'package:google_fonts/google_fonts.dart';

class TweetsListScreen extends StatefulWidget {
  const TweetsListScreen({Key? key}) : super(key: key);

  @override
  _TweetsListScreenState createState() => _TweetsListScreenState();
}

class _TweetsListScreenState extends State<TweetsListScreen> {
  final firebaseController = Get.put(FirebaseController());
  DatabaseMethods databaseMethods = DatabaseMethods();
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xfff4f8fb),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateTweetScreen()));
        },
        child: TweetIcon(),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Image.network(
            "https://www.reallygoodseo.co.uk/wp-content/uploads/2012/09/twitter-bird-251x300.png",
            height: 60,
            width: 60,
          ),
        ),
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: ProfileImage(
                imageUrl:
                    // "https://learnenglish.britishcouncil.org/sites/podcasts/files/styles/max_325x325/public/2021-10/RS8003_GettyImages-994576028-hig.jpg?itok=m0rIP3zI",
                    firebaseController.firebaseUser.value!.photoURL.toString()),
          ),
          GestureDetector(
            onTap: () {
              firebaseController.google_sign_out();
              // databaseMethods
              //     .getUserInfo(firebaseController.firebaseUser.value!.uid);
              // print("logOut");
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.logout,
                size: 25,
                color: Colors.purple,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          // child: SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       Row(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Expanded(
          //             flex: 2,
          //             child: ProfileImage(
          //               imageUrl:
          //                   "https://learnenglish.britishcouncil.org/sites/podcasts/files/styles/max_325x325/public/2021-10/RS8003_GettyImages-994576028-hig.jpg?itok=m0rIP3zI",
          //             ),
          //           ),
          //           Expanded(
          //             flex: 8,
          //             child: TweetTile(
          //               userName: "Sai Mahesh",
          //               tweet:
          //                   "Rama was born to Kaushalya and Dasharatha in Ayodhya, the ruler of the Kingdom of Kosala. His siblings included Lakshmana, Bharata, and Shatrughna. He married Sita. Though born in a royal family, their life is described in the Hindu texts as one challenged by unexpected changes such as an exile into impoverished and difficult circumstances, ethical questions and moral dilemmas.",
          //               tweetDate: DateTime(2021, 11, 07, 0, 20),
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Expanded(
          //             flex: 2,
          //             child: ProfileImage(
          //               imageUrl:
          //                   "https://learnenglish.britishcouncil.org/sites/podcasts/files/styles/max_325x325/public/2021-10/RS8003_GettyImages-994576028-hig.jpg?itok=m0rIP3zI",
          //             ),
          //           ),
          //           Expanded(
          //             flex: 8,
          //             child: TweetTile(
          //               userName: "Sai Mahesh",
          //               tweet:
          //                   "Rama was born to Kaushalya and Dasharatha in Ayodhya, the ruler of the Kingdom of Kosala.",
          //               tweetDate: DateTime(2021, 11, 07, 0, 20),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),

          child: StreamBuilder<QuerySnapshot>(
            // stream: FirebaseFirestore.instance.collection("tweets").snapshots(),
            stream: FirebaseFirestore.instance.collection("tweets").orderBy("createdAt",descending: true).snapshots(),
            builder: (BuildContext context, tweetSnapshot) {
              if (tweetSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueGrey,
                  ),
                );
              } else {
                final tweetDocs = tweetSnapshot.data!.docs;
                return ListView.builder(
                    itemCount: tweetDocs.length,
                    itemBuilder: (BuildContext context, index) {
                      final tweet = tweetDocs[index];

                      return FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("users")
                              .doc(tweet["createdBy"])
                              .get(),
                          builder: (context,
                              AsyncSnapshot<
                                      DocumentSnapshot<Map<String, dynamic>>>
                                  futureSnapshot) {
                            if (futureSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blueGrey,
                                ),
                              );
                            }
                            if (futureSnapshot.hasData) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: ProfileImage(
                                      imageUrl:
                                          futureSnapshot.data!['profileUrl'],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: TweetTile(
                                      tweetData: tweet,
                                      user: futureSnapshot.data!['username'],
                                      // userName: "Sai Mahesh",
                                      // tweet:
                                      //     "Rama was born to Kaushalya and Dasharatha in Ayodhya, the ruler of the Kingdom of Kosala. His siblings included Lakshmana, Bharata, and Shatrughna. He married Sita. Though born in a royal family, their life is described in the Hindu texts as one challenged by unexpected changes such as an exile into impoverished and difficult circumstances, ethical questions and moral dilemmas.",
                                      // tweetDate: DateTime(2021, 11, 07, 0, 20),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                child: Text("Something went wrong"),
                              );
                            }
                          });
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}
  // ListView.builder(
  //               itemCount: listOfTweets.length,
  //               itemBuilder: (BuildContext context, index) {
  //                 final tweet = listOfTweets[index];
  //                 return Row(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Expanded(
  //                       flex: 2,
  //                       child: ProfileImage(
  //                         imageUrl: tweet.userImageUrl,
  //                       ),
  //                     ),
  //                     Expanded(
  //                       flex: 8,
  //                       child: TweetTile(
  //                         tweetModel: tweet,
  //                         // userName: "Sai Mahesh",
  //                         // tweet:
  //                         //     "Rama was born to Kaushalya and Dasharatha in Ayodhya, the ruler of the Kingdom of Kosala. His siblings included Lakshmana, Bharata, and Shatrughna. He married Sita. Though born in a royal family, their life is described in the Hindu texts as one challenged by unexpected changes such as an exile into impoverished and difficult circumstances, ethical questions and moral dilemmas.",
  //                         // tweetDate: DateTime(2021, 11, 07, 0, 20),
  //                       ),
  //                     ),
  //                   ],
  //                 );
  //               }),
          
// ignore: must_be_immutable

                      