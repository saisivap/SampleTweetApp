import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  String imageUrl;
  ProfileImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
