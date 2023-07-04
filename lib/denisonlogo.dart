import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DenisonLogo extends StatelessWidget {
  const DenisonLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/denison.png',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
