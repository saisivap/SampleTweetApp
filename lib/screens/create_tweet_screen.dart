import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glints_assignment/controllers/firebase_controller.dart';
import 'package:glints_assignment/helper/firebase_database.dart';
import 'package:glints_assignment/widgets/profile_tile.dart';
import 'package:glints_assignment/widgets/tweet_icon.dart';

class CreateTweetScreen extends StatefulWidget {
  const CreateTweetScreen({Key? key}) : super(key: key);

  @override
  _CreateTweetScreenState createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends State<CreateTweetScreen> {
  final firebaseController = Get.put(FirebaseController());
  DatabaseMethods databaseMethods = DatabaseMethods();
  final TextEditingController tweetController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  tweetingMethod() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print(
        firebaseController.firebaseUser.value!.uid,
      );
      Map<String, dynamic> tweetInfo = {
        "docId": firebaseController.firebaseUser.value!.uid +
            DateTime.now().millisecondsSinceEpoch.toString(),
        "tweet": tweetController.text,
        "createdBy": firebaseController.firebaseUser.value!.uid,
        "createdAt": DateTime.now(),
      };
      try {
        databaseMethods.createTweet(
          tweetInfo,
          firebaseController.firebaseUser.value!.uid +
              DateTime.now().millisecondsSinceEpoch.toString(),
        );
        Get.back();
        Get.snackbar("Successful", "Succcessfully posted a TWEET");
      } catch (e) {
        Get.snackbar("Warning", "Something went wrong to TWEET");
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 1,
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          title: const Text(
            "New Tweet",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ProfileImage(
                      imageUrl:
                          // "https://learnenglish.britishcouncil.org/sites/podcasts/files/styles/max_325x325/public/2021-10/RS8003_GettyImages-994576028-hig.jpg?itok=m0rIP3zI",
                          firebaseController.firebaseUser.value!.photoURL
                              .toString(),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xfff2f2f4),
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: tweetController,
                            validator: (value) {
                              if (value!.length == 0) {
                                return "must write something to tweet";
                              } else {
                                return null;
                              }
                            },
                            maxLength: 280,
                            maxLines: 7,
                            autofocus: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.1,
              ),
              GestureDetector(
                onTap: () {
                  tweetingMethod();
                  print(tweetController.text);
                },
                child: TweetButton(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TweetButton extends StatelessWidget {
  const TweetButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(
          colors: [
            Color(0XFF1DA1F3),
            Color(0XFF20A1F2),
            Color(0XFF28A6F3),
            Color(0XFF33ABF4)
          ],
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweetIcon(),
            Text(
              "Tweet Now",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
