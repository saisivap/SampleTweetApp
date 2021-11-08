import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glints_assignment/constants.dart';
import 'package:glints_assignment/controllers/firebase_controller.dart';
import 'package:glints_assignment/helper/firebase_database.dart';
import 'package:glints_assignment/models/tweet_model.dart';
import 'package:glints_assignment/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';

class TweetTile extends StatefulWidget {
  QueryDocumentSnapshot<Object?> tweetData;
  String user;
  // String userName;
  // String tweet;
  // DateTime tweetDate;
  TweetTile({
    Key? key,
    required this.tweetData,
    required this.user,
    // required this.userName,
    // required this.tweet,
    // required this.tweetDate,
  }) : super(key: key);

  @override
  State<TweetTile> createState() => _TweetTileState();
}

class _TweetTileState extends State<TweetTile> {
  final firebaseController = Get.put(FirebaseController());
  DatabaseMethods databaseMethods = DatabaseMethods();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        // width: w*0.7,
        // height: h * 0.25,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(10, 30),
                color: Colors.grey.withAlpha(30),
                blurRadius: 30)
          ],
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.user,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Color(0xff2a2f35),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.done_outline_sharp,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 20,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        calHoursDaysWeeksAndYears(
                            (widget.tweetData['createdAt']).toDate()),

                        // (widget.tweetData['createdAt']).toDate().toString(),

                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              child: Text(
                widget.tweetData['tweet'],
                style: GoogleFonts.openSans(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            widget.tweetData['createdBy'] ==
                    firebaseController.firebaseUser.value!.uid
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          databaseMethods.getTweet(widget.tweetData['docId']);
                          Get.back();
                        },
                        child: Icon(
                          Icons.edit,
                          size: 20,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          // databaseMethods
                          //     .deleteTweet(widget.tweetData['docId']);
                          Get.defaultDialog(
                            title: "Delete",
                            content: Text(
                              "Are you sure ?",
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  databaseMethods
                                      .deleteTweet(widget.tweetData['docId']);
                                      Get.back();
                                },
                                child: Text(
                                  "Yes",
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // databaseMethods
                                  //     .getTweet(widget.tweetData['docId']);
                                  Get.back();
                                },
                                child: Text(
                                  "No",
                                ),
                              )
                            ],
                          );
                        },
                        child: Icon(
                          Icons.delete,
                          size: 20,
                        ),
                      )
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
