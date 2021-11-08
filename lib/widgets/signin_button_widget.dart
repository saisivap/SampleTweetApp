import 'package:flutter/material.dart';

class signInButton extends StatelessWidget {
  const signInButton({
    Key? key,
    required this.w,
  }) : super(key: key);

  final double w;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: w * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          const BoxShadow(
            offset: Offset(-5, 5),
            color: Colors.black26,
            blurRadius: 10,
          ),
          BoxShadow(
            offset: const Offset(5, -5),
            color: Colors.grey.shade200.withAlpha(50),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15, right: 15),
            child: Container(
              child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/240px-Google_%22G%22_Logo.svg.png",
                width: 30,
                height: 30,
              ),
            ),
          ),
          // SizedBox(width: 20,),
          const Text(
            "Sigin in with Google",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500
                // decoration: TextDecoration.none,
                ),
          )
        ],
      ),
    );
  }
}
