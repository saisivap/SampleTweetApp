class UserModel {
  String email;
  String profileUrl;
  String uid;
  String username;
  UserModel({
    required this.email,
    required this.profileUrl,
    required this.uid,
    required this.username,
  });

  factory UserModel.fromMap(Map<String, dynamic>? data) {
    return UserModel(
      email: data!['email'],
      profileUrl: data['profileUrl'],
      uid: data['uid'],
      username: data['username'],
    );
  }
  factory UserModel.fromJson(Map<dynamic, dynamic> parsedJson) {
    return UserModel(
        uid: parsedJson['uid'].toString(),
        username: parsedJson['username'].toString(),
        email: parsedJson['email'].toString(),
        profileUrl: parsedJson['profileUrl'].toString());
  }
}
