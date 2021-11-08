import 'package:flutter/material.dart';

class TweetIcon extends StatelessWidget {
  const TweetIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            "https://cdn1.iconfinder.com/data/icons/twitter-ui-glyph/48/Sed-17-512.png",
          ),
        ),
      ),
    );
  }
}
