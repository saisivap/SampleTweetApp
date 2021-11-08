// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:glints_assignment/helper/firebase_database.dart';
import 'package:glints_assignment/screens/tweets_list_screen.dart';
import 'package:glints_assignment/sign_in_screen.dart';

import 'package:google_sign_in/google_sign_in.dart';

class FirebaseController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  DatabaseMethods databaseMethods = DatabaseMethods();
  // User user=User.obs;
  Rxn<User> firebaseUser = Rxn<User>();

  void google_sign_in() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    await _auth.signInWithCredential(credential).then(
      (value) {
        print(firebaseUser.value);
        final User? user = value.user;
        print(user);
        print(user!.uid);
        Map<String, String?> userInfoMap = {
          "uid": user.uid,
          "username": user.displayName,
          "email": user.email,
          "profileUrl": user.photoURL
        };
        firebaseUser.value = user;
        databaseMethods.uploadUserInfo(userInfoMap, user.uid);
        Get.offAll(TweetsListScreen());
      },
    );
  }

  void google_sign_out() async {
    await googleSignIn.signOut().then((value) {
      print(value);
      Get.offAll(SignInScreen());
    });
  }
}
